import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/kelas_detail_model.dart';
import '../../routes/app_routes.dart';

class MenuAbsensiSiswaScreen extends StatefulWidget {
  final KelasDetail kelas;
  const MenuAbsensiSiswaScreen({super.key, required this.kelas});

  @override
  State<MenuAbsensiSiswaScreen> createState() => _MenuAbsensiSiswaScreenState();
}

class _MenuAbsensiSiswaScreenState extends State<MenuAbsensiSiswaScreen> {
  int alpha = 0, hadir = 0, izin = 0, sakit = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRekapSiswa();
  }

  // Ubah fungsi fetchRekapSiswa di menu_absensi_siswa_screen.dart

  Future<void> fetchRekapSiswa() async {
    try {
      final String today = DateTime.now().toIso8601String().substring(0, 10);

      final res = await http.get(
        Uri.parse("http://10.0.2.2:8080/api/absensi-siswa/daily-stats?idKelas=${widget.kelas.idKelas}&tanggal=$today"),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          hadir = data["hadir"] ?? 0;
          izin = data["izin"] ?? 0;
          sakit = data["sakit"] ?? 0;
          alpha = data["alfa"] ?? 0;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetch daily stats: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Absensi ${widget.kelas.namaKelas}", style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ===== CARD GRAFIK PIE =====
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Grafik kehadiran siswa hari ini.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // Lingkaran Grafik
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CustomPaint(
                          painter: PieChartPainter(
                            hadir: hadir.toDouble(),
                            izin: izin.toDouble(),
                            sakit: sakit.toDouble(),
                            alpha: alpha.toDouble(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      // Legend / Keterangan
                      Expanded(
                        child: Column(
                          children: [
                            _buildLegend(const Color(0xFFF58220), "Hadir"),
                            _buildLegend(const Color(0xFF29B6F6), "Izin"),
                            _buildLegend(const Color(0xFF66BB6A), "Sakit"),
                            _buildLegend(const Color(0xFFEF5350), "Alpha"),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ===== MENU BUTTONS =====
            _buildActionCard(
              "Isi kehadiran siswa hari ini.",
              "Absen Siswa",
              Icons.check_circle_outline,
                  () => Navigator.pushNamed(context, AppRoutes.absenSiswa, arguments: widget.kelas).then((_) => fetchRekapSiswa()),
            ),
            const SizedBox(height: 15),
            _buildActionCard(
              "Lihat rekapan absensi siswa.",
              "Rekap Absensi",
              Icons.bar_chart_rounded,
                  () => Navigator.pushNamed(context, AppRoutes.rekapSiswa, arguments: widget.kelas),
            ),
            const SizedBox(height: 15),
            _buildActionCard(
              "Lihat data murid di kelas ini.",
              "Data Siswa",
              Icons.people_outline,
                  () => Navigator.pushNamed(context, AppRoutes.dataSiswaGuru, arguments: widget.kelas),
            ),
            const SizedBox(height: 100), // Spasi agar tidak tertutup navbar
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String btnText, IconData icon, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black)),
          const SizedBox(height: 12),
          SizedBox(
            height: 45,
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, color: Colors.black),
              label: Text(btnText, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF58220),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔥 PAINTER UNTUK GRAFIK PIE
class PieChartPainter extends CustomPainter {
  final double hadir, izin, sakit, alpha;
  PieChartPainter({required this.hadir, required this.izin, required this.sakit, required this.alpha});

  @override
  void paint(Canvas canvas, Size size) {
    double total = hadir + izin + sakit + alpha;
    if (total == 0) total = 1; // Mencegah pembagian nol

    final paint = Paint()..style = PaintingStyle.fill;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    double startAngle = -pi / 2;

    // Hadir
    _drawArc(canvas, rect, startAngle, (hadir / total) * 2 * pi, const Color(0xFFF58220), paint);
    startAngle += (hadir / total) * 2 * pi;

    // Izin
    _drawArc(canvas, rect, startAngle, (izin / total) * 2 * pi, const Color(0xFF29B6F6), paint);
    startAngle += (izin / total) * 2 * pi;

    // Sakit
    _drawArc(canvas, rect, startAngle, (sakit / total) * 2 * pi, const Color(0xFF66BB6A), paint);
    startAngle += (sakit / total) * 2 * pi;

    // Alpha
    _drawArc(canvas, rect, startAngle, (alpha / total) * 2 * pi, const Color(0xFFEF5350), paint);
  }

  void _drawArc(Canvas canvas, Rect rect, double start, double sweep, Color color, Paint paint) {
    if (sweep == 0) return;
    paint.color = color;
    canvas.drawArc(rect, start, sweep, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}