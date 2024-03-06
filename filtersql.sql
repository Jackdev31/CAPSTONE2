-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 06, 2024 at 09:11 AM
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
-- Database: `cubersdaw`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `TEACHER_ID` varchar(50) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`TEACHER_ID`, `NAME`, `username`, `password`) VALUES
('1', 'Ryan Valeriano', 'Ryan', '123'),
('2', 'Kurt Ellie Hidalgo Ravena', 'Kurt', '123'),
('3', 'Tony', 'citenian', '123');

-- --------------------------------------------------------

--
-- Table structure for table `citestudents`
--

CREATE TABLE `citestudents` (
  `ID` varchar(50) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `STUDENT_ID` varchar(50) NOT NULL,
  `SUBJECT` varchar(50) NOT NULL,
  `P1` varchar(50) NOT NULL,
  `P2` varchar(50) NOT NULL,
  `P3` varchar(50) NOT NULL,
  `FINAL_GRADE` varchar(50) NOT NULL,
  `NUMERIC_GRADE` varchar(50) NOT NULL,
  `REMARKS` varchar(50) NOT NULL,
  `ACADEMIC_YEAR` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `ACTION_REMARKS` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `citestudents`
--

INSERT INTO `citestudents` (`ID`, `NAME`, `STUDENT_ID`, `SUBJECT`, `P1`, `P2`, `P3`, `FINAL_GRADE`, `NUMERIC_GRADE`, `REMARKS`, `ACADEMIC_YEAR`, `username`, `filename`, `ACTION_REMARKS`) VALUES
('1', 'Sarona , John Rey ', '04-2122-032649', 'CAPSTONE 2', '89', '89', '89', '89', '1.5', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('2', 'Tirado, Patric John', '04-2122-123456', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('3', 'Bunagan, Sean Carlo', '04-2122-123457', 'CAPSTONE 2', '89', '85', '90', '88', '2.5', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('3', 'Tangete, Ma. Fatima', '04-2122-123458', 'CAPSTONE 2', '89', '85', '90', '88', '3', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('5', 'Casaig, Mecca Ella', '04-2122-123459', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('6', 'Gamboa, Monic', '04-2122-123410', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('7', 'Gabitanan, Shane', '04-2122-123411', 'CAPSTONE 2', '89', '85', '90', '88', '2.5', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('8', 'Lagunday, Eudelyn', '04-2122-123412', 'CAPSTONE 2', '89', '85', '90', '88', '2.75', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('9', 'Marbebe, Genalyn', '04-2122-123413', 'CAPSTONE 2', '89', '85', '90', '88', '3', 'PASSED', 'AY 2023-2024 1st SEM', 'kurt', 'ITE 305 - BSIT3-2.csv', ''),
('1', 'Sarona , John Rey ', '04-2122-032649', 'CAPSTONE 2', '89', '89', '89', '89', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', ''),
('2', 'Tirado, Patric John', '04-2122-123456', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', ''),
('3', 'Bunagan, Sean Carlo', '04-2122-123457', 'CAPSTONE 2', '89', '85', '90', '88', '2.5', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', ''),
('3', 'Tangete, Ma. Fatima', '04-2122-123458', 'CAPSTONE 2', '89', '85', '90', '88', '3', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', ''),
('5', 'Casaig, Mecca Ella', '04-2122-123459', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', ''),
('6', 'Gamboa, Monic', '04-2122-123410', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', ''),
('7', 'Gabitanan, Shane', '04-2122-123411', 'CAPSTONE 2', '89', '85', '90', '88', '2.5', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', ''),
('8', 'Lagunday, Eudelyn', '04-2122-123412', 'CAPSTONE 2', '89', '85', '90', '88', '2.75', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', ''),
('9', 'Marbebe, Genalyn', '04-2122-123413', 'CAPSTONE 2', '89', '85', '90', '88', '3', 'PASSED', 'AY 2023-2024 2nd SEM', 'kurt', 'ITE 305 - BSIT3-1.csv', '');

-- --------------------------------------------------------

--
-- Table structure for table `dean`
--

CREATE TABLE `dean` (
  `ID` int(11) NOT NULL,
  `TEACHER_ID` varchar(50) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dean`
--

INSERT INTO `dean` (`ID`, `TEACHER_ID`, `NAME`, `PASSWORD`) VALUES
(1, '001', 'Seth dA. Nono', 'wearecite2024');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `FEEDBACK_ID` int(11) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `q1` int(10) NOT NULL,
  `q2` int(10) NOT NULL,
  `q3` int(10) NOT NULL,
  `q4` int(10) NOT NULL,
  `q5` int(10) NOT NULL,
  `q6` int(10) NOT NULL,
  `total_rating` int(10) NOT NULL,
  `FEEDBACKS` varchar(255) DEFAULT NULL,
  `TIME_SENT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`FEEDBACK_ID`, `NAME`, `q1`, `q2`, `q3`, `q4`, `q5`, `q6`, `total_rating`, `FEEDBACKS`, `TIME_SENT`) VALUES
(40, 'Kurt Ellie Hidalgo Ravena', 5, 5, 5, 5, 5, 5, 30, 'wew', '2024-02-22 12:05:38'),
(41, 'Kurt Ellie Hidalgo Ravena', 5, 5, 5, 5, 5, 5, 30, 'wewww', '2024-02-22 12:10:49'),
(42, 'Kurt Ellie Hidalgo Ravena', 5, 5, 5, 5, 5, 5, 30, 'wew', '2024-02-22 14:49:40'),
(43, 'Kurt Ellie Hidalgo Ravena', 5, 5, 5, 5, 5, 5, 30, 'wew', '2024-02-22 15:27:59'),
(44, 'Kurt Ellie Hidalgo Ravena', 5, 5, 5, 5, 5, 5, 30, 'sheeshable', '2024-02-22 15:38:17'),
(45, 'Kurt Ellie Hidalgo Ravena', 5, 5, 5, 5, 5, 5, 30, 'pogi sige na', '2024-02-22 15:40:28');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `STUDENT_ID` varchar(50) NOT NULL,
  `FULL_NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`STUDENT_ID`, `FULL_NAME`, `PASSWORD`) VALUES
('04-2122-032649', 'Sarona John  Rey', 'mama1'),
('04-2122-034990', 'Tirado Patric John', '123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`TEACHER_ID`);

--
-- Indexes for table `dean`
--
ALTER TABLE `dean`
  ADD PRIMARY KEY (`TEACHER_ID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`FEEDBACK_ID`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`STUDENT_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `FEEDBACK_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
