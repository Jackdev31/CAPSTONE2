-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2024 at 09:12 AM
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
  `FEEDBACKS` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`FEEDBACK_ID`, `NAME`, `q1`, `q2`, `q3`, `q4`, `q5`, `q6`, `total_rating`, `FEEDBACKS`) VALUES
(14, 'Kurt Ellie Hidalgo Ravena', 5, 5, 5, 5, 5, 5, 30, 'gwapo'),
(15, 'Ryan Valeriano', 5, 5, 5, 5, 5, 5, 30, 'supergwapo'),
(16, 'Kurt Ellie Hidalgo Ravena', 4, 4, 4, 4, 4, 4, 24, 'gwapo lang'),
(17, 'Tony Zuniega', 1, 1, 1, 1, 1, 1, 6, 'pinaka pogi');

-- --------------------------------------------------------

--
-- Table structure for table `section3_1`
--

CREATE TABLE `section3_1` (
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
  `username` varchar(50) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `ACTION_REMARKS` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section3_1`
--

INSERT INTO `section3_1` (`ID`, `NAME`, `STUDENT_ID`, `SUBJECT`, `P1`, `P2`, `P3`, `FINAL_GRADE`, `NUMERIC_GRADE`, `REMARKS`, `username`, `filename`, `ACTION_REMARKS`) VALUES
('1', 'Sarona , John Rey ', '04-2122-032649', 'CAPSTONE 2', '89', '89', '89', '79', '1', 'PASSED', 'kurt', 'copy format1.csv', ''),
('2', 'Tirado, Patric John', '04-2122-123456', 'CAPSTONE 2', '89', '85', '90', '79', '1.5', 'PASSED', 'kurt', 'copy format1.csv', ''),
('3', 'Bunagan, Sean Carlo', '04-2122-123457', 'CAPSTONE 2', '89', '85', '90', '79', '1.5', 'PASSED', 'kurt', 'copy format1.csv', ''),
('3', 'Tangete, Ma. Fatima', '04-2122-123458', 'CAPSTONE 2', '89', '85', '90', '79', '1.75', 'PASSED', 'kurt', 'copy format1.csv', ''),
('5', 'Casaig, Mecca Ella', '04-2122-123459', 'CAPSTONE 2', '89', '85', '90', '79', '3', 'PASSED', 'kurt', 'copy format1.csv', 'No Action'),
('6', 'Gamboa, Monic', '04-2122-123410', 'CAPSTONE 2', '89', '85', '90', '79', '1.5', 'PASSED', 'kurt', 'copy format1.csv', ''),
('7', 'Gabitanan, Shane', '04-2122-123411', 'CAPSTONE 2', '89', '85', '90', '79', '2.75', 'PASSED', 'kurt', 'copy format1.csv', ''),
('8', 'Lagunday, Eudelyn', '04-2122-123412', 'CAPSTONE 2', '89', '85', '90', '79', '2.5', 'PASSED', 'kurt', 'copy format1.csv', ''),
('9', 'Marbebe, Genalyn', '04-2122-123413', 'CAPSTONE 2', '89', '85', '90', '79', '3', 'PASSED', 'kurt', 'copy format1.csv', 'Call Evaluation');

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
  MODIFY `FEEDBACK_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
