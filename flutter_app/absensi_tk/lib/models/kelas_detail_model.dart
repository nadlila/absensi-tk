class KelasDetail {

  final String idKelas;
  final String namaKelas;
  final String waliKelas;
  final String tahun;
  final String semester;

  KelasDetail({
    required this.idKelas,
    required this.namaKelas,
    required this.waliKelas,
    required this.tahun,
    required this.semester,
  });

  factory KelasDetail.fromJson(Map<String, dynamic> json) {

    return KelasDetail(
      idKelas: json['idKelas'],
      namaKelas: json['namaKelas'] ?? '',
      waliKelas: json['waliKelas'] ?? '',
      tahun: json['tahun'] ?? '',
      semester: json['semester'] ?? '',
    );

  }

}