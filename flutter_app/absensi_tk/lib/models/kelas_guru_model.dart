class KelasGuru {

  final String idKelas;
  final int idTahunAjaran;

  KelasGuru({
    required this.idKelas,
    required this.idTahunAjaran,
  });

  factory KelasGuru.fromJson(Map<String,dynamic> json){

    return KelasGuru(
      idKelas: json['idKelas'],
      idTahunAjaran: json['idTahunAjaran'],
    );

  }

}