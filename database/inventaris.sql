-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 13 Mar 2023 pada 07.15
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventaris`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_pinjam`
--

CREATE TABLE `detail_pinjam` (
  `id_detail_pinjam` int(11) NOT NULL,
  `id_inventaris` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `id_peminjaman` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventaris`
--

CREATE TABLE `inventaris` (
  `id_inventaris` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `kondisi` varchar(50) NOT NULL,
  `keterangan` text NOT NULL,
  `jumlah` int(11) NOT NULL,
  `id_jenis` int(11) NOT NULL,
  `tanggal_register` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_ruang` int(11) NOT NULL,
  `kode_inventaris` varchar(50) NOT NULL,
  `id_petugas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis`
--

CREATE TABLE `jenis` (
  `id_jenis` int(11) NOT NULL,
  `nama_jenis` varchar(50) NOT NULL,
  `kode_jenis` varchar(50) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `level`
--

CREATE TABLE `level` (
  `id_level` int(11) NOT NULL,
  `nama_level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `level`
--

INSERT INTO `level` (`id_level`, `nama_level`) VALUES
(1, 'admin'),
(2, 'operator'),
(3, 'peminjam');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pegawai`
--

CREATE TABLE `pegawai` (
  `id_pegawai` int(11) NOT NULL,
  `nama_pegawai` varchar(50) NOT NULL,
  `nip` int(20) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `status_peminjaman` enum('0','1','2') NOT NULL,
  `id_pegawai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `petugas`
--

CREATE TABLE `petugas` (
  `id_petugas` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nama_petugas` varchar(50) NOT NULL,
  `id_level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `petugas`
--

INSERT INTO `petugas` (`id_petugas`, `username`, `password`, `nama_petugas`, `id_level`) VALUES
(0, 'operator', 'operator', 'OPERATOR', 2),
(2, 'admin', 'admin', 'ADMIN', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `ruang`
--

CREATE TABLE `ruang` (
  `id_ruang` int(11) NOT NULL,
  `nama_ruang` varchar(50) NOT NULL,
  `kode_ruang` varchar(50) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `detail_pinjam`
--
ALTER TABLE `detail_pinjam`
  ADD PRIMARY KEY (`id_detail_pinjam`),
  ADD KEY `id_inventaris` (`id_inventaris`),
  ADD KEY `id_peminjaman` (`id_peminjaman`);

--
-- Indeks untuk tabel `inventaris`
--
ALTER TABLE `inventaris`
  ADD PRIMARY KEY (`id_inventaris`),
  ADD KEY `id_jenis` (`id_jenis`),
  ADD KEY `id_ruang` (`id_ruang`),
  ADD KEY `id_petugas` (`id_petugas`);

--
-- Indeks untuk tabel `jenis`
--
ALTER TABLE `jenis`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indeks untuk tabel `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`id_level`);

--
-- Indeks untuk tabel `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_pegawai`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `id_pegawai` (`id_pegawai`);

--
-- Indeks untuk tabel `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`id_petugas`),
  ADD KEY `id_level` (`id_level`);

--
-- Indeks untuk tabel `ruang`
--
ALTER TABLE `ruang`
  ADD PRIMARY KEY (`id_ruang`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detail_pinjam`
--
ALTER TABLE `detail_pinjam`
  MODIFY `id_detail_pinjam` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id_pegawai` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detail_pinjam`
--
ALTER TABLE `detail_pinjam`
  ADD CONSTRAINT `detail_pinjam_ibfk_1` FOREIGN KEY (`id_inventaris`) REFERENCES `inventaris` (`id_inventaris`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_pinjam_ibfk_2` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjaman` (`id_peminjaman`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `inventaris`
--
ALTER TABLE `inventaris`
  ADD CONSTRAINT `inventaris_ibfk_1` FOREIGN KEY (`id_jenis`) REFERENCES `jenis` (`id_jenis`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventaris_ibfk_2` FOREIGN KEY (`id_ruang`) REFERENCES `ruang` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventaris_ibfk_3` FOREIGN KEY (`id_petugas`) REFERENCES `petugas` (`id_petugas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `petugas`
--
ALTER TABLE `petugas`
  ADD CONSTRAINT `petugas_ibfk_1` FOREIGN KEY (`id_level`) REFERENCES `level` (`id_level`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
