class DetailAbsensi {
  final String tanggal;
  final String status;
  final String keterangan;

  DetailAbsensi({
    required this.tanggal,
    required this.status,
    required this.keterangan,
  });

  factory DetailAbsensi.fromJson(Map<String, dynamic> json) {
    return DetailAbsensi(
      tanggal: json['tanggal'],
      status: json['status'],
      keterangan: json['keterangan'] ?? '',
    );
  }
}