-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 29, 2024 at 11:22 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Library Management System`
--

-- --------------------------------------------------------

--
-- Table structure for table `Author`
--

CREATE TABLE `Author` (
  `Author_Id` int(11) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Author`
--

INSERT INTO `Author` (`Author_Id`, `First_Name`, `Last_Name`) VALUES
(1, 'Jane', 'Austen'),
(2, 'Fyodor', 'Dostoevsky'),
(3, 'William', 'Shakespeare');

-- --------------------------------------------------------

--
-- Table structure for table `Author_Book`
--

CREATE TABLE `Author_Book` (
  `Author_Id` int(11) NOT NULL,
  `Book_Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Author_Book`
--

INSERT INTO `Author_Book` (`Author_Id`, `Book_Id`) VALUES
(1, 3),
(2, 1),
(3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Book`
--

CREATE TABLE `Book` (
  `Book_Id` int(11) NOT NULL,
  `Category_Id` int(11) NOT NULL,
  `Title` varchar(200) NOT NULL,
  `Publication_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Book`
--

INSERT INTO `Book` (`Book_Id`, `Category_Id`, `Title`, `Publication_Date`) VALUES
(1, 1, 'Pride and Prejudice', '1813-01-28'),
(2, 1, '1984', '1949-06-08'),
(3, 3, 'The Adventures of Tom Sawyer', '1876-06-01');

-- --------------------------------------------------------

--
-- Table structure for table `Category`
--

CREATE TABLE `Category` (
  `Category_Id` int(11) NOT NULL,
  `Category_Name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Category`
--

INSERT INTO `Category` (`Category_Id`, `Category_Name`) VALUES
(1, 'Fiction'),
(4, 'Mystery'),
(2, 'Non Fiction'),
(3, 'Romance');

-- --------------------------------------------------------

--
-- Table structure for table `Fine`
--

CREATE TABLE `Fine` (
  `Fine_Id` int(11) NOT NULL,
  `Loan_Id` int(11) NOT NULL,
  `Fine_Date` date NOT NULL,
  `Payment_Status` varchar(20) DEFAULT NULL CHECK (`Payment_Status` in ('Pending','Paid','Overdue')),
  `Fine_Amount` decimal(10,2) DEFAULT NULL CHECK (`Fine_Amount` > 0)
) ;

--
-- Dumping data for table `Fine`
--

INSERT INTO `Fine` (`Fine_Id`, `Loan_Id`, `Fine_Date`, `Payment_Status`, `Fine_Amount`) VALUES
(1, 1, '2023-11-20', 'Pending', 50.00),
(2, 2, '2023-11-21', 'Paid', 20.00),
(3, 3, '2023-11-26', 'Overdue', 75.00);

-- --------------------------------------------------------

--
-- Table structure for table `Fine_Payment`
--

CREATE TABLE `Fine_Payment` (
  `Payment_Id` int(11) NOT NULL,
  `Member_Id` int(11) NOT NULL,
  `Payment_Amount` decimal(10,2) NOT NULL CHECK (`Payment_Amount` > 0),
  `Payment_Date` date NOT NULL
) ;

--
-- Dumping data for table `Fine_Payment`
--

INSERT INTO `Fine_Payment` (`Payment_Id`, `Member_Id`, `Payment_Amount`, `Payment_Date`) VALUES
(1, 1, 50.00, '2023-11-25'),
(2, 2, 20.00, '2023-11-22'),
(3, 3, 75.00, '2023-11-27');

-- --------------------------------------------------------

--
-- Table structure for table `Loan`
--

CREATE TABLE `Loan` (
  `Loan_Id` int(11) NOT NULL,
  `Member_Id` int(11) NOT NULL,
  `Book_Id` int(11) NOT NULL,
  `Staff_Id` int(11) NOT NULL,
  `Loan_Date` date NOT NULL,
  `Due_Date` date NOT NULL CHECK (`Due_Date` > `Loan_Date`),
  `Return_Date` date DEFAULT NULL CHECK (`Return_Date` >= `Loan_Date`),
  `Status` varchar(20) DEFAULT NULL CHECK (`Status` in ('Active','Returned','Overdue'))
) ;

--
-- Dumping data for table `Loan`
--

INSERT INTO `Loan` (`Loan_Id`, `Member_Id`, `Book_Id`, `Staff_Id`, `Loan_Date`, `Due_Date`, `Return_Date`, `Status`) VALUES
(1, 1, 1, 1, '2023-11-01', '2023-11-15', NULL, 'Active'),
(2, 2, 2, 2, '2023-11-05', '2023-11-20', '2023-11-19', 'Returned'),
(3, 3, 3, 3, '2023-11-10', '2023-11-25', NULL, 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `Member`
--

CREATE TABLE `Member` (
  `Member_Id` int(11) NOT NULL,
  `Staff_Id` int(11) DEFAULT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `DOB` date DEFAULT NULL,
  `Phone_Num` varchar(20) DEFAULT NULL,
  `Active_Status` tinyint(1) DEFAULT 1,
  `Reg_Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Member`
--

INSERT INTO `Member` (`Member_Id`, `Staff_Id`, `First_Name`, `Last_Name`, `DOB`, `Phone_Num`, `Active_Status`, `Reg_Date`) VALUES
(1, 1, 'Salma', 'Khaled', '1990-05-15', '987-654-3210', 1, '2023-01-01'),
(2, 2, 'Shahd', 'Ahmed', '1995-08-20', '123-123-1234', 1, '2023-02-01'),
(3, 3, 'Shahd', 'Anwar', '1985-03-15', '456-456-4567', 0, '2023-03-01');

-- --------------------------------------------------------

--
-- Table structure for table `M_Email`
--

CREATE TABLE `M_Email` (
  `Member_Id` int(11) NOT NULL,
  `Email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `M_Email`
--

INSERT INTO `M_Email` (`Member_Id`, `Email`) VALUES
(1, 'salmakhaled@gmail.com.com'),
(2, 'shahdahmed@yahoo.com'),
(3, 'shahdanwar@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `Reservation`
--

CREATE TABLE `Reservation` (
  `Res_Id` int(11) NOT NULL,
  `Book_Id` int(11) NOT NULL,
  `Member_Id` int(11) NOT NULL,
  `Reservation_Date` date NOT NULL,
  `Res_Status` varchar(20) DEFAULT NULL CHECK (`Res_Status` in ('Pending','Confirmed','Cancelled'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Reservation`
--

INSERT INTO `Reservation` (`Res_Id`, `Book_Id`, `Member_Id`, `Reservation_Date`, `Res_Status`) VALUES
(1, 1, 1, '2023-12-01', 'Pending'),
(2, 2, 2, '2023-12-10', 'Confirmed'),
(3, 3, 3, '2023-12-15', 'Cancelled'),
(4, 2, 1, '2023-12-20', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `Staff`
--

CREATE TABLE `Staff` (
  `Staff_Id` int(11) NOT NULL,
  `Job_Title` varchar(100) NOT NULL,
  `Phone_Num` varchar(20) DEFAULT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL
) ;

--
-- Dumping data for table `Staff`
--

INSERT INTO `Staff` (`Staff_Id`, `Job_Title`, `Phone_Num`, `First_Name`, `Last_Name`) VALUES
(1, 'Librarian', '123-456-7890', 'Emily', 'Smith'),
(2, 'Assistant Librarian', '321-654-0987', 'Sarah', 'Brown'),
(3, 'Library Clerk', '654-321-8765', 'Michael', 'Johnson');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Author`
--
ALTER TABLE `Author`
  ADD PRIMARY KEY (`Author_Id`);

--
-- Indexes for table `Author_Book`
--
ALTER TABLE `Author_Book`
  ADD PRIMARY KEY (`Author_Id`,`Book_Id`),
  ADD KEY `Book_Id` (`Book_Id`);

--
-- Indexes for table `Book`
--
ALTER TABLE `Book`
  ADD PRIMARY KEY (`Book_Id`),
  ADD KEY `Category_Id` (`Category_Id`);

--
-- Indexes for table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`Category_Id`),
  ADD UNIQUE KEY `Category_Name` (`Category_Name`);

--
-- Indexes for table `Fine`
--
ALTER TABLE `Fine`
  ADD PRIMARY KEY (`Fine_Id`,`Loan_Id`),
  ADD KEY `Loan_Id` (`Loan_Id`);

--
-- Indexes for table `Fine_Payment`
--
ALTER TABLE `Fine_Payment`
  ADD PRIMARY KEY (`Payment_Id`),
  ADD KEY `Member_Id` (`Member_Id`);

--
-- Indexes for table `Loan`
--
ALTER TABLE `Loan`
  ADD PRIMARY KEY (`Loan_Id`),
  ADD KEY `Member_Id` (`Member_Id`),
  ADD KEY `Book_Id` (`Book_Id`),
  ADD KEY `Staff_Id` (`Staff_Id`);

--
-- Indexes for table `Member`
--
ALTER TABLE `Member`
  ADD PRIMARY KEY (`Member_Id`),
  ADD KEY `Staff_Id` (`Staff_Id`);

--
-- Indexes for table `M_Email`
--
ALTER TABLE `M_Email`
  ADD PRIMARY KEY (`Member_Id`,`Email`);

--
-- Indexes for table `Reservation`
--
ALTER TABLE `Reservation`
  ADD PRIMARY KEY (`Res_Id`),
  ADD KEY `Book_Id` (`Book_Id`),
  ADD KEY `Member_Id` (`Member_Id`);

--
-- Indexes for table `Staff`
--
ALTER TABLE `Staff`
  ADD PRIMARY KEY (`Staff_Id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Author_Book`
--
ALTER TABLE `Author_Book`
  ADD CONSTRAINT `author_book_ibfk_1` FOREIGN KEY (`Author_Id`) REFERENCES `Author` (`Author_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `author_book_ibfk_2` FOREIGN KEY (`Book_Id`) REFERENCES `Book` (`Book_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Book`
--
ALTER TABLE `Book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`Category_Id`) REFERENCES `Category` (`Category_Id`) ON UPDATE CASCADE;

--
-- Constraints for table `Fine`
--
ALTER TABLE `Fine`
  ADD CONSTRAINT `fine_ibfk_1` FOREIGN KEY (`Loan_Id`) REFERENCES `Loan` (`Loan_Id`) ON UPDATE CASCADE;

--
-- Constraints for table `Fine_Payment`
--
ALTER TABLE `Fine_Payment`
  ADD CONSTRAINT `fine_payment_ibfk_1` FOREIGN KEY (`Member_Id`) REFERENCES `Member` (`Member_Id`) ON UPDATE CASCADE;

--
-- Constraints for table `Loan`
--
ALTER TABLE `Loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`Member_Id`) REFERENCES `Member` (`Member_Id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`Book_Id`) REFERENCES `Book` (`Book_Id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`Staff_Id`) REFERENCES `Staff` (`Staff_Id`) ON UPDATE CASCADE;

--
-- Constraints for table `Member`
--
ALTER TABLE `Member`
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`Staff_Id`) REFERENCES `Staff` (`Staff_Id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `M_Email`
--
ALTER TABLE `M_Email`
  ADD CONSTRAINT `m_email_ibfk_1` FOREIGN KEY (`Member_Id`) REFERENCES `Member` (`Member_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Reservation`
--
ALTER TABLE `Reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`Book_Id`) REFERENCES `Book` (`Book_Id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`Member_Id`) REFERENCES `Member` (`Member_Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
