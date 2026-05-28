-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 28, 2026 at 09:46 PM
-- Server version: 9.6.0
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
  `id_absensi_guru` bigint NOT NULL,
  `id_guru` bigint NOT NULL,
  `tanggal` date DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `id_status` bigint NOT NULL,
  `id_tahun_ajaran` bigint NOT NULL,
  `jam` time NOT NULL,
  `alasan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `absensi_guru`
--

INSERT INTO `absensi_guru` (`id_absensi_guru`, `id_guru`, `tanggal`, `keterangan`, `id_status`, `id_tahun_ajaran`, `jam`, `alasan`) VALUES
(1, 6, '2026-05-03', NULL, 1, 1, '00:00:00', NULL),
(2, 6, '2026-05-10', NULL, 1, 1, '00:00:00', NULL),
(3, 1, '2026-05-15', NULL, 1, 1, '00:00:00', NULL),
(4, 21, '2026-05-15', NULL, 2, 1, '00:00:00', NULL),
(5, 6, '2026-05-15', NULL, 1, 1, '00:00:00', NULL),
(6, 1, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(7, 2, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(8, 3, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(9, 4, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(10, 5, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(11, 6, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(12, 7, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(13, 8, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(14, 9, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(15, 10, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(16, 11, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(17, 18, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(18, 21, '2026-05-18', 'Otomatis Alfa oleh sistem', 4, 1, '08:30:00', NULL),
(19, 1, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(20, 2, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(21, 3, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(22, 4, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(23, 5, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(24, 6, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(25, 7, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(26, 8, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(27, 9, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(28, 10, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(29, 11, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(30, 18, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(31, 21, '2026-05-19', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(32, 21, '2026-05-20', 'Terlambat', 1, 1, '07:40:54', NULL),
(33, 1, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(34, 2, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(35, 3, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(36, 4, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(37, 5, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(38, 6, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(39, 7, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(40, 8, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(41, 9, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(42, 10, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(43, 11, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(44, 18, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(45, 21, '2026-05-21', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(46, 1, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(47, 2, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(48, 3, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(49, 4, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(50, 5, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(51, 6, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(52, 7, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(53, 8, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(54, 9, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(55, 10, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(56, 11, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(57, 18, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(58, 21, '2026-05-22', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(59, 1, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(60, 2, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(61, 3, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(62, 4, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(63, 5, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(64, 6, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(65, 7, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(66, 8, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(67, 9, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(68, 10, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(69, 11, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(70, 18, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL),
(71, 21, '2026-05-29', 'Otomatis Alfa oleh Sistem', 4, 1, '08:30:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `absensi_siswa`
--

CREATE TABLE `absensi_siswa` (
  `id_absensi_siswa` bigint NOT NULL,
  `tanggal` date NOT NULL,
  `id_kelas` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `id_status` bigint DEFAULT NULL,
  `id_tahun_ajaran` bigint DEFAULT NULL,
  `id_siswa` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `absensi_siswa`
--

INSERT INTO `absensi_siswa` (`id_absensi_siswa`, `tanggal`, `id_kelas`, `keterangan`, `id_status`, `id_tahun_ajaran`, `id_siswa`) VALUES
(1, '2026-05-01', 'A2', NULL, 1, 1, 20),
(2, '2026-05-01', 'A2', NULL, 1, 1, 21),
(3, '2026-05-01', 'A2', NULL, 1, 1, 22),
(4, '2026-05-01', 'A2', NULL, 1, 1, 23),
(5, '2026-05-01', 'A2', NULL, 1, 1, 24),
(6, '2026-05-01', 'A2', NULL, 1, 1, 25),
(7, '2026-05-01', 'A2', NULL, 1, 1, 26),
(8, '2026-05-01', 'A2', NULL, 1, 1, 27),
(9, '2026-05-01', 'A2', NULL, 1, 1, 28),
(10, '2026-05-01', 'A2', NULL, 1, 1, 29),
(11, '2026-05-01', 'A2', NULL, 1, 1, 30),
(12, '2026-05-01', 'A2', NULL, 1, 1, 31),
(13, '2026-05-01', 'A2', NULL, 1, 1, 32),
(14, '2026-05-01', 'A2', NULL, 1, 1, 33),
(15, '2026-05-01', 'A2', NULL, 1, 1, 34),
(16, '2026-05-01', 'A2', NULL, 1, 1, 35),
(17, '2026-05-01', 'A2', NULL, 1, 1, 36),
(18, '2026-05-01', 'A2', NULL, 1, 1, 37),
(19, '2026-05-01', 'A2', NULL, 1, 1, 38),
(20, '2026-05-01', 'A2', NULL, 1, 1, 39),
(21, '2026-05-01', 'A2', NULL, 1, 1, 40),
(22, '2026-05-01', 'A2', NULL, 1, 1, 41),
(23, '2026-05-01', 'A2', NULL, 2, 1, 42),
(24, '2026-05-03', 'A2', NULL, 1, 1, 20),
(25, '2026-05-03', 'A2', NULL, 1, 1, 21),
(26, '2026-05-03', 'A2', NULL, 1, 1, 22),
(27, '2026-05-03', 'A2', NULL, 1, 1, 23),
(28, '2026-05-03', 'A2', NULL, 1, 1, 24),
(29, '2026-05-03', 'A2', NULL, 1, 1, 25),
(30, '2026-05-03', 'A2', NULL, 1, 1, 26),
(31, '2026-05-03', 'A2', NULL, 1, 1, 27),
(32, '2026-05-03', 'A2', NULL, 1, 1, 28),
(33, '2026-05-03', 'A2', NULL, 1, 1, 29),
(34, '2026-05-03', 'A2', NULL, 1, 1, 30),
(35, '2026-05-03', 'A2', NULL, 1, 1, 31),
(36, '2026-05-03', 'A2', NULL, 1, 1, 32),
(37, '2026-05-03', 'A2', NULL, 1, 1, 33),
(38, '2026-05-03', 'A2', NULL, 1, 1, 34),
(39, '2026-05-03', 'A2', NULL, 1, 1, 35),
(40, '2026-05-03', 'A2', NULL, 1, 1, 36),
(41, '2026-05-03', 'A2', NULL, 1, 1, 37),
(42, '2026-05-03', 'A2', NULL, 1, 1, 38),
(43, '2026-05-03', 'A2', NULL, 1, 1, 39),
(44, '2026-05-03', 'A2', NULL, 2, 1, 40),
(45, '2026-05-03', 'A2', NULL, 4, 1, 41),
(46, '2026-05-03', 'A2', NULL, 1, 1, 42),
(47, '2026-05-10', 'A2', NULL, 1, 1, 20),
(48, '2026-05-10', 'A2', NULL, 1, 1, 21),
(49, '2026-05-10', 'A2', NULL, 1, 1, 22),
(50, '2026-05-10', 'A2', NULL, 2, 1, 23),
(51, '2026-05-10', 'A2', NULL, 1, 1, 24),
(52, '2026-05-10', 'A2', NULL, 1, 1, 25),
(53, '2026-05-10', 'A2', NULL, 1, 1, 26),
(54, '2026-05-10', 'A2', NULL, 1, 1, 27),
(55, '2026-05-10', 'A2', NULL, 1, 1, 28),
(56, '2026-05-10', 'A2', NULL, 1, 1, 29),
(57, '2026-05-10', 'A2', NULL, 1, 1, 30),
(58, '2026-05-10', 'A2', NULL, 1, 1, 31),
(59, '2026-05-10', 'A2', NULL, 1, 1, 32),
(60, '2026-05-10', 'A2', NULL, 1, 1, 33),
(61, '2026-05-10', 'A2', NULL, 1, 1, 34),
(62, '2026-05-10', 'A2', NULL, 1, 1, 35),
(63, '2026-05-10', 'A2', NULL, 1, 1, 36),
(64, '2026-05-10', 'A2', NULL, 1, 1, 37),
(65, '2026-05-10', 'A2', NULL, 1, 1, 38),
(66, '2026-05-10', 'A2', NULL, 1, 1, 39),
(67, '2026-05-10', 'A2', NULL, 1, 1, 40),
(68, '2026-05-10', 'A2', NULL, 1, 1, 41),
(69, '2026-05-10', 'A2', NULL, 1, 1, 42),
(70, '2026-05-11', 'A2', NULL, 2, 1, 20),
(71, '2026-05-11', 'A2', NULL, 1, 1, 21),
(72, '2026-05-11', 'A2', NULL, 1, 1, 22),
(73, '2026-05-11', 'A2', NULL, 1, 1, 23),
(74, '2026-05-11', 'A2', NULL, 1, 1, 24),
(75, '2026-05-11', 'A2', NULL, 1, 1, 25),
(76, '2026-05-11', 'A2', NULL, 1, 1, 26),
(77, '2026-05-11', 'A2', NULL, 1, 1, 27),
(78, '2026-05-11', 'A2', NULL, 1, 1, 28),
(79, '2026-05-11', 'A2', NULL, 1, 1, 29),
(80, '2026-05-11', 'A2', NULL, 1, 1, 30),
(81, '2026-05-11', 'A2', NULL, 1, 1, 31),
(82, '2026-05-11', 'A2', NULL, 1, 1, 32),
(83, '2026-05-11', 'A2', NULL, 1, 1, 33),
(84, '2026-05-11', 'A2', NULL, 1, 1, 34),
(85, '2026-05-11', 'A2', NULL, 1, 1, 35),
(86, '2026-05-11', 'A2', NULL, 1, 1, 36),
(87, '2026-05-11', 'A2', NULL, 1, 1, 37),
(88, '2026-05-11', 'A2', NULL, 1, 1, 38),
(89, '2026-05-11', 'A2', NULL, 1, 1, 39),
(90, '2026-05-11', 'A2', NULL, 1, 1, 40),
(91, '2026-05-11', 'A2', NULL, 1, 1, 41),
(92, '2026-05-11', 'A2', NULL, 1, 1, 42),
(93, '2026-05-15', 'A2', NULL, 1, 1, 20),
(94, '2026-05-15', 'A2', NULL, 1, 1, 21),
(95, '2026-05-15', 'A2', NULL, 1, 1, 22),
(96, '2026-05-15', 'A2', NULL, 1, 1, 23),
(97, '2026-05-15', 'A2', NULL, 1, 1, 24),
(98, '2026-05-15', 'A2', NULL, 1, 1, 25),
(99, '2026-05-15', 'A2', NULL, 1, 1, 26),
(100, '2026-05-15', 'A2', NULL, 1, 1, 27),
(101, '2026-05-15', 'A2', NULL, 1, 1, 28),
(102, '2026-05-15', 'A2', NULL, 1, 1, 29),
(103, '2026-05-15', 'A2', NULL, 1, 1, 30),
(104, '2026-05-15', 'A2', NULL, 1, 1, 31),
(105, '2026-05-15', 'A2', NULL, 1, 1, 32),
(106, '2026-05-15', 'A2', NULL, 1, 1, 33),
(107, '2026-05-15', 'A2', NULL, 1, 1, 34),
(108, '2026-05-15', 'A2', NULL, 1, 1, 35),
(109, '2026-05-15', 'A2', NULL, 1, 1, 36),
(110, '2026-05-15', 'A2', NULL, 1, 1, 37),
(111, '2026-05-15', 'A2', NULL, 1, 1, 38),
(112, '2026-05-15', 'A2', NULL, 1, 1, 39),
(113, '2026-05-15', 'A2', NULL, 1, 1, 40),
(114, '2026-05-15', 'A2', NULL, 1, 1, 41),
(115, '2026-05-15', 'A2', NULL, 1, 1, 42),
(116, '2026-05-18', 'B6', NULL, 1, 1, 87),
(117, '2026-05-19', 'A2', NULL, 2, 1, 20),
(118, '2026-05-19', 'A2', NULL, 1, 1, 21),
(119, '2026-05-19', 'A2', NULL, 1, 1, 22),
(120, '2026-05-19', 'A2', NULL, 1, 1, 23),
(121, '2026-05-19', 'A2', NULL, 1, 1, 24),
(122, '2026-05-19', 'A2', NULL, 1, 1, 25),
(123, '2026-05-19', 'A2', NULL, 1, 1, 26),
(124, '2026-05-19', 'A2', NULL, 1, 1, 27),
(125, '2026-05-19', 'A2', NULL, 1, 1, 28),
(126, '2026-05-19', 'A2', NULL, 1, 1, 29),
(127, '2026-05-19', 'A2', NULL, 1, 1, 30),
(128, '2026-05-19', 'A2', NULL, 1, 1, 31),
(129, '2026-05-19', 'A2', NULL, 1, 1, 32),
(130, '2026-05-19', 'A2', NULL, 1, 1, 33),
(131, '2026-05-19', 'A2', NULL, 1, 1, 34),
(132, '2026-05-19', 'A2', NULL, 1, 1, 35),
(133, '2026-05-19', 'A2', NULL, 1, 1, 36),
(134, '2026-05-19', 'A2', NULL, 1, 1, 37),
(135, '2026-05-19', 'A2', NULL, 1, 1, 38),
(136, '2026-05-19', 'A2', NULL, 1, 1, 39),
(137, '2026-05-19', 'A2', NULL, 1, 1, 40),
(138, '2026-05-19', 'A2', NULL, 1, 1, 41),
(139, '2026-05-19', 'A2', NULL, 1, 1, 42),
(140, '2026-05-19', 'B6', NULL, 1, 1, 87),
(141, '2026-05-19', 'A1', NULL, 3, 2, 88),
(142, '2026-05-20', 'A2', NULL, 2, 1, 20),
(143, '2026-05-20', 'A2', NULL, 3, 1, 21),
(144, '2026-05-20', 'A2', NULL, 4, 1, 22),
(145, '2026-05-20', 'A2', NULL, 1, 1, 23),
(146, '2026-05-20', 'A2', NULL, 1, 1, 24),
(147, '2026-05-20', 'A2', NULL, 1, 1, 25),
(148, '2026-05-20', 'A2', NULL, 1, 1, 26),
(149, '2026-05-20', 'A2', NULL, 1, 1, 27),
(150, '2026-05-20', 'A2', NULL, 1, 1, 28),
(151, '2026-05-20', 'A2', NULL, 1, 1, 29),
(152, '2026-05-20', 'A2', NULL, 1, 1, 30),
(153, '2026-05-20', 'A2', NULL, 1, 1, 31),
(154, '2026-05-20', 'A2', NULL, 1, 1, 32),
(155, '2026-05-20', 'A2', NULL, 1, 1, 33),
(156, '2026-05-20', 'A2', NULL, 1, 1, 34),
(157, '2026-05-20', 'A2', NULL, 1, 1, 35),
(158, '2026-05-20', 'A2', NULL, 1, 1, 36),
(159, '2026-05-20', 'A2', NULL, 1, 1, 37),
(160, '2026-05-20', 'A2', NULL, 1, 1, 38),
(161, '2026-05-20', 'A2', NULL, 1, 1, 39),
(162, '2026-05-20', 'A2', NULL, 1, 1, 40),
(163, '2026-05-20', 'A2', NULL, 1, 1, 41),
(164, '2026-05-20', 'A2', NULL, 1, 1, 42),
(165, '2026-05-21', 'A2', NULL, 1, 1, 20),
(166, '2026-05-21', 'A2', NULL, 2, 1, 21),
(167, '2026-05-21', 'A2', NULL, 3, 1, 22),
(168, '2026-05-21', 'A2', NULL, 4, 1, 23),
(169, '2026-05-21', 'A2', NULL, 1, 1, 24),
(170, '2026-05-21', 'A2', NULL, 1, 1, 25),
(171, '2026-05-21', 'A2', NULL, 1, 1, 26),
(172, '2026-05-21', 'A2', NULL, 1, 1, 27),
(173, '2026-05-21', 'A2', NULL, 1, 1, 28),
(174, '2026-05-21', 'A2', NULL, 1, 1, 29),
(175, '2026-05-21', 'A2', NULL, 1, 1, 30),
(176, '2026-05-21', 'A2', NULL, 1, 1, 31),
(177, '2026-05-21', 'A2', NULL, 1, 1, 32),
(178, '2026-05-21', 'A2', NULL, 1, 1, 33),
(179, '2026-05-21', 'A2', NULL, 1, 1, 34),
(180, '2026-05-21', 'A2', NULL, 1, 1, 35),
(181, '2026-05-21', 'A2', NULL, 1, 1, 36),
(182, '2026-05-21', 'A2', NULL, 1, 1, 37),
(183, '2026-05-21', 'A2', NULL, 1, 1, 38),
(184, '2026-05-21', 'A2', NULL, 1, 1, 39),
(185, '2026-05-21', 'A2', NULL, 1, 1, 40),
(186, '2026-05-21', 'A2', NULL, 1, 1, 41),
(187, '2026-05-21', 'A2', NULL, 1, 1, 42),
(188, '2026-05-22', 'A2', NULL, 1, 1, 20),
(189, '2026-05-22', 'A2', NULL, 2, 1, 21),
(190, '2026-05-22', 'A2', NULL, 3, 1, 22),
(191, '2026-05-22', 'A2', NULL, 4, 1, 23),
(192, '2026-05-22', 'A2', NULL, 1, 1, 24),
(193, '2026-05-22', 'A2', NULL, 1, 1, 25),
(194, '2026-05-22', 'A2', NULL, 1, 1, 26),
(195, '2026-05-22', 'A2', NULL, 1, 1, 27),
(196, '2026-05-22', 'A2', NULL, 1, 1, 28),
(197, '2026-05-22', 'A2', NULL, 1, 1, 29),
(198, '2026-05-22', 'A2', NULL, 1, 1, 30),
(199, '2026-05-22', 'A2', NULL, 1, 1, 31),
(200, '2026-05-22', 'A2', NULL, 1, 1, 32),
(201, '2026-05-22', 'A2', NULL, 1, 1, 33),
(202, '2026-05-22', 'A2', NULL, 1, 1, 34),
(203, '2026-05-22', 'A2', NULL, 1, 1, 35),
(204, '2026-05-22', 'A2', NULL, 1, 1, 36),
(205, '2026-05-22', 'A2', NULL, 1, 1, 37),
(206, '2026-05-22', 'A2', NULL, 1, 1, 38),
(207, '2026-05-22', 'A2', NULL, 1, 1, 39),
(208, '2026-05-22', 'A2', NULL, 1, 1, 40),
(209, '2026-05-22', 'A2', NULL, 1, 1, 41),
(210, '2026-05-22', 'A2', NULL, 1, 1, 42),
(211, '2026-05-29', 'A2', NULL, 1, 1, 20),
(212, '2026-05-29', 'A2', NULL, 2, 1, 21),
(213, '2026-05-29', 'A2', NULL, 3, 1, 22),
(214, '2026-05-29', 'A2', NULL, 1, 1, 23),
(215, '2026-05-29', 'A2', NULL, 1, 1, 24),
(216, '2026-05-29', 'A2', NULL, 1, 1, 25),
(217, '2026-05-29', 'A2', NULL, 1, 1, 26),
(218, '2026-05-29', 'A2', NULL, 1, 1, 27),
(219, '2026-05-29', 'A2', NULL, 1, 1, 28),
(220, '2026-05-29', 'A2', NULL, 1, 1, 29),
(221, '2026-05-29', 'A2', NULL, 1, 1, 30),
(222, '2026-05-29', 'A2', NULL, 1, 1, 31),
(223, '2026-05-29', 'A2', NULL, 1, 1, 32),
(224, '2026-05-29', 'A2', NULL, 1, 1, 33),
(225, '2026-05-29', 'A2', NULL, 1, 1, 34),
(226, '2026-05-29', 'A2', NULL, 1, 1, 35),
(227, '2026-05-29', 'A2', NULL, 1, 1, 36),
(228, '2026-05-29', 'A2', NULL, 1, 1, 37),
(229, '2026-05-29', 'A2', NULL, 1, 1, 38),
(230, '2026-05-29', 'A2', NULL, 1, 1, 39),
(231, '2026-05-29', 'A2', NULL, 1, 1, 40),
(232, '2026-05-29', 'A2', NULL, 1, 1, 41),
(233, '2026-05-29', 'A2', NULL, 1, 1, 42),
(234, '2026-05-29', 'B6', NULL, 1, 1, 87),
(235, '2026-05-29', 'A1', NULL, 1, 1, 1),
(236, '2026-05-29', 'A1', NULL, 2, 1, 2),
(237, '2026-05-29', 'A1', NULL, 3, 1, 3),
(238, '2026-05-29', 'A1', NULL, 1, 1, 4),
(239, '2026-05-29', 'A1', NULL, 1, 1, 5),
(240, '2026-05-29', 'A1', NULL, 1, 1, 6),
(241, '2026-05-29', 'A1', NULL, 1, 1, 7),
(242, '2026-05-29', 'A1', NULL, 1, 1, 8),
(243, '2026-05-29', 'A1', NULL, 1, 1, 9),
(244, '2026-05-29', 'A1', NULL, 1, 1, 10),
(245, '2026-05-29', 'A1', NULL, 1, 1, 11),
(246, '2026-05-29', 'A1', NULL, 1, 1, 12),
(247, '2026-05-29', 'A1', NULL, 1, 1, 13),
(248, '2026-05-29', 'A1', NULL, 1, 1, 14),
(249, '2026-05-29', 'A1', NULL, 1, 1, 15),
(250, '2026-05-29', 'A1', NULL, 1, 1, 16),
(251, '2026-05-29', 'A1', NULL, 1, 1, 17),
(252, '2026-05-29', 'A1', NULL, 1, 1, 18),
(253, '2026-05-29', 'A1', NULL, 1, 1, 19),
(254, '2026-05-29', 'B1', NULL, 4, 1, 85);

-- --------------------------------------------------------

--
-- Table structure for table `detail_absensi_siswa`
--

CREATE TABLE `detail_absensi_siswa` (
  `id_detail_absensi_siswa` int NOT NULL,
  `id_siswa` bigint DEFAULT NULL,
  `id_absensi_siswa` bigint DEFAULT NULL,
  `id_status` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guru`
--

CREATE TABLE `guru` (
  `id_guru` bigint NOT NULL,
  `nama_guru` varchar(255) DEFAULT NULL,
  `nuptk` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `tempat_lahir` varchar(255) DEFAULT NULL,
  `tanggal_lahir` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `id_user` bigint DEFAULT NULL,
  `nip` varchar(255) DEFAULT NULL,
  `no_hp` varchar(255) DEFAULT NULL,
  `foto` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `guru`
--

INSERT INTO `guru` (`id_guru`, `nama_guru`, `nuptk`, `status`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `id_user`, `nip`, `no_hp`, `foto`) VALUES
(1, 'SUSIANI, S.Pd.', '4543752654300033', 'GTY', 'Lumajang', '1971-06-01', 'Kedungrejo', 2, NULL, NULL, NULL),
(2, 'IKE RETNALYANINGTYAS, S.Pd.', '6655763664300042', 'GTY', 'Lumajang', '1985-03-23', 'Kedungrejo', NULL, NULL, NULL, NULL),
(3, 'KHUSNUL AZIZAH', '9261744647300043', 'GTY', 'Lumajang', '1966-09-29', 'Kedungrejo', NULL, NULL, NULL, NULL),
(4, 'MARSINAH', '1353748651300033', 'GTY', 'Lumajang', '1970-07-21', 'Kedungrejo', NULL, NULL, NULL, NULL),
(5, 'WIYANI, A.Md.', '6039748651300073', 'GTY', 'Lumajang', '1970-07-07', 'Kedungrejo', NULL, NULL, NULL, NULL),
(6, 'ALFA FAUZIYAH, S.Pd.', '8537767668230283', 'GTY', 'Jember', '1989-12-05', 'Kedungrejo', 6, NULL, NULL, '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'),
(7, 'NAFISATUL FAUZIYAH, S.Pd.', '3762769670230362', 'GTY', 'Pasuruan', '1991-04-30', 'Kedungrejo', NULL, NULL, NULL, NULL),
(8, 'DWI PUJI LESTARI, S.Pd.', '948772673230402', 'GTY', 'Jember', '1994-06-16', 'Kedungrejo', 8, NULL, NULL, NULL),
(9, 'NURIL HIDAYAH LAILLIA ARI, S.Ak.', NULL, 'GTY', 'Lumajang', '2001-07-29', 'Kedungrejo', NULL, NULL, NULL, NULL),
(10, 'LAILATUL ZULFA', NULL, 'GTY', 'Lumajang', '2002-05-24', 'Kedungrejo', NULL, NULL, NULL, NULL),
(11, 'LAILATUL MUBASYIROH', '', 'GTY', 'Lumajang', '2001-08-27', 'Kedungrejo', 7, NULL, NULL, NULL),
(18, 'Afifah', '1234567', 'GTT', 'Lumajang', '2004-06-06', 'Lumajang', 4, NULL, NULL, NULL),
(21, 'Awaliya', '1234567', 'GTY', 'Lumajang', '2000-01-01', 'Lumajang', 3, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hari_libur`
--

CREATE TABLE `hari_libur` (
  `id_libur` bigint NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hari_libur`
--

INSERT INTO `hari_libur` (`id_libur`, `tanggal`, `keterangan`) VALUES
(2, '2026-05-16', 'libur'),
(3, '2026-05-19', 'libur'),
(4, '2026-05-20', 'libur'),
(6, '2026-05-30', 'cuti bersama'),
(7, '2026-06-01', 'Hari Lahir Pancasila');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` varchar(10) NOT NULL,
  `nama_kelas` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
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
('B5', 'B5'),
('B6', 'B6');

-- --------------------------------------------------------

--
-- Table structure for table `kelas_guru`
--

CREATE TABLE `kelas_guru` (
  `id` bigint NOT NULL,
  `id_kelas` varchar(10) NOT NULL,
  `id_guru` bigint NOT NULL,
  `id_tahun_ajaran` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kelas_guru`
--

INSERT INTO `kelas_guru` (`id`, `id_kelas`, `id_guru`, `id_tahun_ajaran`) VALUES
(2, 'A2', 6, 1),
(3, 'B1', 8, 1),
(4, 'B2', 2, 1),
(5, 'B3', 3, 1),
(6, 'B4', 11, 1),
(9, 'A1', 1, 1),
(45, 'A1', 18, 2),
(46, 'B5', 11, 1),
(48, 'B6', 18, 1),
(50, 'A2', 2, 2),
(51, 'B1', 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id` bigint NOT NULL,
  `id_user` bigint DEFAULT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `isi` text,
  `waktu` datetime DEFAULT NULL,
  `dibaca` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notifikasi`
--

INSERT INTO `notifikasi` (`id`, `id_user`, `judul`, `isi`, `waktu`, `dibaca`) VALUES
(1, 6, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas A2.', '2026-05-18 19:52:39', 1),
(2, 1, 'Laporan Absensi Kelas', 'Kelas A2 belum melakukan absensi siswa hari ini.', '2026-05-18 19:52:39', 0),
(3, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-18 19:52:39', 0),
(4, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-18 19:52:39', 0),
(5, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-18 19:52:39', 0),
(6, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-18 19:52:39', 0),
(7, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-18 19:52:39', 0),
(8, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-18 19:52:39', 0),
(9, 5, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-19 01:05:11', 0),
(10, 6, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-19 01:05:11', 1),
(11, 4, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-19 01:05:11', 0),
(12, 3, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-19 01:05:11', 0),
(13, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:11', 0),
(14, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:11', 0),
(15, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:11', 0),
(16, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:11', 0),
(17, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:11', 0),
(18, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:11', 0),
(19, 4, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B6.', '2026-05-19 01:05:11', 0),
(20, 1, 'Laporan Absensi Kelas', 'Kelas B6 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:11', 0),
(21, 5, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-19 01:05:11', 0),
(22, 6, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-19 01:05:12', 1),
(23, 4, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-19 01:05:12', 0),
(24, 3, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-19 01:05:12', 0),
(25, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:54', 0),
(26, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:54', 0),
(27, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:54', 0),
(28, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:54', 0),
(29, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:54', 0),
(30, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:54', 0),
(31, 4, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B6.', '2026-05-19 01:05:54', 0),
(32, 1, 'Laporan Absensi Kelas', 'Kelas B6 belum melakukan absensi siswa hari ini.', '2026-05-19 01:05:54', 0),
(33, 5, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-21 10:25:53', 0),
(34, 6, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-21 10:25:53', 1),
(35, 4, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-21 10:25:53', 0),
(36, 3, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-21 10:25:53', 0),
(37, 6, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas A2.', '2026-05-21 10:25:53', 1),
(38, 1, 'Laporan Absensi Kelas', 'Kelas A2 belum melakukan absensi siswa hari ini.', '2026-05-21 10:25:53', 0),
(39, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-21 10:25:53', 0),
(40, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-21 10:25:53', 0),
(41, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-21 10:25:53', 0),
(42, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-21 10:25:53', 0),
(43, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-21 10:25:53', 0),
(44, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-21 10:25:53', 0),
(45, 4, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B6.', '2026-05-21 10:25:53', 0),
(46, 1, 'Laporan Absensi Kelas', 'Kelas B6 belum melakukan absensi siswa hari ini.', '2026-05-21 10:25:53', 0),
(47, 5, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-21 10:25:53', 0),
(48, 6, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-21 10:25:53', 1),
(49, 4, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-21 10:25:53', 0),
(50, 3, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-21 10:25:54', 0),
(51, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-21 11:01:27', 0),
(52, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-21 11:01:27', 0),
(53, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-21 11:01:27', 0),
(54, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-21 11:01:27', 0),
(55, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-21 11:01:27', 0),
(56, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-21 11:01:27', 0),
(57, 4, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B6.', '2026-05-21 11:01:27', 0),
(58, 1, 'Laporan Absensi Kelas', 'Kelas B6 belum melakukan absensi siswa hari ini.', '2026-05-21 11:01:27', 0),
(59, 5, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-22 09:07:13', 0),
(60, 6, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-22 09:07:13', 0),
(61, 7, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-22 09:07:13', 0),
(62, 4, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-22 09:07:13', 0),
(63, 3, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-22 09:07:13', 0),
(64, 6, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas A2.', '2026-05-22 09:07:13', 0),
(65, 1, 'Laporan Absensi Kelas', 'Kelas A2 belum melakukan absensi siswa hari ini.', '2026-05-22 09:07:13', 0),
(66, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-22 09:07:13', 0),
(67, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-22 09:07:13', 0),
(68, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-22 09:07:13', 0),
(69, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B4.', '2026-05-22 09:07:13', 0),
(70, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-22 09:07:13', 0),
(71, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-22 09:07:13', 0),
(72, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B5.', '2026-05-22 09:07:13', 0),
(73, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-22 09:07:13', 0),
(74, 4, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B6.', '2026-05-22 09:07:13', 0),
(75, 1, 'Laporan Absensi Kelas', 'Kelas B6 belum melakukan absensi siswa hari ini.', '2026-05-22 09:07:13', 0),
(76, 5, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-22 09:07:14', 0),
(77, 6, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-22 09:07:14', 1),
(78, 7, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-22 09:07:14', 0),
(79, 4, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-22 09:07:14', 0),
(80, 3, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-22 09:07:14', 0),
(81, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-22 11:22:40', 0),
(82, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-22 11:22:40', 0),
(83, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-22 11:22:40', 0),
(84, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B4.', '2026-05-22 11:22:40', 0),
(85, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-22 11:22:40', 0),
(86, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-22 11:22:40', 0),
(87, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B5.', '2026-05-22 11:22:40', 0),
(88, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-22 11:22:40', 0),
(89, 4, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B6.', '2026-05-22 11:22:40', 0),
(90, 1, 'Laporan Absensi Kelas', 'Kelas B6 belum melakukan absensi siswa hari ini.', '2026-05-22 11:22:40', 0),
(91, 5, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-29 02:05:17', 0),
(92, 6, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-29 02:05:17', 0),
(93, 7, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-29 02:05:17', 0),
(94, 4, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-29 02:05:17', 0),
(95, 3, 'Peringatan Absensi Diri', 'Anda belum melakukan absensi hari ini. Silakan segera absen.', '2026-05-29 02:05:17', 0),
(96, 6, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas A2.', '2026-05-29 02:05:17', 0),
(97, 1, 'Laporan Absensi Kelas', 'Kelas A2 belum melakukan absensi siswa hari ini.', '2026-05-29 02:05:17', 0),
(98, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-29 02:05:17', 0),
(99, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-29 02:05:17', 0),
(100, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-29 02:05:17', 0),
(101, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B4.', '2026-05-29 02:05:18', 0),
(102, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-29 02:05:18', 0),
(103, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-29 02:05:18', 0),
(104, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B5.', '2026-05-29 02:05:18', 0),
(105, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-29 02:05:18', 0),
(106, 4, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B6.', '2026-05-29 02:05:18', 0),
(107, 1, 'Laporan Absensi Kelas', 'Kelas B6 belum melakukan absensi siswa hari ini.', '2026-05-29 02:05:18', 0),
(108, 5, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-29 02:05:18', 0),
(109, 6, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-29 02:05:18', 0),
(110, 7, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-29 02:05:18', 0),
(111, 4, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-29 02:05:18', 0),
(112, 3, 'Sistem Absensi', 'Batas waktu berakhir. Anda dicatat \'Alfa\' hari ini.', '2026-05-29 02:05:18', 0),
(113, 6, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas A2.', '2026-05-29 02:52:06', 0),
(114, 1, 'Laporan Absensi Kelas', 'Kelas A2 belum melakukan absensi siswa hari ini.', '2026-05-29 02:52:06', 0),
(115, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-29 02:52:06', 0),
(116, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-29 02:52:06', 0),
(117, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-29 02:52:06', 0),
(118, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B4.', '2026-05-29 02:52:06', 0),
(119, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-29 02:52:06', 0),
(120, 1, 'Laporan Absensi Kelas', 'Kelas A1 belum melakukan absensi siswa hari ini.', '2026-05-29 02:52:06', 0),
(121, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B5.', '2026-05-29 02:52:06', 0),
(122, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-29 02:52:06', 0),
(123, 4, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B6.', '2026-05-29 02:52:06', 0),
(124, 1, 'Laporan Absensi Kelas', 'Kelas B6 belum melakukan absensi siswa hari ini.', '2026-05-29 02:52:06', 0),
(125, 8, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B1.', '2026-05-29 03:32:30', 0),
(126, 1, 'Laporan Absensi Kelas', 'Kelas B1 belum melakukan absensi siswa hari ini.', '2026-05-29 03:32:31', 0),
(127, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-29 03:32:31', 0),
(128, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-29 03:32:31', 0),
(129, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B4.', '2026-05-29 03:32:31', 0),
(130, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-29 03:32:31', 0),
(131, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B5.', '2026-05-29 03:32:31', 0),
(132, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-29 03:32:31', 0),
(133, 1, 'Laporan Absensi Kelas', 'Kelas B2 belum melakukan absensi siswa hari ini.', '2026-05-29 03:42:36', 0),
(134, 1, 'Laporan Absensi Kelas', 'Kelas B3 belum melakukan absensi siswa hari ini.', '2026-05-29 03:42:36', 0),
(135, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B4.', '2026-05-29 03:42:36', 0),
(136, 1, 'Laporan Absensi Kelas', 'Kelas B4 belum melakukan absensi siswa hari ini.', '2026-05-29 03:42:36', 0),
(137, 7, 'Peringatan Absensi Siswa', 'Anda belum mengabsen siswa hari ini untuk kelas B5.', '2026-05-29 03:42:36', 0),
(138, 1, 'Laporan Absensi Kelas', 'Kelas B5 belum melakukan absensi siswa hari ini.', '2026-05-29 03:42:36', 0);

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` bigint NOT NULL,
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
(85, 'Afifah Na', '123456', '', '', ''),
(87, 'Karin', '1234', 'Lumajang', '2000-01-01', 'Lumajang'),
(88, 'Amanda', '1234', 'lmj', '2020-01-01', 'lmj');

-- --------------------------------------------------------

--
-- Table structure for table `siswa_kelas`
--

CREATE TABLE `siswa_kelas` (
  `id_siswa_kelas` bigint NOT NULL,
  `id_siswa` bigint NOT NULL,
  `id_kelas` varchar(10) NOT NULL,
  `id_tahun_ajaran` bigint NOT NULL
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
(44, 85, 'B1', 1),
(48, 43, 'B1', 2),
(49, 85, 'B1', 2),
(51, 87, 'B6', 1),
(52, 87, 'B6', 2),
(53, 88, 'A1', 2);

-- --------------------------------------------------------

--
-- Table structure for table `status_absensi`
--

CREATE TABLE `status_absensi` (
  `id_status` bigint NOT NULL,
  `nama_status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `status_absensi`
--

INSERT INTO `status_absensi` (`id_status`, `nama_status`) VALUES
(1, 'Hadir'),
(2, 'Izin'),
(3, 'Sakit'),
(4, 'Alpa');

-- --------------------------------------------------------

--
-- Table structure for table `tahun_ajaran`
--

CREATE TABLE `tahun_ajaran` (
  `id_tahun_ajaran` bigint NOT NULL,
  `tahun` varchar(255) DEFAULT NULL,
  `semester` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tahun_ajaran`
--

INSERT INTO `tahun_ajaran` (`id_tahun_ajaran`, `tahun`, `semester`, `status`) VALUES
(1, '2026', '2', 'aktif'),
(2, '2026/2027', '1', 'tidak');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` bigint NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `id_guru` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `username`, `password`, `role`, `email`, `id_guru`) VALUES
(1, 'admin', '123', 'admin', 'admin@gmail.com', NULL),
(2, 'Susiani', '123', 'guru', 'Susiani@gmail.com', NULL),
(3, 'awa', '123', 'guru', 'awa@gmail.com', NULL),
(4, 'afifah', '123', 'guru', 'afif@gmail.com', NULL),
(5, 'amandaa', '123', 'guru', 'manda@gmail', NULL),
(6, 'alfa', '123', 'guru', 'alfa@gmail.com', NULL),
(7, 'Muba', '123', 'guru', 'random@gmail.com', NULL),
(8, 'dwi', '123', 'guru', 'wcdfef', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi_guru`
--
ALTER TABLE `absensi_guru`
  ADD PRIMARY KEY (`id_absensi_guru`),
  ADD KEY `id_guru` (`id_guru`),
  ADD KEY `absensi_guru_ibfk_2` (`id_status`),
  ADD KEY `absensi_guru_ibfk_3` (`id_tahun_ajaran`);

--
-- Indexes for table `absensi_siswa`
--
ALTER TABLE `absensi_siswa`
  ADD PRIMARY KEY (`id_absensi_siswa`),
  ADD UNIQUE KEY `unique_absen` (`id_siswa`,`tanggal`),
  ADD KEY `fk_kelas_absensi` (`id_kelas`),
  ADD KEY `fk_status` (`id_status`),
  ADD KEY `fk_tahun_ajaran` (`id_tahun_ajaran`);

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
-- Indexes for table `hari_libur`
--
ALTER TABLE `hari_libur`
  ADD PRIMARY KEY (`id_libur`),
  ADD UNIQUE KEY `tanggal` (`tanggal`);

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
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id`);

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
  ADD UNIQUE KEY `unique_siswa_tahun` (`id_siswa`,`id_tahun_ajaran`),
  ADD UNIQUE KEY `UKrpjjdddbiyiqjvg07gmi947bo` (`id_siswa`,`id_tahun_ajaran`),
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
  MODIFY `id_absensi_guru` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `absensi_siswa`
--
ALTER TABLE `absensi_siswa`
  MODIFY `id_absensi_siswa` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=255;

--
-- AUTO_INCREMENT for table `detail_absensi_siswa`
--
ALTER TABLE `detail_absensi_siswa`
  MODIFY `id_detail_absensi_siswa` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guru`
--
ALTER TABLE `guru`
  MODIFY `id_guru` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `hari_libur`
--
ALTER TABLE `hari_libur`
  MODIFY `id_libur` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kelas_guru`
--
ALTER TABLE `kelas_guru`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `siswa_kelas`
--
ALTER TABLE `siswa_kelas`
  MODIFY `id_siswa_kelas` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `status_absensi`
--
ALTER TABLE `status_absensi`
  MODIFY `id_status` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tahun_ajaran`
--
ALTER TABLE `tahun_ajaran`
  MODIFY `id_tahun_ajaran` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi_guru`
--
ALTER TABLE `absensi_guru`
  ADD CONSTRAINT `absensi_guru_ibfk_1` FOREIGN KEY (`id_guru`) REFERENCES `guru` (`id_guru`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `absensi_guru_ibfk_2` FOREIGN KEY (`id_status`) REFERENCES `status_absensi` (`id_status`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `absensi_guru_ibfk_3` FOREIGN KEY (`id_tahun_ajaran`) REFERENCES `tahun_ajaran` (`id_tahun_ajaran`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `absensi_siswa`
--
ALTER TABLE `absensi_siswa`
  ADD CONSTRAINT `fk_kelas` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_siswa` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id_siswa`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_status` FOREIGN KEY (`id_status`) REFERENCES `status_absensi` (`id_status`),
  ADD CONSTRAINT `fk_tahun_ajaran` FOREIGN KEY (`id_tahun_ajaran`) REFERENCES `tahun_ajaran` (`id_tahun_ajaran`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `detail_absensi_siswa`
--
ALTER TABLE `detail_absensi_siswa`
  ADD CONSTRAINT `absensi_siswa_ibfk_2` FOREIGN KEY (`id_absensi_siswa`) REFERENCES `absensi_siswa` (`id_absensi_siswa`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `siswa_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id_siswa`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `guru`
--
ALTER TABLE `guru`
  ADD CONSTRAINT `FK6hc972jx6gj7ycv7e3i02nbha` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `kelas_guru`
--
ALTER TABLE `kelas_guru`
  ADD CONSTRAINT `fk_kelas_guru_guru` FOREIGN KEY (`id_guru`) REFERENCES `guru` (`id_guru`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_kelas_guru_kelas` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_kelas_guru_tahun_ajaran` FOREIGN KEY (`id_tahun_ajaran`) REFERENCES `tahun_ajaran` (`id_tahun_ajaran`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `siswa_kelas`
--
ALTER TABLE `siswa_kelas`
  ADD CONSTRAINT `siswa_kelas_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id_siswa`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `siswa_kelas_ibfk_2` FOREIGN KEY (`id_tahun_ajaran`) REFERENCES `tahun_ajaran` (`id_tahun_ajaran`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `siswa_kelas_ibfk_3` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
