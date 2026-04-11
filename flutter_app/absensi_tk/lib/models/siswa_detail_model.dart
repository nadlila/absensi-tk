class SiswaDetail {

  final int idSiswa;
  final String namaSiswa;
  final String nisn;
  final String kelas;
  final String tahun;
  final String semester;

  SiswaDetail({
    required this.idSiswa,
    required this.namaSiswa,
    required this.nisn,
    required this.kelas,
    required this.tahun,
    required this.semester,
  });

  factory SiswaDetail.fromJson(Map<String, dynamic> json) {

    return SiswaDetail(
      idSiswa: json['idSiswa'],
      namaSiswa: json['namaSiswa'] ?? '',
      nisn: json['nisn'] ?? '',
      kelas: json['kelas'] ?? '',
      tahun: json['tahun'] ?? '',
      semester: json['semester'] ?? '',
    );

  }
}