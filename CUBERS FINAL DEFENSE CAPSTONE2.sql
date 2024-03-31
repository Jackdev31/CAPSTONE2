-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2024 at 10:06 AM
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
-- Table structure for table `actiontaken`
--

CREATE TABLE `actiontaken` (
  `STUDENT_NAME` varchar(50) NOT NULL,
  `ACADEMIC_YEAR` varchar(50) NOT NULL,
  `ACTION_REMARKS` varchar(50) NOT NULL,
  `TEACHER_ID` varchar(50) NOT NULL,
  `FACULTY_NAME` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
('1', ' Diamante, Jenuel P.', '04-1718-02418', 'ITE 306 - integrative Programming and Technologies', '44', '41', '55', '46.66666667', '5', 'NO CREDIT', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('2', 'Ulysses E. Nava', '04-1819-03265', 'ITE 306 - integrative Programming and Technologies', '49', '44', '52', '48.33333333', '5', 'NO CREDIT', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('3', 'Robert Jr. H. Santiago', '04-1920-00279', 'ITE 306 - integrative Programming and Technologies', '50', '60', '50', '53.33333333', '3', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('3', 'Daisy M. Salao', '04-2122-034823', 'ITE 306 - integrative Programming and Technologies', '50', '50', '50', '50', '3', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('5', 'Jocel C. Espina', '04-2122-031467', 'ITE 306 - integrative Programming and Technologies', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('6', 'Mary Grace  P. Tabarnero', '04-1920-00805', 'ITE 306 - integrative Programming and Technologies', '78', '77', '67', '74', '2', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('7', 'Janela M. Cardabos', '04-2122-034261', 'ITE 306 - integrative Programming and Technologies', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('8', 'Friethz Kia Joy N. Suela', '04-2122-032469', 'ITE 306 - integrative Programming and Technologies', '68', '59', '70', '65.66666667', '2.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('9', 'Rizaba, Angel Mae A.', '04-1920-00138', 'ITE 306 - integrative Programming and Technologies', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('10', 'Cordova, Renz Benedict S.', '04-2122-034572', 'ITE 306 - integrative Programming and Technologies', '89', '88', '90', '89', '1.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 306 - BSIT3-1 K.csv', ''),
('1', ' Jornadal , John M. Jr.', '04-1920-01346', 'ITE 382 - Intelligent System', '87', '90', '93', '90', '1.25', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('2', ' Fuerte, Jhon Rey E.', '04-2122-030128', 'ITE 382 - Intelligent System', '65', '86', '79', '76.66666667', '2', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('3', 'Gallaron, John Lloyd R.', '04-2122-032624', 'ITE 382 - Intelligent System', '50', '60', '50', '53.33333333', '3', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('4', 'Esmenda,  Josua ', '04-2122-033839', 'ITE 382 - Intelligent System', '57', '42', '50', '49.66666667', '5', 'NO CREDIT', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('5', 'Ganancial,  Rhea Bhell N.', '04-2122-001178', 'ITE 382 - Intelligent System', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('6', 'Gallo, Loribel A.', '04-2122-031602', 'ITE 382 - Intelligent System', '49', '49', '48', '48.66666667', '5', 'NO CREDIT', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('7', 'Anaud, Joylyn U.', '04-2122-031370', 'ITE 382 - Intelligent System', '69', '49', '79', '65.66666667', '2.5', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('8', 'Sardua, Janin Rose A.', '04-2122-031240', 'ITE 382 - Intelligent System', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('9', 'Almirante,  Floriden A.', '04-2122-032215', 'ITE 382 - Intelligent System', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('10', 'Gabutin,  John Daryll G.', '04-2122-033034', 'ITE 382 - Intelligent System', '99', '98', '100', '99', '1', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-22-167-F', 'Kurt Ellie Parel', 'ITE 382 - BSIT3-2 K.csv', ''),
('1', 'Tirado, Patric John T.', '04-2122-034990', 'ITE 186 - Computer Programming 2', '55', '49', '44', '49.33333333', '5', 'NO CREDIT', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', 'F2F EVALUATION'),
('2', 'Sarona, John Rey T.', '04-2122-032649', 'ITE 186 - Computer Programming 2', '48', '54', '45', '49', '5', 'NO CREDIT', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', 'CALL EVALUATION '),
('3', 'Bunagan, Sean Carlo T.', '04-2122-031410', 'ITE 186 - Computer Programming 2', '86', '91', '90', '89', '1.5', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', ''),
('3', 'Casaig, Mecca Ella', '04-2122-001219', 'ITE 186 - Computer Programming 2', '50', '50', '50', '50', '3', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', ''),
('5', 'Aguilar, Frenz Louie G.', '04-1920-01342', 'ITE 186 - Computer Programming 2', '78', '88', '65', '77', '2', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', ''),
('6', 'Marbebe, Genalyn Mae', '04-2122-034632', 'ITE 186 - Computer Programming 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', ''),
('7', 'Buslon, Ia Xylln A.', '04-1617-01658', 'ITE 186 - Computer Programming 2', '77', '74', '73', '74.66666667', '2', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', ''),
('8', 'Dacaldacal, Jennifer', '04-2122-032465', 'ITE 186 - Computer Programming 2', '69', '75', '79', '74.33333333', '2', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', ''),
('9', 'Paulino, Eunice Tricxie', '04-2122-033804', 'ITE 186 - Computer Programming 2', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', ''),
('10', 'Gamitanan, Berlene Shane ', '04-1920-00649', 'ITE 186 - Computer Programming 2', '99', '87', '89', '91.66666667', '1.25', 'PASSED', 'AY 2023-2024 2ND SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 186 BSIT3-2 M.csv', ''),
('1', 'Sabidong, Jyseth S.', '04-2122-034222', 'ITE 260 - Computer Programming 1', '88', '90', '82', '86.66666667', '1.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('2', 'Diana, julliane Nicole', '04-2122-033376', 'ITE 260 - Computer Programming 1', '77', '75', '77', '76.33333333', '2', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('3', 'Salvacion, Daniel John', '04-1920-01024', 'ITE 260 - Computer Programming 1', '50', '60', '50', '53.33333333', '3', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('3', 'Villanueva, Alyssa Marie', '04-2122-031630', 'ITE 260 - Computer Programming 1', '50', '50', '50', '50', '3', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('5', 'Valdez, Paulyn Joy', '04-2122-033127', 'ITE 260 - Computer Programming 1', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('6', 'Jimanga, Jose Miguel', '04-1920-035338', 'ITE 260 - Computer Programming 1', '67', '81', '73', '73.66666667', '2', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('7', 'Tahum, Romea Janne', '04-2122-001114', 'ITE 260 - Computer Programming 1', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('8', 'Tronsal, Meshyla Mae', '04-2122-032063', 'ITE 260 - Computer Programming 1', '89', '85', '90', '88', '1.5', 'PASSED', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('9', 'Sumbe, John Rey L', '04-1920-01489', 'ITE 260 - Computer Programming 1', '57', '44', '45', '48.66666667', '5', 'NO CREDIT', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', ''),
('10', 'Sicatin, Justin Carl S.', '04-2122-035230', 'ITE 260 - Computer Programming 1', '33', '44', '48', '41.66666667', '5', 'NO CREDIT', 'AY 2023-2024 1ST SEM', 'UI-23-335-F', 'Melene Akil', 'ITE 260 - BSIT3-1 M.csv', '');

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
(0, 'UI-09-139-F', 'Seth dA. Nono', 'Wearecite@2024');

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
(1, 'Melene Akil', 5, 5, 5, 5, 5, 5, 30, 'She\'s wonderful', '2024-03-29 21:39:42');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `STUDENT_ID` varchar(50) NOT NULL,
  `STUDENT_MAIL` varchar(50) NOT NULL,
  `FULL_NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
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
('04-2122-032649', 'jotu.sarona.ui@phinmaed.com', 'Sarona John Rey', '$2b$12$Cwr7D5c23t72OeCoOxLTi.1uyDqWNLTD2ik7526KYqZJLG5N4f.qm', '', '09129343954', '', '', '', '', ''),
('04-2122-034990', 'patr.tirado.ui@phinmaed.com', 'Tirado, Patric John T.', '$2b$12$36LYMTUezlVQbdnb4vgnUuKP6df1L5MguQp0.VNPzOT.VEA0YSg4q', '', '09165759447', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `TEACHER_ID` varchar(50) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `UI_MAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`TEACHER_ID`, `NAME`, `UI_MAIL`, `PASSWORD`) VALUES
('UI-22-167-F', 'Kurt Ellie Parel', 'kparel.ui@phinmae.com', '$2b$12$sd5Od9g.W9WtirJeoWED7uHrvyOyvVhE8C9sFyE/dLrLaDrHWOYdu'),
('UI-23-335-F', 'Melene Akil', 'mgakil.ui@phinmaed.com', '$2b$12$XyZEMCNdFuxzbPpdZeadHegBTEiDHjkkpL.Oo.1U78Sls2vESeHIC');

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
  MODIFY `FEEDBACK_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
