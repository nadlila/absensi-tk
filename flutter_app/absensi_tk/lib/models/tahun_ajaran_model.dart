class TahunAjaran {

  final int idTahunAjaran;
  final String tahun;
  final String semester;
  final String status;

  TahunAjaran({
    required this.idTahunAjaran,
    required this.tahun,
    required this.semester,
    required this.status,
  });

  factory TahunAjaran.fromJson(Map<String,dynamic> json){

    return TahunAjaran(
      idTahunAjaran: json['idTahunAjaran'],
      tahun: json['tahun'] ?? '',
      semester: json['semester'] ?? '',
      status: json['status'] ?? '',
    );

  }

}