-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 11, 2026 at 02:59 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `absen_tk`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensi_guru`
--

CREATE TABLE `absensi_guru` (
  `id_absensi_guru` int NOT NULL,
  `id_guru` int DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `absensi_siswa`
--

CREATE TABLE `absensi_siswa` (
  `id_absensi_siswa` int NOT NULL,
  `tanggal` date DEFAULT NULL,
  `id_kelas` varchar(10) DEFAULT NULL,
  `id_guru` int DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `id_siswa` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_absensi_siswa`
--

CREATE TABLE `detail_absensi_siswa` (
  `id_detail_absensi_siswa` int NOT NULL,
  `id_siswa` int DEFAULT NULL,
  `id_absensi_siswa` int DEFAULT NULL,
  `id_status` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guru`
--

CREATE TABLE `guru` (
  `id_guru` int NOT NULL,
  `nama_guru` varchar(255) DEFAULT NULL,
  `nuptk` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `tempat_lahir` varchar(255) DEFAULT NULL,
  `tanggal_lahir` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `id_user` bigint DEFAULT NULL,
  `nip` varchar(255) DEFAULT NULL,
  `no_hp` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `guru`
--

INSERT INTO `guru` (`id_guru`, `nama_guru`, `nuptk`, `status`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `id_user`, `nip`, `no_hp`) VALUES
(1, 'SUSIANI, S.Pd.', '4543752654300033', 'GTY', 'Lumajang', '1971-06-01', 'Kedungrejo', 2, NULL, NULL),
(2, 'IKE RETNALYANINGTYAS, S.Pd.', '6655763664300042', 'GTY', 'Lumajang', '1985-03-23', 'Kedungrejo', NULL, NULL, NULL),
(3, 'KHUSNUL AZIZAH', '9261744647300043', 'GTY', 'Lumajang', '1966-09-29', 'Kedungrejo', NULL, NULL, NULL),
(4, 'MARSINAH', '1353748651300033', 'GTY', 'Lumajang', '1970-07-21', 'Kedungrejo', NULL, NULL, NULL),
(5, 'WIYANI, A.Md.', '6039748651300073', 'GTY', 'Lumajang', '1970-07-07', 'Kedungrejo', NULL, NULL, NULL),
(6, 'ALFA FAUZIYAH, S.Pd.', '8537767668230283', 'GTY', 'Jember', '1989-12-05', 'Kedungrejo', NULL, NULL, NULL),
(7, 'NAFISATUL FAUZIYAH, S.Pd.', '3762769670230362', 'GTY', 'Pasuruan', '1991-04-30', 'Kedungrejo', NULL, NULL, NULL),
(8, 'DWI PUJI LESTARI, S.Pd.', '948772673230402', 'GTY', 'Jember', '1994-06-16', 'Kedungrejo', NULL, NULL, NULL),
(9, 'NURIL HIDAYAH LAILLIA ARI, S.Ak.', NULL, 'GTY', 'Lumajang', '2001-07-29', 'Kedungrejo', NULL, NULL, NULL),
(10, 'LAILATUL ZULFA', NULL, 'GTY', 'Lumajang', '2002-05-24', 'Kedungrejo', NULL, NULL, NULL),
(11, 'LAILATUL MUBASYIROH', NULL, 'GTY', 'Lumajang', '2001-08-27', 'Kedungrejo', NULL, NULL, NULL),
(18, 'Afifah', '1234567', 'GTT', 'Lumajang', '2004-06-06', 'Lumajang', 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` varchar(10) NOT NULL,
  `nama_kelas` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`) VALUES
('A1', 'A1'),
('A2', 'A2'),
('B1', 'B1'),
('B2', 'B2'),
('B3', 'B3'),
('B4', 'B4'),
('B5', 'B5');

-- --------------------------------------------------------

--
-- Table structure for table `kelas_guru`
--

CREATE TABLE `kelas_guru` (
  `id` bigint NOT NULL,
  `id_kelas` varchar(10) NOT NULL,
  `id_guru` int NOT NULL,
  `id_tahun_ajaran` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kelas_guru`
--

INSERT INTO `kelas_guru` (`id`, `id_kelas`, `id_guru`, `id_tahun_ajaran`) VALUES
(1, 'A1', 4, 1),
(2, 'A2', 6, 1),
(3, 'B1', 8, 1),
(4, 'B2', 2, 1),
(5, 'B3', 3, 1),
(6, 'B4', 11, 1),
(7, 'B5', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int NOT NULL,
  `nama_siswa` varchar(255) DEFAULT NULL,
  `nisn` varchar(255) DEFAULT NULL,
  `tempat_lahir` varchar(255) DEFAULT NULL,
  `tanggal_lahir` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama_siswa`, `nisn`, `tempat_lahir`, `tanggal_lahir`, `alamat`) VALUES
(1, 'Azriel Kinza Ravindra', '3202046815', 'Lumajang', '2020-06-11', 'Jalan Diponegoro'),
(2, 'Nizam Fahmi Haryadi', '3203362254', 'Lumajang', '2020-02-20', 'Sukosari'),
(3, 'Nizar Fahim Haryadi', '3209632541', 'Lumajang', '2020-02-20', 'Sukosari'),
(4, 'Rana Aqila Humaira', '3210560411', 'Lumajang', '2021-03-17', 'Jalan Diponegoro'),
(5, 'Fazia Syabna Ardhana', '3213979424', 'Lumajang', '2021-08-10', 'Jalan Diponegoro'),
(6, 'Nabila Arsya Arifin', '3202650268', 'Jember', '2020-04-01', 'Jl. Mataram'),
(7, 'Achmad Alfan Rachmana', '3202501539', 'Lumajang', '2020-05-26', 'Bayur'),
(8, 'Kanaya Balqis Almaira Chozelyne', '3208491370', 'Lumajang', '2020-04-16', 'Jalan Diponegoro'),
(9, 'Fajrina Zalfa Qirani', '3213026662', 'Jember', '2021-03-14', 'Jl. Imam Bonjol VII/141 LINK.KRAJAN'),
(10, 'Danadyaksa Hernando Yusuf', '3217408202', 'Lumajang', '2021-03-11', 'Pondok Kobong'),
(11, 'Mohamad Fachrul Faresta', '3192137262', 'Banyuwangi', '2019-12-19', 'Selokondung'),
(12, 'Ahmad Musyaffa\'', '3206481014', 'Lumajang', '2020-07-18', 'Jl.Diponegoro'),
(13, 'Nayra Salsabila', '3217530832', 'Banyuwangi', '2021-02-22', 'Kamboja'),
(14, 'Kanzia Yunita Putri Prasetya', '3203782934', 'Balikpapan', '2020-06-16', 'Pesona Orlando Blok DA No.11'),
(15, 'Nabila Shafa Nurdiansyah', '3201964704', 'Lumajang', '2020-06-19', 'Sumbersari'),
(16, 'Nadia Nuha Nafisah', '3200898084', 'Lumajang', '2020-12-28', 'Jl. Diponegoro'),
(17, 'Pradita Manggala Putra Wicaksono', '3206380971', 'Lumajang', '2020-08-09', 'Krajan'),
(18, 'Ratu Jodha Abidah Yuga', NULL, NULL, NULL, NULL),
(19, 'Devi', NULL, NULL, NULL, NULL),
(20, 'Amara Navisha Medina', '3200326457', 'Lumajang', '2020-02-18', 'Diponegoro'),
(21, 'AZOF AL BAHRAIN', '3204888889', 'Lumajang', '2020-10-27', 'Kedungrejo'),
(22, 'Afifah Nur Fakhirah', NULL, NULL, NULL, NULL),
(23, 'Dhafina Hadi Mardania', '3216688110', 'Lumajang', '2021-02-19', 'Kapuharjo'),
(24, 'DEVINA WULANDANI', '3205684844', 'Lumajang', '2020-12-29', 'Soekertijo'),
(25, 'Elvina Zafarin Ardani', '3204153614', 'Lumajang', '2020-01-27', 'Mayjen Soekertiyo'),
(26, 'Aurora Nararya Maghfur', '3202046815', 'Lumajang', '2020-06-11', 'Jl. Diponegoro'),
(27, 'Mahdiyah Kirana Hawa Riziq', '3209243141', 'Lumajang', '2020-08-20', 'Diponegoro'),
(28, 'MUHAMMAD GIBRAN RAFARDHAN', '3205258733', 'Lumajang', '2020-03-20', 'JL. IMAM BONJOL VII/141 LINK.KRAJAN'),
(29, 'Nayottama Abgary Santoso', '3201547036', 'Lumajang', '2020-03-24', 'Selok Ondung'),
(30, 'NAURA SYAKILA AZ-ZAHRA', '3211085061', 'Lumajang', '2021-02-27', 'PONDOK ASRI'),
(31, 'Rajendra Arsenio Haris Prayitno', '3205553962', 'Lumajang', '2020-07-08', 'Sumbersari'),
(32, 'Muhammad Trisno Arundayu', '3201310120', 'Lumajang', '2020-01-11', 'Krajan'),
(33, 'MEZZA LUNA SYA\'BANIASHAZFA', '3203075215', 'Lumajang', '2020-04-08', 'Krajan Barat'),
(34, 'GOWINDA PUTRA PANGGALIH', '3208852066', 'Lumajang', '2020-05-20', 'Pondok Rejo'),
(35, 'Muhammad Agiel Maulana Saputra', '3209361261', 'Lumajang', '2020-06-26', 'JL.Diponegoro'),
(36, 'MANIKA KILA LOVA', '3209649116', 'Lumajang', '2020-01-11', 'Dsn. Pondok Asri'),
(37, 'Kalila Gauri Febrina', '3213742576', 'Lumajang', '2021-02-26', 'JL.Diponegoro'),
(38, 'Yasmin Azzahra', '3206235024', 'Lumajang', '2020-06-15', 'JL.Diponegoro'),
(39, 'Rasya Dwi Amanda Putri', '3208533600', 'Lumajang', '2020-04-12', 'JL.Diponegoro'),
(40, 'Rajendra Fathan Altair Hijriansyah', '3207298766', 'Lumajang', '2020-12-20', 'Mayjen Soekertiyo'),
(41, 'ZAIN HAMIZAN', '3208216003', 'Lumajang', '2020-07-07', 'Pondok Rejo'),
(42, 'SYARKA VALERINO ATHARRAZKA ASNAWI', '3211557501', 'Lumajang', '2021-02-24', 'Sokartiyo'),
(43, 'Adelia Faranisa Azni', '3196684192', 'Lumajang', '2019-09-15', 'Jl. Diponegoro'),
(44, 'Arkenzo Zaviar Rachman', '3190761456', 'Lumajang', '2019-06-04', 'Jl.Bayur'),
(45, 'Elvano Rahmadhani Imamullah', '3199393739', 'Lumajang', '2019-06-02', 'Jl.Diponegoro'),
(46, 'Faiza Alya Mubarok', '3209973520', 'Lumajang', '2020-03-15', 'Jl.Diponegoro'),
(47, 'Fandia Ayu Gayatri', '3195600676', 'Lumajang', '2019-03-11', 'Jl.Diponegoro'),
(48, 'Ibrahim Al-Zaidan', '3191929675', 'Lumajang', '2019-11-13', 'Jl. Dusun Pepe'),
(49, 'Kirana Maharani', '3191491334', 'Lumajang', '2019-09-14', 'Jl. Sidorejo Pepe'),
(50, 'Muhammad Aditya Maulana Alfarizky', '3194234581', 'Lumajang', '2019-08-26', 'Jl. Penggung Kidul'),
(51, 'Naumi Ajeng Pramesti', '3194371149', 'Lumajang', '2019-09-24', 'Jl. Penggung Kidul'),
(52, 'Reyna Syareefa Amanina', '3192552572', 'Lumajang', '2019-09-23', 'Jl.Diponegoro'),
(53, 'Arsya Yusuf Arzanka', '3192404921', 'Lumajang', '2019-09-11', 'Jl. Penggung Kidul'),
(54, 'Alifah Nurul Maghfiroh', '3198081266', 'Lumajang', '2019-04-19', 'Jl. Diponegoro'),
(55, 'Aurel Liya Mehrunnisa', '3199863170', 'Lumajang', '2019-11-02', 'Jl. Diponegoro'),
(56, 'Divania Azzahira Latifa Putri', '3196988772', 'Lumajang', '2019-08-16', 'Jl. Penggung Kidul'),
(57, 'Aulia Risya Febriana', '3197419537', 'Lumajang', '2019-02-21', 'Jl. Diponegoro'),
(58, 'Daneer Emran Dinata', '3191385554', 'Lumajang', '2019-08-20', 'Jl. Diponegoro'),
(59, 'Divania Azzahira Latifa Putri', NULL, NULL, NULL, NULL),
(60, 'Fadhil Abrisam Manaf', '3190979706', 'Lumajang', '2019-04-28', 'Jl. Kebonsari'),
(61, 'Muhammad Keenan Arkana', '3195382039', 'Lumajang', '2019-04-10', 'Jl. Penggung Lor'),
(62, 'Hafizd Ramadhan Alfarizy', '3190006096', 'Malang', '2019-06-01', 'Jl. Diponegoro'),
(63, 'Aisyatun Nazihah', '3198496979', 'Lumajang', '2019-05-28', 'Jl. Penggung Kidul'),
(64, 'Adiba Nabila Ramadhani', '3191022059', 'Lumajang', '2019-05-20', 'Jl. Kebonan'),
(65, 'Fitria Bunga Dewi', '3195418952', 'Lumajang', '2019-06-07', 'PEPE'),
(66, 'Akmal Kamalukdin Bahar', '3191017209', 'Lumajang', '2019-03-21', 'Jl. Selokondung'),
(67, 'Fayolla Zaufalin Al Widad', '3198857342', 'Lumajang', '2019-07-21', 'Jl. Wadaan'),
(68, 'Muhammad Andre Firmansyah', '3193980261', 'Lumajang', '2019-10-02', 'Jl. Diponegoro'),
(69, 'Abidah Hifza Maulidah', '3192377644', 'Lumajang', '2019-11-27', 'Jl. Serambaan'),
(70, 'Kirana Hanum Asyifa', '3194463247', 'Lumajang', '2019-05-24', 'Jl. Diponegoro'),
(71, 'Hanum Arza Wilda', '3200933704', 'Lumajang', '2020-01-02', 'Jl. Krajan Barat'),
(72, 'Vino', NULL, NULL, NULL, NULL),
(73, 'Icho', NULL, NULL, NULL, NULL),
(74, 'Afka', NULL, NULL, NULL, NULL),
(75, 'Dio', NULL, NULL, NULL, NULL),
(76, 'Fares', NULL, NULL, NULL, NULL),
(77, 'Jeje', NULL, NULL, NULL, NULL),
(78, 'Azzahra Nafeza Hadier', '3190229824', 'Lumajang', '2019-05-23', 'Jl. Diponegoro'),
(79, 'Fakhril Favian Al Fariq', '3196979565', 'Lumajang', '2019-03-14', 'Jl. Krajan'),
(80, 'Grizelle Meisyah Ramadhani', '3202610467', 'Lumajang', '2020-05-05', 'Jl. Wadaan'),
(81, 'Karaissa Alvira Ilman', '3193552172', 'Lumajang', '2019-03-17', 'Jl. Diponegoro'),
(82, 'Muhammad Fathan Al Varo', '3194893856', 'Lumajang', '2019-11-02', 'Jl. Selok Ondung'),
(83, 'Muhammad Raffasya', '3194910311', 'Lumajang', '2019-06-09', 'Jl. Selok Ondung'),
(84, 'Zalfa Qirana', '3196676649', 'Lumajang', '2019-12-14', 'Jl. Bayur'),
(85, 'Afifah', '123456', 'Lumajang', '2024-06-04', 'Lumajang');

-- --------------------------------------------------------

--
-- Table structure for table `siswa_kelas`
--

CREATE TABLE `siswa_kelas` (
  `id_siswa_kelas` bigint NOT NULL,
  `id_siswa` int NOT NULL,
  `id_kelas` varchar(10) NOT NULL,
  `id_tahun_ajaran` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `siswa_kelas`
--

INSERT INTO `siswa_kelas` (`id_siswa_kelas`, `id_siswa`, `id_kelas`, `id_tahun_ajaran`) VALUES
(1, 1, 'A1', 1),
(3, 2, 'A1', 1),
(4, 3, 'A1', 1),
(5, 4, 'A1', 1),
(6, 5, 'A1', 1),
(7, 6, 'A1', 1),
(8, 7, 'A1', 1),
(9, 8, 'A1', 1),
(10, 9, 'A1', 1),
(11, 10, 'A1', 1),
(12, 11, 'A1', 1),
(13, 12, 'A1', 1),
(14, 13, 'A1', 1),
(15, 14, 'A1', 1),
(16, 15, 'A1', 1),
(17, 16, 'A1', 1),
(18, 17, 'A1', 1),
(19, 18, 'A1', 1),
(20, 19, 'A1', 1),
(21, 20, 'A2', 1),
(22, 21, 'A2', 1),
(23, 22, 'A2', 1),
(24, 23, 'A2', 1),
(25, 24, 'A2', 1),
(26, 25, 'A2', 1),
(27, 26, 'A2', 1),
(28, 27, 'A2', 1),
(29, 28, 'A2', 1),
(30, 29, 'A2', 1),
(31, 30, 'A2', 1),
(32, 31, 'A2', 1),
(33, 32, 'A2', 1),
(34, 33, 'A2', 1),
(35, 34, 'A2', 1),
(36, 35, 'A2', 1),
(37, 36, 'A2', 1),
(38, 37, 'A2', 1),
(39, 38, 'A2', 1),
(40, 39, 'A2', 1),
(41, 40, 'A2', 1),
(42, 41, 'A2', 1),
(43, 42, 'A2', 1),
(44, 85, 'A1', 1),
(45, 85, 'A2', 1);

-- --------------------------------------------------------

--
-- Table structure for table `status_absensi`
--

CREATE TABLE `status_absensi` (
  `id_status` int NOT NULL,
  `nama_status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `status_absensi`
--

INSERT INTO `status_absensi` (`id_status`, `nama_status`) VALUES
(1, 'Hadir'),
(2, 'Izin'),
(3, 'Sakit'),
(4, 'Alpha');

-- --------------------------------------------------------

--
-- Table structure for table `tahun_ajaran`
--

CREATE TABLE `tahun_ajaran` (
  `id_tahun_ajaran` int NOT NULL,
  `tahun` varchar(255) DEFAULT NULL,
  `semester` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tahun_ajaran`
--

INSERT INTO `tahun_ajaran` (`id_tahun_ajaran`, `tahun`, `semester`, `status`) VALUES
(1, '2026', '2', 'aktif');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` bigint NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `username`, `password`, `role`, `email`) VALUES
(1, 'admin', '123', 'admin', 'admin@gmail.com'),
(2, 'Susiani', '123', 'guru', 'Susiani@gmail.com'),
(3, 'budi', '123', 'guru', 'budi@gmail.com'),
(4, 'afifah', '123', 'guru', 'afif@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi_guru`
--
ALTER TABLE `absensi_guru`
  ADD PRIMARY KEY (`id_absensi_guru`),
  ADD KEY `id_guru` (`id_guru`);

--
-- Indexes for table `absensi_siswa`
--
ALTER TABLE `absensi_siswa`
  ADD PRIMARY KEY (`id_absensi_siswa`),
  ADD KEY `id_guru` (`id_guru`),
  ADD KEY `fk_kelas_absensi` (`id_kelas`);

--
-- Indexes for table `detail_absensi_siswa`
--
ALTER TABLE `detail_absensi_siswa`
  ADD PRIMARY KEY (`id_detail_absensi_siswa`),
  ADD KEY `id_siswa` (`id_siswa`),
  ADD KEY `id_absensi_siswa` (`id_absensi_siswa`);

--
-- Indexes for table `guru`
--
ALTER TABLE `guru`
  ADD PRIMARY KEY (`id_guru`),
  ADD UNIQUE KEY `UKgbma6cidaey2vd4kbd0651ais` (`id_user`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`);

--
-- Indexes for table `kelas_guru`
--
ALTER TABLE `kelas_guru`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_kelas_guru_kelas` (`id_kelas`),
  ADD KEY `fk_kelas_guru_guru` (`id_guru`),
  ADD KEY `fk_kelas_guru_tahun` (`id_tahun_ajaran`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- Indexes for table `siswa_kelas`
--
ALTER TABLE `siswa_kelas`
  ADD PRIMARY KEY (`id_siswa_kelas`),
  ADD KEY `id_siswa` (`id_siswa`),
  ADD KEY `id_tahun_ajaran` (`id_tahun_ajaran`),
  ADD KEY `siswa_kelas_ibfk_3` (`id_kelas`);

--
-- Indexes for table `status_absensi`
--
ALTER TABLE `status_absensi`
  ADD PRIMARY KEY (`id_status`);

--
-- Indexes for table `tahun_ajaran`
--
ALTER TABLE `tahun_ajaran`
  ADD PRIMARY KEY (`id_tahun_ajaran`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi_guru`
--
ALTER TABLE `absensi_guru`
  MODIFY `id_absensi_guru` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `absensi_siswa`
--
ALTER TABLE `absensi_siswa`
  MODIFY `id_absensi_siswa` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_absensi_siswa`
--
ALTER TABLE `detail_absensi_siswa`
  MODIFY `id_detail_absensi_siswa` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guru`
--
ALTER TABLE `guru`
  MODIFY `id_guru` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `kelas_guru`
--
ALTER TABLE `kelas_guru`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `siswa_kelas`
--
ALTER TABLE `siswa_kelas`
  MODIFY `id_siswa_kelas` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `status_absensi`
--
ALTER TABLE `status_absensi`
  MODIFY `id_status` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tahun_ajaran`
--
ALTER TABLE `tahun_ajaran`
  MODIFY `id_tahun_ajaran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi_guru`
--
ALTER TABLE `absensi_guru`
  ADD CONSTRAINT `absensi_guru_ibfk_1` FOREIGN KEY (`id_guru`) REFERENCES `guru` (`id_guru`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `absensi_siswa`
--
ALTER TABLE `absensi_siswa`
  ADD CONSTRAINT `absensi_siswa_ibfk_2` FOREIGN KEY (`id_guru`) REFERENCES `guru` (`id_guru`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_kelas_absensi` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`);

--
-- Constraints for table `detail_absensi_siswa`
--
ALTER TABLE `detail_absensi_siswa`
  ADD CONSTRAINT `detail_absensi_siswa_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id_siswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_absensi_siswa_ibfk_2` FOREIGN KEY (`id_absensi_siswa`) REFERENCES `absensi_siswa` (`id_absensi_siswa`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `guru`
--
ALTER TABLE `guru`
  ADD CONSTRAINT `FK6hc972jx6gj7ycv7e3i02nbha` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `kelas_guru`
--
ALTER TABLE `kelas_guru`
  ADD CONSTRAINT `fk_kelas_guru_guru` FOREIGN KEY (`id_guru`) REFERENCES `guru` (`id_guru`),
  ADD CONSTRAINT `fk_kelas_guru_kelas` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`),
  ADD CONSTRAINT `fk_kelas_guru_tahun` FOREIGN KEY (`id_tahun_ajaran`) REFERENCES `tahun_ajaran` (`id_tahun_ajaran`);

--
-- Constraints for table `siswa_kelas`
--
ALTER TABLE `siswa_kelas`
  ADD CONSTRAINT `siswa_kelas_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id_siswa`),
  ADD CONSTRAINT `siswa_kelas_ibfk_2` FOREIGN KEY (`id_tahun_ajaran`) REFERENCES `tahun_ajaran` (`id_tahun_ajaran`),
  ADD CONSTRAINT `siswa_kelas_ibfk_3` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
