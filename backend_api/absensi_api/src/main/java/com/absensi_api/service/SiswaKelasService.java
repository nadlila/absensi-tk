// package com.absensi_api.service;

// import java.util.List;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Service;

// import com.absensi_api.model.SiswaKelas;
// import com.absensi_api.repository.SiswaKelasRepository;

// @Service
// public class SiswaKelasService {

//     @Autowired
//     private SiswaKelasRepository siswaKelasRepository;

//     public void naikKelas(Long tahunBaru){

//         List<SiswaKelas> list =
//             siswaKelasRepository.getSiswaTahunTerakhir();

//         for(SiswaKelas s : list){

//             String kelasBaru = null;

//             if(s.getIdKelas().equals("A")){
//                 kelasBaru = "B";
//             }

//             if(kelasBaru != null){

//                 SiswaKelas baru = new SiswaKelas();

//                 baru.setIdSiswa(s.getIdSiswa());
//                 baru.setIdKelas(kelasBaru);
//                 baru.setIdTahunAjaran(tahunBaru);

//                 siswaKelasRepository.save(baru);

//             }

//         }

//     }

// }