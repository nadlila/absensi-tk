class StatusAbsensi {
  final int idStatus;
  final String namaStatus;

  StatusAbsensi({
    required this.idStatus,
    required this.namaStatus,
  });

  factory StatusAbsensi.fromJson(Map<String, dynamic> json) {
    return StatusAbsensi(
      idStatus: json['idStatus'],
      namaStatus: json['namaStatus'],
    );
  }
}