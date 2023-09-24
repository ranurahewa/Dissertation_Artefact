-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 21, 2023 at 06:23 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `reg_id` int(11) NOT NULL,
  `service_type` varchar(50) NOT NULL,
  `district` int(11) NOT NULL,
  `ds_division` varchar(50) NOT NULL,
  `gn_number` varchar(50) NOT NULL,
  `referee_name` varchar(100) NOT NULL,
  `referee_phone` bigint(50) NOT NULL,
  `family_name` varchar(100) NOT NULL,
  `given_name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `sex` enum('m','f') NOT NULL,
  `civil_status` enum('married','single') NOT NULL,
  `occupation` varchar(50) NOT NULL,
  `photo_studio_ref` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `birth_cert_no` varchar(50) NOT NULL,
  `place_of_birth` varchar(100) NOT NULL,
  `birth_division` varchar(50) NOT NULL,
  `birth_district` varchar(50) NOT NULL,
  `country_of_birth` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `certificate_no` varchar(50) NOT NULL,
  `permanent_address` varchar(100) NOT NULL,
  `permanent_city` varchar(50) NOT NULL,
  `permanent_postal` varchar(50) NOT NULL,
  `postal_address` varchar(100) NOT NULL,
  `postal_city` varchar(50) NOT NULL,
  `postal_postal` varchar(50) NOT NULL,
  `certificate_number` varchar(50) NOT NULL,
  `certificate_issue_date` date NOT NULL,
  `purpose` varchar(50) NOT NULL,
  `lost_card_number` varchar(50) NOT NULL,
  `issue_date` date NOT NULL,
  `police_report_details` varchar(50) NOT NULL,
  `police_station` varchar(50) NOT NULL,
  `police_report_date` date NOT NULL,
  `telephone` bigint(50) NOT NULL,
  `mobile` bigint(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applications`
--

- --------------------------------------------------------

--
-- Table structure for table `distric`
--

CREATE TABLE `distric` (
  `d_id` int(11) NOT NULL,
  `d_text` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `distric`
--

INSERT INTO `distric` (`d_id`, `d_text`) VALUES
(1, 'kegalle'),
(2, 'colombo'),
(3, 'kandy'),
(4, 'kalutara'),
(5, 'hambanthota');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `reg_id` int(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`reg_id`);

--
-- Indexes for table `distric`
--
ALTER TABLE `distric`
  ADD PRIMARY KEY (`d_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`reg_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `reg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `distric`
--
ALTER TABLE `distric`
  MODIFY `d_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `reg_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
