class SiswaDetail {
  final int idSiswa;
  final String namaSiswa;

  final String? nisn;          // 🔥 ubah jadi nullable
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? alamat;

  final String? namaKelas;
  final String? tahun;
  final String? semester;

  SiswaDetail({
    required this.idSiswa,
    required this.namaSiswa,
    this.nisn,
    this.tempatLahir,
    this.tanggalLahir,
    this.alamat,
    this.namaKelas,
    this.tahun,
    this.semester,
  });

  factory SiswaDetail.fromJson(Map<String, dynamic> json) {
    return SiswaDetail(
      idSiswa: json['idSiswa'],
      namaSiswa: json['namaSiswa'] ?? "-",
      nisn: json['nisn'], // sekarang aman
      tempatLahir: json['tempatLahir'],
      tanggalLahir: json['tanggalLahir'],
      alamat: json['alamat'],
      namaKelas: json['namaKelas'],
      tahun: json['tahun'],
      semester: json['semester'],
    );
  }
}