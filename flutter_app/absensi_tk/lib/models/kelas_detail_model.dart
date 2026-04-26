class KelasDetail {

  final int id;
  final String idKelas;
  final String namaKelas;
  final String waliKelas;
  final String tahun;
  final String semester;
  final int idGuru;
  final int idTahunAjaran; // 🔥 penting

  KelasDetail({
    required this.id,
    required this.idKelas,
    required this.namaKelas,
    required this.waliKelas,
    required this.tahun,
    required this.semester,
    required this.idGuru,
    required this.idTahunAjaran,
  });

  factory KelasDetail.fromJson(Map<String, dynamic> json) {
    return KelasDetail(
      id: json['id'],
      idKelas: json['idKelas'],
      namaKelas: json['namaKelas'],
      waliKelas: json['waliKelas'],
      tahun: json['tahun'],
      semester: json['semester'],
      idGuru: json['idGuru'],
      idTahunAjaran: json['idTahunAjaran'],
    );
  }
}