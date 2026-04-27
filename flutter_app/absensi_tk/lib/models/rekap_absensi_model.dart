class RekapAbsensi {
  final int idSiswa;
  final String namaSiswa;
  final int hadir;
  final int izin;
  final int sakit;
  final int alfa;

  RekapAbsensi({
    required this.idSiswa,
    required this.namaSiswa,
    required this.hadir,
    required this.izin,
    required this.sakit,
    required this.alfa,
  });

  factory RekapAbsensi.fromJson(Map<String, dynamic> json) {
    return RekapAbsensi(
      idSiswa: json['idSiswa'],
      namaSiswa: json['namaSiswa'],
      hadir: json['hadir'],
      izin: json['izin'],
      sakit: json['sakit'],
      alfa: json['alfa'],
    );
  }
}