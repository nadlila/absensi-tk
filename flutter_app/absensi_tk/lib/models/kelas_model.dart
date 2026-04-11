class Kelas {

  final String idKelas;
  final String namaKelas;

  Kelas({
    required this.idKelas,
    required this.namaKelas,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {

    return Kelas(
      idKelas: json['idKelas'].toString(),
      namaKelas: json['namaKelas'] ?? '',
    );

  }

}