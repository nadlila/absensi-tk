import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AbsensiGuruScreen extends StatefulWidget {
  const AbsensiGuruScreen({super.key});

  @override
  State<AbsensiGuruScreen> createState() => _AbsensiGuruScreenState();
}

class _AbsensiGuruScreenState extends State<AbsensiGuruScreen> {
  int? idUser;
  Map<String, dynamic>? guruLogin;
  List statusList = [];
  Map<String, dynamic>? selectedStatus;
  int? idTahunAjaran;

  // Controller untuk input alasan izin/sakit
  final TextEditingController _alasanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _alasanController.dispose();
    super.dispose();
  }

  // ===== INIT DATA =====
  Future<void> initData() async {
    await getUser();
    await fetchGuruLogin();
    await fetchStatus();
    await fetchTahunAjaranAktif();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getInt("idUser");
    });
  }

  Future<void> fetchGuruLogin() async {
    if (idUser == null) return;
    final res = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/guru/user/$idUser"),
    );
    if (res.statusCode == 200) {
      setState(() {
        guruLogin = jsonDecode(res.body);
      });
    }
  }

  Future<void> fetchStatus() async {
    final res = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/status-absensi"),
    );
    if (res.statusCode == 200) {
      List allStatus = jsonDecode(res.body);
      setState(() {
        statusList = allStatus
            .where((s) => s["namaStatus"].toString().toLowerCase() != "alpa")
            .toList();
      });
    }
  }

  Future<void> fetchTahunAjaranAktif() async {
    try {
      final res = await http.get(
        Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran/aktif"),
      );
      if (res.statusCode == 200 && res.body.isNotEmpty) {
        final data = jsonDecode(res.body);
        setState(() {
          idTahunAjaran = data['idTahunAjaran'];
        });
      }
    } catch (e) {
      print("Error ambil tahun ajaran: $e");
    }
  }

  String getNamaHari() {
    List<String> hari = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"];
    return hari[DateTime.now().weekday - 1];
  }

  String getTanggalFormat() {
    DateTime now = DateTime.now();
    List<String> bulan = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
    String day = now.day.toString().padLeft(2, '0');
    return "$day ${bulan[now.month - 1]} ${now.year}";
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> submitAbsensi() async {
    if (guruLogin == null) {
      _showError("Data Guru belum dimuat");
      return;
    }

    if (selectedStatus == null) {
      _showError("Silakan pilih status (Hadir/Izin/Sakit)");
      return;
    }

    // Validasi Alasan jika Izin atau Sakit
    String statusNama = selectedStatus!["namaStatus"].toString().toLowerCase();
    if ((statusNama == "izin" || statusNama == "sakit") && _alasanController.text.trim().isEmpty) {
      _showError("Harap isi alasan $statusNama terlebih dahulu");
      return;
    }

    if (idTahunAjaran == null) {
      _showError("Admin belum menentukan Tahun Ajaran Aktif");
      return;
    }

    final now = DateTime.now();
    final currentTime = now.hour + (now.minute / 60.0);

    // Pengecekan waktu hanya untuk status Hadir
    if (statusNama == "hadir") {
      if (currentTime < 7.0) {
        _showError("Absensi belum dibuka. Silakan kembali pukul 07:00.");
        return;
      }
      if (currentTime > 8.5) {
        _showError("Batas waktu absensi sudah berakhir (jam 08:30).");
        return;
      }
    }

    try {
      final res = await http.post(
        Uri.parse("http://10.0.2.2:8080/api/absensi-guru"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "guru": {"idGuru": guruLogin!["idGuru"]},
          "tanggal": DateTime.now().toIso8601String().substring(0, 10),
          "status": {"idStatus": selectedStatus!["idStatus"]},
          "idTahunAjaran": idTahunAjaran,
          "alasan": _alasanController.text.trim(), // Mengirim data ke kolom 'alasan'
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Absensi Berhasil Disimpan"), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      } else {
        final errorData = jsonDecode(res.body);
        _showError(errorData['message'] ?? "Gagal menyimpan absensi");
      }
    } catch (e) {
      _showError("Terjadi kesalahan koneksi ke server");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan apakah form alasan harus muncul
    bool showAlasanField = false;
    if (selectedStatus != null) {
      String nama = selectedStatus!["namaStatus"].toString().toLowerCase();
      if (nama == "izin" || nama == "sakit") {
        showAlasanField = true;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Absen Guru", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: const Color(0xFFB6DEE8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: (guruLogin == null || statusList.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text("${getNamaHari()}, ${getTanggalFormat()}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeCard("Jam Masuk", "07.00"),
                  _buildTimeCard("Jam Pulang", "11.00"),
                ],
              ),
              const SizedBox(height: 30),
              const Text("Status Kehadiran", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              DropdownButtonFormField<Map<String, dynamic>>(
                hint: const Text("Pilih Status"),
                value: selectedStatus,
                items: statusList.map((s) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: s,
                    child: Text(s["namaStatus"]),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedStatus = val;
                    if (val != null && val["namaStatus"].toString().toLowerCase() == "hadir") {
                      _alasanController.clear();
                    }
                  });
                },
                decoration: _inputDecoration(),
              ),

              // FORM TULIS KETERANGAN/ALASAN (Hanya muncul jika Izin/Sakit)
              if (showAlasanField) ...[
                const SizedBox(height: 20),
                const Text("Keterangan Alasan", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _alasanController,
                  maxLines: 3,
                  decoration: _inputDecoration(hint: "Tuliskan alasan sakit atau izin..."),
                ),
              ],

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: submitAbsensi,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF58220),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("SIMPAN ABSENSI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
              _buildWarningInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeCard(String label, String time) {
    return Column(
      crossAxisAlignment: label == "Jam Masuk" ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
          child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[300]!)),
    );
  }

  Widget _buildWarningInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.amber.withOpacity(0.5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Colors.orange, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Penting: Batas waktu absensi hadir adalah pukul 08:30 WIB. Untuk Izin/Sakit harap sertakan keterangan yang jelas.",
              style: TextStyle(fontSize: 12, color: Colors.orange[900], height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
