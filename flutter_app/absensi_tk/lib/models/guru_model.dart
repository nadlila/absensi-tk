class Guru {
  final int idGuru;
  final String namaGuru;
  final String nuptk;
  final String status;
  final String tempatLahir;
  final String tanggalLahir;
  final String alamat;
  final int? idUser;

  Guru({
    required this.idGuru,
    required this.namaGuru,
    required this.nuptk,
    required this.status,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.alamat,
    this.idUser,
  });

  factory Guru.fromJson(Map<String, dynamic> json) {
    return Guru(
      idGuru: json['idGuru'],
      namaGuru: json['namaGuru'] ?? '',
      nuptk: json['nuptk'] ?? '',
      status: json['status'] ?? '',
      tempatLahir: json['tempatLahir'] ?? '',
      tanggalLahir: json['tanggalLahir'] ?? '',
      alamat: json['alamat'] ?? '',
      idUser: json['idUser'],
    );
  }
}