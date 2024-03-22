-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2024 at 12:22 PM
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
  `TEACHER_ID` varchar(50) NOT NULL,
  `FACULTY_NAME` varchar(50) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `ACTION_REMARKS` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `citestudents`
--

INSERT INTO `citestudents` (`ID`, `NAME`, `STUDENT_ID`, `SUBJECT`, `P1`, `P2`, `P3`, `FINAL_GRADE`, `NUMERIC_GRADE`, `REMARKS`, `ACADEMIC_YEAR`, `TEACHER_ID`, `FACULTY_NAME`, `filename`, `ACTION_REMARKS`) VALUES
('1', 'Sarona , John Rey ', '04-2122-032649', 'CAPSTONE 2', '89', '89', '89', '89', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', ''),
('2', 'Tirado, Patric John', '04-2122-123456', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', ''),
('3', 'Bunagan, Sean Carlo', '04-2122-123457', 'CAPSTONE 2', '89', '85', '90', '88', '2.5', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', 'F2F EVALUATION'),
('3', 'Tangete, Ma. Fatima', '04-2122-123458', 'CAPSTONE 2', '89', '85', '90', '88', '3', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', 'F2F EVALUATION'),
('5', 'Casaig, Mecca Ella', '04-2122-123459', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', ''),
('6', 'Gamboa, Monic', '04-2122-123410', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', ''),
('7', 'Gabitanan, Shane', '04-2122-123411', 'CAPSTONE 2', '89', '85', '90', '88', '2.5', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', ''),
('8', 'Lagunday, Eudelyn', '04-2122-123412', 'CAPSTONE 2', '89', '85', '90', '88', '2.75', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', ''),
('9', 'Marbebe, Genalyn', '04-2122-123413', 'CAPSTONE 2', '89', '85', '90', '88', '3', 'PASSED', 'AY 2023-2024 2nd SEM', '002', 'Melene Akil', 'ITE 305 - BSIT3-1.csv', 'F2F EVALUATION'),
('1', 'Sarona , John Rey ', '04-2122-032649', 'CAPSTONE 2', '89', '89', '89', '89', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', ''),
('2', 'Tirado, Patric John', '04-2122-123456', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', ''),
('3', 'Bunagan, Sean Carlo', '04-2122-123457', 'CAPSTONE 2', '89', '85', '90', '88', '2.5', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', 'F2F EVALUATION'),
('3', 'Tangete, Ma. Fatima', '04-2122-123458', 'CAPSTONE 2', '89', '85', '90', '88', '3', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', 'F2F EVALUATION'),
('5', 'Casaig, Mecca Ella', '04-2122-123459', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', ''),
('6', 'Gamboa, Monic', '04-2122-123410', 'CAPSTONE 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', ''),
('7', 'Gabitanan, Shane', '04-2122-123411', 'CAPSTONE 2', '89', '85', '90', '88', '2.5', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', ''),
('8', 'Lagunday, Eudelyn', '04-2122-123412', 'CAPSTONE 2', '89', '85', '90', '88', '2.75', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', ''),
('9', 'Marbebe, Genalyn', '04-2122-123413', 'CAPSTONE 2', '89', '85', '90', '88', '3', 'PASSED', 'AY 2023-2024 2nd SEM', '003', 'Kurt Ellie Hidalgo Ravena', 'ITE 305 - BSIT3-1.csv', 'CALL EVALUATION');

-- --------------------------------------------------------

--
-- Table structure for table `dean`
--

CREATE TABLE `dean` (
  `ID` int(11) NOT NULL,
  `DEAN_ID` varchar(50) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dean`
--

INSERT INTO `dean` (`ID`, `DEAN_ID`, `NAME`, `PASSWORD`) VALUES
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
(45, 'Kurt Ellie Hidalgo Ravena', 5, 5, 5, 5, 5, 5, 30, 'pogi sige na', '2024-02-22 15:40:28'),
(46, 'Melene Akil', 5, 5, 5, 5, 5, 5, 30, 'Cutieee', '2024-03-14 07:24:50');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `STUDENT_ID` varchar(50) NOT NULL,
  `STUDENT_MAIL` varchar(50) NOT NULL,
  `FULL_NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `PERSONAL_MAIL` varchar(50) NOT NULL,
  `PHONE_NUMBER` varchar(50) NOT NULL,
  `FB_LINK` varchar(50) NOT NULL,
  `STREET` varchar(50) NOT NULL,
  `CITY` varchar(50) NOT NULL,
  `MUNICIPALITY` varchar(50) NOT NULL,
  `ZIP_CODE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`STUDENT_ID`, `STUDENT_MAIL`, `FULL_NAME`, `PASSWORD`, `PERSONAL_MAIL`, `PHONE_NUMBER`, `FB_LINK`, `STREET`, `CITY`, `MUNICIPALITY`, `ZIP_CODE`) VALUES
('04-2122-032649', 'jotu.sarona.ui@phinmaed.com', 'Sarona John Rey', '$2b$12$7nfnNN2/ca8MfOb4OhnF4e7VR5i/r.kUGrpaH3831J/', 'johnreysarona2@gmail.com', '09129343954', 'https://www.facebook.com/babyjohnreysarona', 'Allera Street', 'Iloilo', 'Tigbauan', '5021');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `TEACHER_ID` varchar(50) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `UI_MAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`TEACHER_ID`, `NAME`, `UI_MAIL`, `PASSWORD`) VALUES
('002', 'Melene Akil', 'meak.akil.ui@phinmaed.com', '$2b$12$BLgKJzY8FM9J1jctOGHOXOFxg.c9ZkcCJ.euZjx/xBm'),
('003', 'Kurt Ellie Hidalgo Ravena', 'kuhi.ravena.ui@phinmaed.com', '$2b$12$/DwiJZ7on.keM2hBRh3fWeTjO8TqqHa031sTfSR3lxm');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dean`
--
ALTER TABLE `dean`
  ADD PRIMARY KEY (`DEAN_ID`);

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
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`TEACHER_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `FEEDBACK_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
