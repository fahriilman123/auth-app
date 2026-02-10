-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 10, 2026 at 06:56 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coralis_auth`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expired` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `reset_token`, `reset_token_expired`, `created_at`) VALUES
(1, 'fahri', 'fahri@gmail.com', '$2b$10$7PI62CrQxAtVD9xR7S2X5OgZslLCcqiRODahxcWcwkU6aMh3s4n4a', NULL, NULL, '2026-02-05 08:07:55'),
(2, 'arif', 'arif@gmail.com', '$2b$10$27kgegUJkS1lf1gY6wak/eBhnBYfCyHgc4X0mybGKoFAzPRAbf/WG', NULL, NULL, '2026-02-09 07:04:07'),
(3, 'asep', 'asep@gmail.com', '$2b$10$xs5TqEj.feNRbzJJnwTKS.B.e1STRsXay535p1kanRqA0cWMd/iMa', NULL, NULL, '2026-02-09 07:06:28'),
(4, 'andika', 'an@gmail.com', '$2b$10$NV6Vs9NMc2.LNmg7ZDO/8.VEjPtMmJB2ijQPOLoH6S8w5un8I.kQ.', 'e8375331025464ee72a29c4b80fb9df25b507106', '2026-02-09 18:58:45', '2026-02-09 07:07:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
