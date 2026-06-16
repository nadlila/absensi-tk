import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_config.dart';

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

  // Tambahkan variabel state untuk loading dan error
  bool isLoading = true;
  String? errorMessage;

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

  Future<void> initData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await getUser();

      if (idUser == null) {
        setState(() {
          errorMessage = "Sesi login tidak ditemukan. Silakan login ulang.";
          isLoading = false;
        });
        return;
      }

      // Menjalankan semua fetch secara paralel
      await Future.wait([
        fetchGuruLogin(),
        fetchStatus(),
        fetchTahunAjaranAktif(),
      ]);

      // Validasi hasil setelah fetch selesai
      if (guruLogin == null) {
        errorMessage = "Data Guru tidak ditemukan untuk akun ini. Pastikan data Guru sudah terhubung dengan User.";
      } else if (statusList.isEmpty) {
        errorMessage = "Daftar status absensi tidak ditemukan di server.";
      }
    } catch (e) {
      print("Error initData: $e");
      errorMessage = "Gagal memuat data. Periksa koneksi internet atau server anda.\n$e";
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt("idUser");
    print("DEBUG: idUser dari prefs = $idUser");
  }

  Future<void> fetchGuruLogin() async {
    if (idUser == null) return;
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/guru/user/$idUser"),
    );
    print("DEBUG: Fetch Guru Status = ${res.statusCode}");
    if (res.statusCode == 200) {
      setState(() {
        guruLogin = jsonDecode(res.body);
      });
      print("DEBUG: Data Guru = $guruLogin");
    }
  }

  Future<void> fetchStatus() async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/status-absensi"),
    );
    print("DEBUG: Fetch Status Absensi = ${res.statusCode}");
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
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/tahun-ajaran/aktif"),
    );
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      final data = jsonDecode(res.body);
      setState(() {
        idTahunAjaran = data['idTahunAjaran'];
      });
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

    // Untuk debugging/testing, kamu bisa komen bagian waktu ini jika sedang mencoba di malam hari
    if (currentTime > 8.5) {
      _showError("Batas waktu absensi sudah berakhir (jam 08:30).");
      return;
    }

    if (statusNama == "hadir") {
      if (currentTime < 7.0) {
        _showError("Absensi belum dibuka. Silakan kembali pukul 07:00.");
        return;
      }
    }

    try {
      final res = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/absensi-guru"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "guru": {"idGuru": guruLogin!["idGuru"]},
          "tanggal": DateTime.now().toIso8601String().substring(0, 10),
          "status": {"idStatus": selectedStatus!["idStatus"]},
          "idTahunAjaran": idTahunAjaran,
          "alasan": _alasanController.text.trim(),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
            ? Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 10),
                Text(errorMessage!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: initData,
                  child: const Text("Coba Lagi"),
                )
              ],
            ),
          ),
        )
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

  // ... (Widget helper tetap sama: _buildTimeCard, _inputDecoration, _buildWarningInfo)
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