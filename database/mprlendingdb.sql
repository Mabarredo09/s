-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2025 at 02:47 AM
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
-- Database: `mprlendingdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `home_no` varchar(100) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `barangay` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `home_no`, `street`, `barangay`, `city`, `province`, `region`, `created_at`) VALUES
(9, '1213', 'ljk', '', 'asdd', 'lkj', 'a', '2025-02-14 02:50:42'),
(10, 'qwe', 'ljk', 'poblacion west 3', 'Aliaga', 'lkj', 'jlkh', '2025-02-14 02:50:42'),
(11, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-14 03:22:55'),
(12, 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', 'ewq', '2025-02-14 03:22:55'),
(15, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-20 00:56:31'),
(16, 'qwe', 'ljk', 'qwe', ';l', 'lkj', 'qwe', '2025-02-20 00:56:31'),
(21, '12', 'Regina', 'Pob. East 1', 'Aliaga', 'Nueva ecija', '4', '2025-02-24 00:58:23'),
(22, '1312321', 'Purok 7', 'west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ', '4', '2025-02-24 00:58:23'),
(23, '69', 'para sa street', 'asd', 'sample', 'asda', 'asdas', '2025-02-26 07:20:00'),
(24, '1', 'sample', 'asd', 'sample', 'sample', 'test', '2025-02-26 07:20:00'),
(29, '69', 'salera st. ', 'bitalag', 'bacnotan ', 'la union', 'catholic charot haha', '2025-03-04 07:15:14'),
(30, 'paulit ulit ', 'ulit ', 'ulit', 'ulit', 'ulit', 'uli', '2025-03-04 07:15:14'),
(31, '1213', 'Purok 7', 'poblacion west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ecija', '3', '2025-03-06 07:00:57'),
(32, '22222', 'Purok 7', 'west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ', '4', '2025-03-06 07:00:57'),
(33, '12312', 'Purok 7', 'brgy. batuta', 'Talavera', 'Nueva ecija', '4', '2025-03-14 01:02:42'),
(34, '1312321', 'Purok 7', 'east 2', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ecija', '3', '2025-03-14 01:02:42'),
(37, '1213', 'Purok 7', 'poblacion west 3', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ecija', '3', '2025-03-24 01:19:00'),
(38, '22222', 'Purok 7', 'east 2', 'Cabanatuan/Aliaga/Nueva Ecija', 'nueva ecija', '3', '2025-03-24 01:19:00');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `performed_by` varchar(255) NOT NULL,
  `action` text NOT NULL,
  `category` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `date`, `time`, `performed_by`, `action`, `category`, `created_at`) VALUES
(667, '2025-03-12', '10:18:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-12 02:18:18'),
(668, '2025-03-12', '10:18:27', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new grocery item (Ref: GR-3133E9) worth ₱10,000.00 for borrower: Athara Mariel  Mendoza Negrillo', 'Grocery Management', '2025-03-12 02:18:27'),
(669, '2025-03-12', '10:34:49', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: atha', 'Search Terms', '2025-03-12 02:34:49'),
(670, '2025-03-12', '10:49:56', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr searched for term: a', 'Search Terms', '2025-03-12 02:49:56'),
(671, '2025-03-12', '10:50:40', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr updated borrower information for: Michael Punzalan Seva', 'Borrower Management logs', '2025-03-12 02:50:40'),
(672, '2025-03-12', '10:50:56', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr updated borrower information for: Michael Punzalan Seva', 'Borrower Management logs', '2025-03-12 02:50:56'),
(673, '2025-03-12', '11:03:38', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: maic', 'Search Terms', '2025-03-12 03:03:38'),
(674, '2025-03-12', '11:03:40', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-12 03:03:40'),
(675, '2025-03-12', '11:03:41', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mic', 'Search Terms', '2025-03-12 03:03:41'),
(676, '2025-03-12', '11:03:52', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot updated borrower information for: Michael Punzalan Seva', 'Borrower Management logs', '2025-03-12 03:03:52'),
(677, '2025-03-12', '11:33:08', 'Mark Nathaniel D. Olpot jr', 'Mark Nathaniel D. Olpot jr logged out', 'Admin Activity Log', '2025-03-12 03:33:08'),
(678, '2025-03-12', '11:33:12', 'mang berting inamo', 'mang berting inamo logged in as user', 'User Authentication', '2025-03-12 03:33:12'),
(679, '2025-03-12', '11:33:17', 'mang berting inamo', 'mang berting inamo searched for term: a', 'Search Terms', '2025-03-12 03:33:17'),
(680, '2025-03-12', '11:44:12', 'mang berting inamo', 'mang berting inamo logged out', 'Admin Activity Log', '2025-03-12 03:44:12'),
(681, '2025-03-12', '11:44:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-12 03:44:18'),
(682, '2025-03-12', '13:46:35', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-12 05:46:35'),
(683, '2025-03-12', '13:47:09', 'Takahiro S. Inoue jr', 'Takahiro S. Inoue jr logged in as admin', 'User Authentication', '2025-03-12 05:47:09'),
(684, '2025-03-12', '13:47:22', 'Takahiro S. Inoue jr', 'Added new user: Nathaniel P. Padilla (nathpadilla81@gmail.com) with role user', 'User Management', '2025-03-12 05:47:22'),
(685, '2025-03-12', '13:47:27', 'Takahiro S. Inoue jr', 'Takahiro S. Inoue jr logged out', 'Admin Activity Log', '2025-03-12 05:47:27'),
(686, '2025-03-12', '13:47:35', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla logged in as user', 'User Authentication', '2025-03-12 05:47:35'),
(687, '2025-03-12', '13:56:58', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: at', 'Search Terms', '2025-03-12 05:56:58'),
(688, '2025-03-12', '13:56:58', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: athar', 'Search Terms', '2025-03-12 05:56:58'),
(689, '2025-03-12', '14:05:52', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-12 06:05:52'),
(690, '2025-03-12', '15:14:25', 'Mark Nathaniel D. Olpot', 'Updated user: name from \'Takahiro S. Inoue jr\' to \'Takahiro S. Inoue\'', 'User Management', '2025-03-12 07:14:25'),
(691, '2025-03-12', '08:27:59', 'Mark Nathaniel Dela Vega Olpot', 'Updated profile name from \'Mark Nathaniel D. Olpot\' to \'Mark Nathaniel Dela Vega Olpot\'', 'Profile Management', '2025-03-12 07:27:59'),
(692, '2025-03-12', '15:28:13', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: a', 'Search Terms', '2025-03-12 07:28:13'),
(693, '2025-03-12', '15:28:39', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: aty', 'Search Terms', '2025-03-12 07:28:39'),
(694, '2025-03-12', '15:28:41', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: atha', 'Search Terms', '2025-03-12 07:28:41'),
(695, '2025-03-12', '15:50:31', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged out', 'Admin Activity Log', '2025-03-12 07:50:31'),
(696, '2025-03-12', '15:52:03', 'Michael John P. Seva', 'Michael John P. Seva logged in as admin', 'User Authentication', '2025-03-12 07:52:03'),
(697, '2025-03-12', '16:16:18', 'Michael John P. Seva', 'Michael John P. Seva logged out', 'Admin Activity Log', '2025-03-12 08:16:18'),
(698, '2025-03-12', '16:16:23', 'Michael John P. Seva', 'Michael John P. Seva logged in as admin', 'User Authentication', '2025-03-12 08:16:23'),
(699, '2025-03-12', '16:38:18', 'Michael John P. Seva', 'Michael John P. Seva searched for term: a', 'Search Terms', '2025-03-12 08:38:18'),
(700, '2025-03-12', '16:45:53', 'Michael John P. Seva', 'Michael John P. Seva searched for term: m', 'Search Terms', '2025-03-12 08:45:53'),
(701, '2025-03-12', '16:46:22', 'Michael John P. Seva', 'Michael John P. Seva added new loan (Ref: LN-E310CA) worth ₱111,111.00 for borrower: Michael Punzalan Seva', 'Loan Management Logs', '2025-03-12 08:46:22'),
(702, '2025-03-12', '16:46:22', 'Michael John P. Seva', 'Michael John P. Seva added new loan (Ref: LN-E310CA) worth ₱111,111.00 for borrower: Michael Punzalan Seva', 'New Loan', '2025-03-12 08:46:22'),
(703, '2025-03-12', '09:47:40', 'Nathaniel P. Padilla', 'Updated profile picture', 'Profile Management', '2025-03-12 08:47:40'),
(704, '2025-03-14', '08:14:25', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged in as admin', 'User Authentication', '2025-03-14 00:14:25'),
(705, '2025-03-14', '08:17:08', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged in as admin', 'User Authentication', '2025-03-14 00:17:08'),
(706, '2025-03-14', '08:18:20', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: mara', 'Search Terms', '2025-03-14 00:18:20'),
(707, '2025-03-14', '08:18:21', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: mar', 'Search Terms', '2025-03-14 00:18:21'),
(708, '2025-03-14', '08:21:47', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: a', 'Search Terms', '2025-03-14 00:21:47'),
(709, '2025-03-14', '08:39:26', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: m', 'Search Terms', '2025-03-14 00:39:26'),
(710, '2025-03-14', '08:48:33', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: mar', 'Search Terms', '2025-03-14 00:48:33'),
(711, '2025-03-14', '08:48:48', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot updated borrower information for: Athara Mariel  Mendoza Negrillo', 'Borrower Management logs', '2025-03-14 00:48:48'),
(712, '2025-03-14', '09:02:42', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot added new borrower: Nathaniel  Pogi Padila', 'Borrower Management Logs', '2025-03-14 01:02:42'),
(713, '2025-03-14', '09:06:11', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: ma', 'Search Terms', '2025-03-14 01:06:11'),
(714, '2025-03-14', '09:06:13', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: nath', 'Search Terms', '2025-03-14 01:06:13'),
(715, '2025-03-14', '09:07:04', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot added new loan (Ref: LN-84CB0A) worth ₱10,000.00 for borrower: Nathaniel  Pogi Padila', 'Loan Management Logs', '2025-03-14 01:07:04'),
(716, '2025-03-14', '09:07:04', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot added new loan (Ref: LN-84CB0A) worth ₱10,000.00 for borrower: Nathaniel  Pogi Padila', 'New Loan', '2025-03-14 01:07:04'),
(717, '2025-03-14', '09:08:11', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: natah', 'Search Terms', '2025-03-14 01:08:11'),
(718, '2025-03-14', '09:08:13', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: nat', 'Search Terms', '2025-03-14 01:08:13'),
(719, '2025-03-14', '09:09:07', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: m', 'Search Terms', '2025-03-14 01:09:07'),
(720, '2025-03-14', '09:09:09', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot searched for term: na', 'Search Terms', '2025-03-14 01:09:09'),
(721, '2025-03-14', '09:11:58', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged out', 'Admin Activity Log', '2025-03-14 01:11:58'),
(722, '2025-03-14', '09:12:04', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla logged in as user', 'User Authentication', '2025-03-14 01:12:04'),
(723, '2025-03-14', '02:12:25', 'Nathaniel P. Padilla', 'Updated profile picture', 'Profile Management', '2025-03-14 01:12:25'),
(724, '2025-03-14', '09:27:32', 'Mark Nathaniel Dela Vega Olpot', 'Updated user: name from \'Takahiro S. Inoue\' to \'Takahiro S. Inoue niloko\'', 'User Management', '2025-03-14 01:27:32'),
(725, '2025-03-14', '10:28:26', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: n', 'Search Terms', '2025-03-14 02:28:26'),
(726, '2025-03-14', '10:28:27', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: na', 'Search Terms', '2025-03-14 02:28:27'),
(727, '2025-03-14', '10:29:03', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla added new loan (Ref: LN-F05214) worth ₱308.77 for borrower: Nathaniel  Pogi Padila', 'Loan Management Logs', '2025-03-14 02:29:03'),
(728, '2025-03-14', '10:29:03', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla added new loan (Ref: LN-F05214) worth ₱308.77 for borrower: Nathaniel  Pogi Padila', 'New Loan', '2025-03-14 02:29:03'),
(729, '2025-03-14', '10:29:11', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: b', 'Search Terms', '2025-03-14 02:29:11'),
(730, '2025-03-14', '10:29:12', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: n', 'Search Terms', '2025-03-14 02:29:12'),
(731, '2025-03-14', '10:29:13', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: na', 'Search Terms', '2025-03-14 02:29:13'),
(732, '2025-03-14', '11:50:09', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: n', 'Search Terms', '2025-03-14 03:50:09'),
(733, '2025-03-14', '11:50:10', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: na', 'Search Terms', '2025-03-14 03:50:10'),
(734, '2025-03-14', '11:51:59', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: n', 'Search Terms', '2025-03-14 03:51:59'),
(735, '2025-03-14', '11:52:00', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: na', 'Search Terms', '2025-03-14 03:52:00'),
(736, '2025-03-14', '13:54:58', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged in as admin', 'User Authentication', '2025-03-14 05:54:58'),
(737, '2025-03-14', '13:55:29', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: na', 'Search Terms', '2025-03-14 05:55:29'),
(738, '2025-03-14', '13:55:30', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: nat', 'Search Terms', '2025-03-14 05:55:30'),
(739, '2025-03-14', '13:55:58', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla searched for term: ta', 'Search Terms', '2025-03-14 05:55:58'),
(740, '2025-03-14', '13:56:02', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla logged out', 'Admin Activity Log', '2025-03-14 05:56:02'),
(741, '2025-03-14', '13:56:06', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged in as admin', 'User Authentication', '2025-03-14 05:56:06'),
(742, '2025-03-14', '13:56:50', 'Mark Nathaniel Dela Vega Olpot', 'Updated user: name from \'Takahiro S. Inoue niloko\' to \'Takahiro S. Inoue niloko bobo ang puta\'', 'User Management', '2025-03-14 05:56:50'),
(743, '2025-03-14', '13:57:10', 'Mark Nathaniel Dela Vega Olpot', 'Updated user: email from \'takahiroinoue16@gmail.com\' to \'takabet@gmail.com\'', 'User Management', '2025-03-14 05:57:10'),
(744, '2025-03-14', '13:57:27', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged out', 'Admin Activity Log', '2025-03-14 05:57:27'),
(745, '2025-03-14', '13:57:53', 'mang berting inamo', 'mang berting inamo logged in as user', 'User Authentication', '2025-03-14 05:57:53'),
(746, '2025-03-14', '06:58:19', 'mang berting inamo', 'Updated profile picture', 'Profile Management', '2025-03-14 05:58:19'),
(747, '2025-03-18', '08:37:32', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged in as admin', 'User Authentication', '2025-03-18 00:37:32'),
(748, '2025-03-18', '08:39:55', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged in as admin', 'User Authentication', '2025-03-18 00:39:55'),
(749, '2025-03-18', '08:46:48', 'Mark Nathaniel Dela Vega Olpot', 'Updated user: role from \'user\' to \'admin\'', 'User Management', '2025-03-18 00:46:48'),
(750, '2025-03-18', '08:46:59', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged out', 'Admin Activity Log', '2025-03-18 00:46:59'),
(751, '2025-03-18', '08:47:04', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 00:47:04'),
(752, '2025-03-18', '08:47:18', 'mang berting inamo', 'Updated user: role from \'admin\' to \'user\'', 'User Management', '2025-03-18 00:47:18'),
(753, '2025-03-18', '08:47:20', 'mang berting inamo', 'mang berting inamo logged out', 'Admin Activity Log', '2025-03-18 00:47:20'),
(754, '2025-03-18', '08:47:24', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged in as user', 'User Authentication', '2025-03-18 00:47:24'),
(755, '2025-03-18', '08:47:27', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged out', 'Admin Activity Log', '2025-03-18 00:47:27'),
(756, '2025-03-18', '08:47:31', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 00:47:31'),
(757, '2025-03-18', '08:54:44', 'mang berting inamo', 'Deleted user: Mark Nathaniel Dela Vega Olpot', 'User Management', '2025-03-18 00:54:44'),
(758, '2025-03-18', '08:54:57', 'mang berting inamo', 'Added new user: Mark Nathaniel D. Olpot (olpottado@gmail.com) with role admin', 'User Management', '2025-03-18 00:54:57'),
(759, '2025-03-18', '08:55:06', 'mang berting inamo', 'mang berting inamo logged out', 'Admin Activity Log', '2025-03-18 00:55:06'),
(760, '2025-03-18', '08:55:10', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 00:55:10'),
(761, '2025-03-18', '08:55:14', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 00:55:14'),
(762, '2025-03-18', '08:55:20', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 00:55:20'),
(763, '2025-03-18', '08:55:25', 'mang berting inamo', 'Updated user: role from \'admin\' to \'user\'', 'User Management', '2025-03-18 00:55:25'),
(764, '2025-03-18', '08:55:29', 'mang berting inamo', 'Deleted user: Takahiro S. Inoue niloko bobo ang puta', 'User Management', '2025-03-18 00:55:29'),
(765, '2025-03-18', '08:56:17', 'mang berting inamo', 'Deleted user: Mark Nathaniel D. Olpot', 'User Management', '2025-03-18 00:56:17'),
(766, '2025-03-18', '08:56:27', 'mang berting inamo', 'Added new user: Mark Nathaniel D. Olpot (olpottado@gmail.com) with role user', 'User Management', '2025-03-18 00:56:27'),
(768, '2025-03-18', '09:01:11', 'mang berting inamo', 'mang berting inamo logged out', 'Admin Activity Log', '2025-03-18 01:01:11'),
(769, '2025-03-18', '09:01:15', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla logged in as user', 'User Authentication', '2025-03-18 01:01:15'),
(770, '2025-03-18', '09:01:17', 'Nathaniel P. Padilla', 'Nathaniel P. Padilla logged out', 'Admin Activity Log', '2025-03-18 01:01:17'),
(771, '2025-03-18', '09:01:20', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as user', 'User Authentication', '2025-03-18 01:01:20'),
(772, '2025-03-18', '09:01:22', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 01:01:22'),
(773, '2025-03-18', '09:01:26', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:01:26'),
(775, '2025-03-18', '09:02:13', 'mang berting inamo', 'Updated user: role from \'user\' to \'admin\'', 'User Management', '2025-03-18 01:02:13'),
(776, '2025-03-18', '09:02:17', 'mang berting inamo', 'Updated user: role from \'admin\' to \'user\'', 'User Management', '2025-03-18 01:02:17'),
(783, '2025-03-18', '09:08:30', 'mang berting inamo', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:08:30'),
(784, '2025-03-18', '09:08:44', 'mang berting inamo', 'mang berting inamo logged out', 'Admin Activity Log', '2025-03-18 01:08:44'),
(785, '2025-03-18', '09:09:25', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:09:25'),
(786, '2025-03-18', '09:09:57', 'Mark Nathaniel Dela Vega Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:09:57'),
(787, '2025-03-18', '09:10:08', 'mang berting inamo', 'mang berting inamo logged out', 'Admin Activity Log', '2025-03-18 01:10:08'),
(788, '2025-03-18', '09:10:26', 'Mark Nathaniel Dela Vega Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:10:26'),
(789, '2025-03-18', '09:10:33', 'Mark Nathaniel Dela Vega Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:10:33'),
(790, '2025-03-18', '09:10:50', 'Mark Nathaniel Dela Vega Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:10:50'),
(791, '2025-03-18', '09:10:54', 'Mark Nathaniel Dela Vega Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:10:54'),
(792, '2025-03-18', '09:10:57', 'Mark Nathaniel Dela Vega Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:10:57'),
(793, '2025-03-18', '09:11:00', 'Mark Nathaniel Dela Vega Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:11:00'),
(794, '2025-03-18', '09:11:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as user', 'User Authentication', '2025-03-18 01:11:06'),
(795, '2025-03-18', '09:11:30', 'Mark Nathaniel Dela Vega Olpot', 'Updated user: role from \'user\' to \'admin\'', 'User Management', '2025-03-18 01:11:30'),
(796, '2025-03-18', '09:11:37', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 01:11:37'),
(797, '2025-03-18', '09:11:41', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 01:11:41'),
(798, '2025-03-18', '09:12:32', 'Mark Nathaniel Dela Vega Olpot', 'Mark Nathaniel Dela Vega Olpot logged out', 'Admin Activity Log', '2025-03-18 01:12:32'),
(799, '2025-03-18', '09:12:38', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 01:12:38'),
(800, '2025-03-18', '09:19:02', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 01:19:02'),
(801, '2025-03-18', '09:19:09', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:19:09'),
(802, '2025-03-18', '09:19:15', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:19:15'),
(803, '2025-03-18', '09:19:27', 'mang berting inamo', 'mang berting inamo logged out', 'Admin Activity Log', '2025-03-18 01:19:27'),
(804, '2025-03-18', '09:19:41', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:19:41'),
(805, '2025-03-18', '09:19:43', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:19:43'),
(806, '2025-03-18', '09:20:06', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:20:06'),
(807, '2025-03-18', '09:20:12', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:20:12'),
(808, '2025-03-18', '09:20:39', 'mang berting inamo', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:20:39'),
(809, '2025-03-18', '09:20:41', 'mang berting inamo', 'Updated user status to: active', 'User Management', '2025-03-18 01:20:41'),
(810, '2025-03-18', '09:26:20', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:26:20'),
(811, '2025-03-18', '09:26:26', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:26:26'),
(812, '2025-03-18', '09:28:35', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:28:35'),
(813, '2025-03-18', '09:28:49', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 01:28:49'),
(814, '2025-03-18', '09:28:51', 'mang berting inamo', 'mang berting inamo logged out', 'Admin Activity Log', '2025-03-18 01:28:51'),
(815, '2025-03-18', '09:28:58', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:28:58'),
(816, '2025-03-18', '09:29:11', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 01:29:11'),
(817, '2025-03-18', '09:29:16', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:29:16'),
(818, '2025-03-18', '09:29:32', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:29:32'),
(819, '2025-03-18', '09:29:46', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:29:46'),
(820, '2025-03-18', '09:29:50', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:29:50'),
(821, '2025-03-18', '09:30:14', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:30:14'),
(822, '2025-03-18', '09:31:37', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:31:37'),
(823, '2025-03-18', '09:33:11', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:33:11'),
(824, '2025-03-18', '09:33:27', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:33:27'),
(825, '2025-03-18', '09:33:37', 'mang berting inamo', 'mang berting inamo logged in as admin', 'User Authentication', '2025-03-18 01:33:37'),
(826, '2025-03-18', '09:34:52', 'mang berting inamo', 'Added new user: jayson isaac bustos (justin@gmail.com) with role user', 'User Management', '2025-03-18 01:34:52'),
(827, '2025-03-18', '09:34:59', 'mang berting inamo', 'Deleted user: jayson isaac bustos', 'User Management', '2025-03-18 01:34:59'),
(828, '2025-03-18', '09:36:42', 'mang berting inamo', 'mang berting inamo added new borrower: MArk Dela Vega bustos', 'Borrower Management Logs', '2025-03-18 01:36:42'),
(829, '2025-03-18', '09:36:45', 'mang berting inamo', 'mang berting inamo searched for term: m', 'Search Terms', '2025-03-18 01:36:45'),
(830, '2025-03-18', '02:38:18', 'mang berting inamo', 'Updated profile picture', 'Profile Management', '2025-03-18 01:38:18'),
(831, '2025-03-18', '02:38:28', 'mang berting inamo jr', 'Updated profile name from \'mang berting inamo\' to \'mang berting inamo jr\'', 'Profile Management', '2025-03-18 01:38:28'),
(832, '2025-03-18', '09:38:38', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:38:38'),
(833, '2025-03-18', '02:38:45', 'mang berting inamo jr', 'Updated profile picture', 'Profile Management', '2025-03-18 01:38:45'),
(834, '2025-03-18', '09:38:55', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:38:55'),
(835, '2025-03-18', '09:39:10', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 01:39:10'),
(836, '2025-03-18', '09:45:34', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:45:34'),
(837, '2025-03-18', '09:46:44', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:46:44'),
(838, '2025-03-18', '09:46:53', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 01:46:53'),
(839, '2025-03-18', '09:47:27', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:47:27'),
(840, '2025-03-18', '09:47:39', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:47:39'),
(841, '2025-03-18', '09:47:52', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 01:47:52'),
(842, '2025-03-18', '09:50:50', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:50:50'),
(843, '2025-03-18', '09:51:18', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:51:18'),
(844, '2025-03-18', '09:51:21', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 01:51:21'),
(845, '2025-03-18', '09:51:27', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:51:27'),
(846, '2025-03-18', '09:51:48', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:51:48'),
(847, '2025-03-18', '09:51:50', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 01:51:50'),
(848, '2025-03-18', '09:52:09', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:52:09'),
(849, '2025-03-18', '09:53:06', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 01:53:06'),
(850, '2025-03-18', '09:59:28', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 01:59:28'),
(851, '2025-03-18', '09:59:33', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 01:59:33'),
(852, '2025-03-18', '10:00:10', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:00:10'),
(853, '2025-03-18', '10:00:11', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:00:11'),
(854, '2025-03-18', '10:00:17', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:00:17'),
(855, '2025-03-18', '10:00:39', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:00:39'),
(856, '2025-03-18', '10:00:45', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:00:45'),
(857, '2025-03-18', '10:05:25', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:05:25'),
(858, '2025-03-18', '10:05:45', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:05:45'),
(859, '2025-03-18', '10:05:59', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:05:59'),
(860, '2025-03-18', '10:06:16', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:06:16'),
(861, '2025-03-18', '10:06:44', 'mang berting inamo jr', 'mang berting inamo jr searched for term: m', 'Search Terms', '2025-03-18 02:06:44'),
(862, '2025-03-18', '10:08:00', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:08:00'),
(863, '2025-03-18', '10:08:07', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:08:07'),
(864, '2025-03-18', '10:08:14', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:08:14'),
(865, '2025-03-18', '10:14:28', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:14:28'),
(866, '2025-03-18', '10:14:29', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:14:29'),
(867, '2025-03-18', '10:14:33', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:14:33'),
(868, '2025-03-18', '10:14:39', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:14:39'),
(869, '2025-03-18', '10:20:24', 'mang berting inamo jr', 'mang berting inamo jr logged out', 'Admin Activity Log', '2025-03-18 02:20:24'),
(870, '2025-03-18', '10:20:33', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:20:33'),
(871, '2025-03-18', '10:20:36', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:20:36'),
(872, '2025-03-18', '10:21:05', 'mang berting inamo jr', 'mang berting inamo jr logged out', 'Admin Activity Log', '2025-03-18 02:21:05'),
(873, '2025-03-18', '10:21:10', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:21:10'),
(874, '2025-03-18', '10:21:17', 'mang berting inamo jr', 'mang berting inamo jr logged out', 'Admin Activity Log', '2025-03-18 02:21:17'),
(875, '2025-03-18', '10:21:24', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 02:21:24'),
(876, '2025-03-18', '10:21:34', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:21:34'),
(877, '2025-03-18', '10:21:51', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:21:51'),
(878, '2025-03-18', '10:21:51', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 02:21:51'),
(879, '2025-03-18', '10:22:00', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:22:00'),
(880, '2025-03-18', '10:22:04', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:22:04'),
(881, '2025-03-18', '10:22:10', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:22:10'),
(882, '2025-03-18', '10:24:34', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:24:34'),
(883, '2025-03-18', '10:26:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-18 02:26:06'),
(884, '2025-03-18', '10:26:07', 'mang berting inamo jr', 'Updated user: role from \'admin\' to \'user\'', 'User Management', '2025-03-18 02:26:07'),
(885, '2025-03-18', '10:26:47', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:26:47'),
(886, '2025-03-18', '10:34:31', 'mang berting inamo jr', 'mang berting inamo jr logged out', 'Admin Activity Log', '2025-03-18 02:34:31'),
(887, '2025-03-18', '10:34:40', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 02:34:40'),
(888, '2025-03-18', '10:38:26', 'mang berting inamo jr', 'mang berting inamo jr logged out', 'Admin Activity Log', '2025-03-18 02:38:26'),
(889, '2025-03-18', '10:38:34', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:38:34'),
(890, '2025-03-18', '10:38:54', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 02:38:54'),
(891, '2025-03-18', '10:38:55', 'mang berting inamo jr', 'mang berting inamo jr logged out', 'Admin Activity Log', '2025-03-18 02:38:55'),
(892, '2025-03-18', '10:39:02', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:39:02'),
(893, '2025-03-18', '10:39:09', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 02:39:09'),
(894, '2025-03-18', '10:39:12', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 02:39:12'),
(895, '2025-03-18', '10:39:17', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:39:17'),
(896, '2025-03-18', '10:39:24', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:39:24'),
(897, '2025-03-18', '10:39:34', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:39:34'),
(898, '2025-03-18', '10:39:41', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:39:41'),
(899, '2025-03-18', '10:39:45', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:39:45'),
(900, '2025-03-18', '10:40:01', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:40:01'),
(901, '2025-03-18', '10:40:02', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:40:02'),
(902, '2025-03-18', '10:40:16', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:40:16'),
(903, '2025-03-18', '10:40:27', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:40:27'),
(904, '2025-03-18', '10:41:56', 'Mark Nathaniel D. Olpot', 'Deleted user: Nathaniel P. Padilla', 'User Management', '2025-03-18 02:41:56'),
(905, '2025-03-18', '10:42:28', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 02:42:28'),
(906, '2025-03-18', '10:51:30', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:51:30'),
(907, '2025-03-18', '10:51:34', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:51:34'),
(908, '2025-03-18', '10:51:37', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:51:37'),
(909, '2025-03-18', '10:51:40', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:51:40'),
(910, '2025-03-18', '10:52:01', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:52:01'),
(911, '2025-03-18', '10:52:05', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:52:05'),
(912, '2025-03-18', '10:52:17', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 02:52:17'),
(913, '2025-03-18', '10:53:00', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 02:53:00'),
(914, '2025-03-18', '10:58:52', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 02:58:52'),
(915, '2025-03-18', '10:59:50', 'Mark Nathaniel D. Olpot', 'Updated user: password', 'User Management', '2025-03-18 02:59:50'),
(916, '2025-03-18', '11:00:10', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 03:00:10'),
(917, '2025-03-18', '11:00:15', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-18 03:00:15'),
(918, '2025-03-18', '11:00:19', 'mang berting inamo jr', 'mang berting inamo jr logged out', 'Admin Activity Log', '2025-03-18 03:00:19'),
(919, '2025-03-18', '11:00:34', 'Michael John P. Seva', 'Michael John P. Seva logged in as user', 'User Authentication', '2025-03-18 03:00:34'),
(920, '2025-03-18', '11:00:41', 'Michael John P. Seva', 'Michael John P. Seva logged out', 'Admin Activity Log', '2025-03-18 03:00:41'),
(921, '2025-03-18', '11:00:45', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 03:00:45'),
(922, '2025-03-18', '11:02:21', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-18 03:02:21'),
(923, '2025-03-18', '11:02:24', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot deleted borrower: MArk Dela Vega bustos', 'Borrower Management Logs', '2025-03-18 03:02:24'),
(924, '2025-03-18', '11:02:31', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-18 03:02:31'),
(925, '2025-03-18', '11:02:38', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot updated borrower information for: Athara Mariel  Mendoza Negrillo', 'Borrower Management logs', '2025-03-18 03:02:38'),
(926, '2025-03-18', '11:11:16', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 03:11:16'),
(927, '2025-03-18', '11:11:19', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 03:11:19'),
(928, '2025-03-18', '14:36:24', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:36:24'),
(929, '2025-03-18', '14:37:11', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:37:11'),
(930, '2025-03-18', '14:37:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:37:25'),
(931, '2025-03-18', '14:37:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: Athara Mariel  Mendoza Negrillo', 'Search Terms', '2025-03-18 06:37:25'),
(932, '2025-03-18', '14:41:01', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:41:01'),
(933, '2025-03-18', '14:41:01', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-18 06:41:01'),
(934, '2025-03-18', '14:44:47', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mn', 'Search Terms', '2025-03-18 06:44:47'),
(935, '2025-03-18', '14:44:48', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:44:48'),
(936, '2025-03-18', '14:45:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:45:00'),
(937, '2025-03-18', '14:47:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:47:06'),
(938, '2025-03-18', '14:49:09', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:49:09'),
(939, '2025-03-18', '14:49:09', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-18 06:49:09'),
(940, '2025-03-18', '14:50:32', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:50:32'),
(941, '2025-03-18', '14:50:33', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-18 06:50:33'),
(942, '2025-03-18', '14:50:56', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:50:56'),
(943, '2025-03-18', '14:53:55', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-18 06:53:55'),
(944, '2025-03-18', '14:54:05', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-18 06:54:05'),
(945, '2025-03-18', '14:56:24', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: n', 'Search Terms', '2025-03-18 06:56:24'),
(946, '2025-03-18', '14:56:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: na', 'Search Terms', '2025-03-18 06:56:25'),
(947, '2025-03-18', '14:56:46', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 06:56:46'),
(948, '2025-03-18', '15:01:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: nm', 'Search Terms', '2025-03-18 07:01:00'),
(949, '2025-03-18', '15:01:02', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: n', 'Search Terms', '2025-03-18 07:01:02'),
(950, '2025-03-18', '15:01:22', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:01:22'),
(951, '2025-03-18', '15:01:59', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:01:59'),
(952, '2025-03-18', '15:04:34', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-18 07:04:34'),
(953, '2025-03-18', '15:05:11', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 07:05:11'),
(954, '2025-03-18', '15:07:30', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-18 07:07:30'),
(955, '2025-03-18', '15:07:39', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-18 07:07:39'),
(956, '2025-03-18', '15:07:41', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-18 07:07:41'),
(957, '2025-03-18', '15:10:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:10:18'),
(958, '2025-03-18', '15:12:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:12:00'),
(959, '2025-03-18', '15:12:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-18 07:12:00'),
(960, '2025-03-18', '15:15:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:15:18'),
(961, '2025-03-18', '15:18:16', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:18:16'),
(962, '2025-03-18', '15:18:30', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-18 07:18:30'),
(963, '2025-03-18', '15:18:31', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-18 07:18:31'),
(964, '2025-03-18', '15:20:04', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:20:04'),
(965, '2025-03-18', '15:23:57', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-18 07:23:57'),
(966, '2025-03-18', '15:24:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 07:24:00'),
(967, '2025-03-18', '15:24:16', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:24:16'),
(968, '2025-03-18', '15:27:58', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:27:58'),
(969, '2025-03-18', '15:28:30', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: n', 'Search Terms', '2025-03-18 07:28:30'),
(970, '2025-03-18', '15:30:38', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ,', 'Search Terms', '2025-03-18 07:30:38'),
(971, '2025-03-18', '15:30:39', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:30:39'),
(972, '2025-03-18', '15:31:09', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: n', 'Search Terms', '2025-03-18 07:31:09'),
(973, '2025-03-18', '15:31:34', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:31:34'),
(974, '2025-03-18', '15:47:05', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 07:47:05'),
(975, '2025-03-18', '15:47:12', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:47:12'),
(976, '2025-03-18', '15:48:23', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 07:48:23'),
(977, '2025-03-18', '16:07:26', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-18 08:07:26'),
(978, '2025-03-18', '16:07:31', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 08:07:31'),
(979, '2025-03-18', '16:10:59', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 08:10:59'),
(980, '2025-03-18', '16:11:28', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-18 08:11:28'),
(981, '2025-03-18', '16:12:09', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-18 08:12:09'),
(982, '2025-03-18', '16:12:10', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-18 08:12:10'),
(983, '2025-03-18', '16:12:39', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: n', 'Search Terms', '2025-03-18 08:12:39'),
(984, '2025-03-18', '16:12:40', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 08:12:40'),
(985, '2025-03-18', '16:17:05', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-18 08:17:05'),
(986, '2025-03-18', '16:17:05', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-18 08:17:05'),
(987, '2025-03-20', '09:09:51', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 01:09:51'),
(988, '2025-03-20', '09:09:56', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:09:56'),
(989, '2025-03-20', '09:10:11', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:10:11'),
(990, '2025-03-20', '09:10:14', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:10:14'),
(991, '2025-03-20', '09:10:33', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 01:10:33'),
(992, '2025-03-20', '09:10:35', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 01:10:35'),
(993, '2025-03-20', '09:11:45', 'Michael John P. Seva', 'Michael John P. Seva logged in as user', 'User Authentication', '2025-03-20 01:11:45'),
(994, '2025-03-20', '09:11:54', 'Michael John P. Seva', 'Michael John P. Seva searched for term: a', 'Search Terms', '2025-03-20 01:11:54'),
(995, '2025-03-20', '09:12:40', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-20 01:12:40'),
(996, '2025-03-20', '09:12:42', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-20 01:12:42'),
(997, '2025-03-20', '09:13:17', 'Michael John P. Seva', 'Michael John P. Seva logged in as user', 'User Authentication', '2025-03-20 01:13:17'),
(998, '2025-03-20', '09:13:21', 'Michael John P. Seva', 'Michael John P. Seva searched for term: m', 'Search Terms', '2025-03-20 01:13:21'),
(999, '2025-03-20', '09:15:24', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 01:15:24'),
(1000, '2025-03-20', '09:15:28', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 01:15:28'),
(1001, '2025-03-20', '09:17:39', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:17:39'),
(1002, '2025-03-20', '09:28:14', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 01:28:14'),
(1003, '2025-03-20', '09:28:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-20 01:28:25'),
(1004, '2025-03-20', '09:28:26', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 01:28:26'),
(1005, '2025-03-20', '09:34:41', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: nma', 'Search Terms', '2025-03-20 01:34:41'),
(1006, '2025-03-20', '09:34:43', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:34:43'),
(1007, '2025-03-20', '09:36:19', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-20 01:36:19'),
(1008, '2025-03-20', '09:38:20', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:38:20'),
(1009, '2025-03-20', '09:44:23', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-20 01:44:23'),
(1010, '2025-03-20', '09:51:35', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:51:35'),
(1011, '2025-03-20', '09:54:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 01:54:25'),
(1012, '2025-03-20', '09:54:30', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-20 01:54:30'),
(1013, '2025-03-20', '09:54:31', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:54:31');
INSERT INTO `audit_logs` (`id`, `date`, `time`, `performed_by`, `action`, `category`, `created_at`) VALUES
(1014, '2025-03-20', '09:55:08', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-20 01:55:08'),
(1015, '2025-03-20', '09:55:09', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar\\', 'Search Terms', '2025-03-20 01:55:09'),
(1016, '2025-03-20', '09:55:09', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 01:55:09'),
(1017, '2025-03-20', '10:06:54', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:06:54'),
(1018, '2025-03-20', '10:10:14', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 02:10:14'),
(1019, '2025-03-20', '10:11:05', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:11:05'),
(1020, '2025-03-20', '10:12:16', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:12:16'),
(1021, '2025-03-20', '10:19:21', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:19:21'),
(1022, '2025-03-20', '10:29:43', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:29:43'),
(1023, '2025-03-20', '10:30:22', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-20 02:30:22'),
(1024, '2025-03-20', '10:30:56', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: r', 'Search Terms', '2025-03-20 02:30:56'),
(1025, '2025-03-20', '10:39:53', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:39:53'),
(1026, '2025-03-20', '10:41:27', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 02:41:27'),
(1027, '2025-03-20', '10:41:31', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:41:31'),
(1028, '2025-03-20', '10:41:46', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-A3A8A8) worth ₱10,000.00 for borrower: Athara Mariel  Mendoza Negrillo', 'Loan Management Logs', '2025-03-20 02:41:46'),
(1029, '2025-03-20', '10:41:46', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-A3A8A8) worth ₱10,000.00 for borrower: Athara Mariel  Mendoza Negrillo', 'New Loan', '2025-03-20 02:41:46'),
(1030, '2025-03-20', '03:43:04', 'Mark Nathaniel D. Olpot', 'Updated profile picture', 'Profile Management', '2025-03-20 02:43:04'),
(1031, '2025-03-20', '10:48:13', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 02:48:13'),
(1032, '2025-03-20', '10:48:17', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 02:48:17'),
(1033, '2025-03-20', '10:48:46', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-20 02:48:46'),
(1034, '2025-03-20', '10:48:51', 'mang berting inamo jr', 'mang berting inamo jr logged in as admin', 'User Authentication', '2025-03-20 02:48:51'),
(1035, '2025-03-20', '10:49:03', 'mang berting inamo jr', 'mang berting inamo jr logged out', 'Admin Activity Log', '2025-03-20 02:49:03'),
(1036, '2025-03-20', '10:49:51', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 02:49:51'),
(1037, '2025-03-20', '10:50:01', 'Mark Nathaniel D. Olpot', 'Deleted user: mang berting inamo jr', 'User Management', '2025-03-20 02:50:01'),
(1038, '2025-03-20', '10:50:12', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:50:12'),
(1039, '2025-03-20', '10:51:13', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 02:51:13'),
(1040, '2025-03-20', '10:51:36', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 02:51:36'),
(1041, '2025-03-20', '10:53:52', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:53:52'),
(1042, '2025-03-20', '10:53:56', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-20 02:53:56'),
(1043, '2025-03-20', '10:54:29', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:54:29'),
(1044, '2025-03-20', '10:54:45', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-5C147A) worth ₱11.00 for borrower: Athara Mariel  Mendoza Negrillo', 'Loan Management Logs', '2025-03-20 02:54:45'),
(1045, '2025-03-20', '10:54:45', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-5C147A) worth ₱11.00 for borrower: Athara Mariel  Mendoza Negrillo', 'New Loan', '2025-03-20 02:54:45'),
(1046, '2025-03-20', '10:56:30', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:56:30'),
(1047, '2025-03-20', '10:56:47', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F127FC) worth ₱3,232.00 for borrower: Athara Mariel  Mendoza Negrillo', 'Loan Management Logs', '2025-03-20 02:56:47'),
(1048, '2025-03-20', '10:56:47', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-F127FC) worth ₱3,232.00 for borrower: Athara Mariel  Mendoza Negrillo', 'New Loan', '2025-03-20 02:56:47'),
(1049, '2025-03-20', '10:57:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:57:06'),
(1050, '2025-03-20', '10:57:23', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:57:23'),
(1051, '2025-03-20', '10:58:47', 'Michael John P. Seva', 'Michael John P. Seva searched for term: ma', 'Search Terms', '2025-03-20 02:58:47'),
(1052, '2025-03-20', '10:59:42', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 02:59:42'),
(1053, '2025-03-20', '11:01:37', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:01:37'),
(1054, '2025-03-20', '11:01:47', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 03:01:47'),
(1055, '2025-03-20', '11:02:52', 'Michael John P. Seva', 'Michael John P. Seva logged in as user', 'User Authentication', '2025-03-20 03:02:52'),
(1056, '2025-03-20', '11:02:54', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:02:54'),
(1057, '2025-03-20', '11:03:03', 'Michael John P. Seva', 'Michael John P. Seva logged out', 'Admin Activity Log', '2025-03-20 03:03:03'),
(1058, '2025-03-20', '11:03:06', 'Michael John P. Seva', 'Michael John P. Seva logged in as user', 'User Authentication', '2025-03-20 03:03:06'),
(1059, '2025-03-20', '11:06:40', 'Michael John P. Seva', 'Michael John P. Seva logged out', 'Admin Activity Log', '2025-03-20 03:06:40'),
(1060, '2025-03-20', '11:08:01', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 03:08:01'),
(1061, '2025-03-20', '11:08:31', 'Mark Olpot S', 'Mark Olpot S logged in as admin', 'User Authentication', '2025-03-20 03:08:31'),
(1062, '2025-03-20', '11:08:43', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:08:43'),
(1063, '2025-03-20', '11:08:51', 'Mark Olpot S', 'Mark Olpot S logged out', 'Admin Activity Log', '2025-03-20 03:08:51'),
(1064, '2025-03-20', '11:08:55', 'Mark Olpot S', 'Mark Olpot S logged in as admin', 'User Authentication', '2025-03-20 03:08:55'),
(1065, '2025-03-20', '11:08:59', 'Mark Olpot S', 'Mark Olpot S logged out', 'Admin Activity Log', '2025-03-20 03:08:59'),
(1066, '2025-03-20', '11:11:22', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 03:11:22'),
(1067, '2025-03-20', '11:12:18', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:12:18'),
(1068, '2025-03-20', '11:12:20', 'Leopoldo Servana s', 'Leopoldo Servana s logged out', 'Admin Activity Log', '2025-03-20 03:12:20'),
(1069, '2025-03-20', '11:12:24', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:12:24'),
(1070, '2025-03-20', '11:12:28', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:12:28'),
(1071, '2025-03-20', '11:12:33', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:12:33'),
(1072, '2025-03-20', '11:12:39', 'Leopoldo Servana s', 'Leopoldo Servana s logged out', 'Admin Activity Log', '2025-03-20 03:12:39'),
(1073, '2025-03-20', '11:12:43', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:12:43'),
(1074, '2025-03-20', '11:12:45', 'Leopoldo Servana s', 'Leopoldo Servana s logged out', 'Admin Activity Log', '2025-03-20 03:12:45'),
(1075, '2025-03-20', '11:12:49', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:12:49'),
(1076, '2025-03-20', '11:12:51', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 03:12:51'),
(1077, '2025-03-20', '11:12:54', 'Leopoldo Servana s', 'Leopoldo Servana s logged out', 'Admin Activity Log', '2025-03-20 03:12:54'),
(1078, '2025-03-20', '11:12:59', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:12:59'),
(1079, '2025-03-20', '11:13:33', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 03:13:33'),
(1080, '2025-03-20', '11:14:04', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:14:04'),
(1081, '2025-03-20', '11:14:12', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:14:12'),
(1082, '2025-03-20', '11:16:15', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 03:16:15'),
(1083, '2025-03-20', '11:16:49', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 03:16:49'),
(1084, '2025-03-20', '11:16:54', 'Mark Nathaniel D. Olpot', 'Updated user: role from \'admin\' to \'user\'', 'User Management', '2025-03-20 03:16:54'),
(1085, '2025-03-20', '11:17:04', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-20 03:17:04'),
(1086, '2025-03-20', '11:17:08', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as user', 'User Authentication', '2025-03-20 03:17:08'),
(1087, '2025-03-20', '04:21:04', 'Leopoldo Servana s', 'Updated profile picture', 'Profile Management', '2025-03-20 03:21:04'),
(1088, '2025-03-20', '11:21:16', 'Mark Nathaniel D. Olpot', 'Updated user: role from \'user\' to \'admin\'', 'User Management', '2025-03-20 03:21:16'),
(1089, '2025-03-20', '11:21:22', 'Leopoldo Servana s', 'Leopoldo Servana s logged out', 'Admin Activity Log', '2025-03-20 03:21:22'),
(1090, '2025-03-20', '11:21:28', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:21:28'),
(1091, '2025-03-20', '11:23:03', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:23:03'),
(1092, '2025-03-20', '11:23:19', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:23:19'),
(1093, '2025-03-20', '11:24:08', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:24:08'),
(1094, '2025-03-20', '11:26:05', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 03:26:05'),
(1095, '2025-03-20', '11:26:15', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:26:15'),
(1096, '2025-03-20', '11:26:19', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:26:19'),
(1097, '2025-03-20', '11:33:23', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:33:23'),
(1098, '2025-03-20', '11:34:34', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 03:34:34'),
(1099, '2025-03-20', '11:34:39', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:34:39'),
(1100, '2025-03-20', '11:34:48', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:34:48'),
(1101, '2025-03-20', '11:34:59', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:34:59'),
(1102, '2025-03-20', '11:37:02', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:37:02'),
(1103, '2025-03-20', '11:37:27', 'Leopoldo Servana s', 'Leopoldo Servana s logged in as admin', 'User Authentication', '2025-03-20 03:37:27'),
(1104, '2025-03-20', '11:37:55', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 03:37:55'),
(1105, '2025-03-20', '11:38:26', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: a', 'Search Terms', '2025-03-20 03:38:26'),
(1106, '2025-03-20', '11:44:32', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 03:44:32'),
(1107, '2025-03-20', '11:44:33', 'Leopoldo Servana s', 'Leopoldo Servana s logged in', 'User Activity', '2025-03-20 03:44:33'),
(1108, '2025-03-20', '11:44:36', 'Mark Nathaniel D. Olpot', 'Updated user status to: disabled', 'User Management', '2025-03-20 03:44:36'),
(1109, '2025-03-20', '13:46:03', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'User Activity', '2025-03-20 05:46:03'),
(1110, '2025-03-20', '13:46:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 05:46:06'),
(1111, '2025-03-20', '13:46:19', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 05:46:19'),
(1112, '2025-03-20', '13:46:34', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 05:46:34'),
(1113, '2025-03-20', '13:51:53', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 05:51:53'),
(1114, '2025-03-20', '13:56:48', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 05:56:48'),
(1115, '2025-03-20', '13:57:07', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new grocery item (Ref: GR-334CC6) worth ₱1,111.00 for borrower: Athara Mariel  Mendoza Negrillo', 'Grocery Management', '2025-03-20 05:57:07'),
(1116, '2025-03-20', '14:00:29', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in as admin', 'User Authentication', '2025-03-20 06:00:29'),
(1117, '2025-03-20', '14:00:34', 'Mark Nathaniel D. Olpot', 'Updated user status to: active', 'User Management', '2025-03-20 06:00:34'),
(1118, '2025-03-20', '14:00:39', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:00:39'),
(1119, '2025-03-20', '14:01:57', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:01:57'),
(1120, '2025-03-20', '14:03:11', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 06:03:11'),
(1121, '2025-03-20', '14:03:24', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 06:03:24'),
(1122, '2025-03-20', '14:04:23', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:04:23'),
(1123, '2025-03-20', '14:04:34', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-20 06:04:34'),
(1124, '2025-03-20', '14:08:16', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:08:16'),
(1125, '2025-03-20', '14:10:16', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:10:16'),
(1126, '2025-03-20', '14:13:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:13:25'),
(1127, '2025-03-20', '14:14:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:14:00'),
(1128, '2025-03-20', '14:14:37', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-D8778D) worth ₱111.00 for borrower: Athara Mariel  Mendoza Negrillo', 'Loan Management Logs', '2025-03-20 06:14:37'),
(1129, '2025-03-20', '14:14:37', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-D8778D) worth ₱111.00 for borrower: Athara Mariel  Mendoza Negrillo', 'New Loan', '2025-03-20 06:14:37'),
(1130, '2025-03-20', '14:16:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:16:06'),
(1131, '2025-03-20', '14:21:32', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-20 06:21:32'),
(1132, '2025-03-20', '14:21:38', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new grocery item (Ref: GR-2D16DE) worth ₱111.00 for borrower: Athara Mariel  Mendoza Negrillo', 'Grocery Management', '2025-03-20 06:21:38'),
(1133, '2025-03-20', '14:22:18', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot updated borrower information for: Athara Mariel  Mendoza Negrillo', 'Borrower Management logs', '2025-03-20 06:22:18'),
(1134, '2025-03-24', '08:20:08', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'User Activity', '2025-03-24 00:20:08'),
(1135, '2025-03-24', '08:20:20', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:20:20'),
(1136, '2025-03-24', '08:29:16', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:29:16'),
(1137, '2025-03-24', '08:32:54', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:32:54'),
(1138, '2025-03-24', '08:33:43', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:33:43'),
(1139, '2025-03-24', '08:39:09', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:39:09'),
(1140, '2025-03-24', '08:39:53', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:39:53'),
(1141, '2025-03-24', '08:40:05', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:40:05'),
(1142, '2025-03-24', '08:40:39', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: Michael Punzalan Sev', 'Search Terms', '2025-03-24 00:40:39'),
(1143, '2025-03-24', '08:40:40', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:40:40'),
(1144, '2025-03-24', '08:47:50', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:47:50'),
(1145, '2025-03-24', '08:48:47', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:48:47'),
(1146, '2025-03-24', '08:49:41', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:49:41'),
(1147, '2025-03-24', '08:52:39', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:52:39'),
(1148, '2025-03-24', '08:55:58', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:55:58'),
(1149, '2025-03-24', '08:58:33', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 00:58:33'),
(1150, '2025-03-24', '09:00:04', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:00:04'),
(1151, '2025-03-24', '09:00:44', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:00:44'),
(1152, '2025-03-24', '09:01:34', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:01:34'),
(1153, '2025-03-24', '09:03:30', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:03:30'),
(1154, '2025-03-24', '09:05:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:05:00'),
(1155, '2025-03-24', '09:10:30', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:10:30'),
(1156, '2025-03-24', '09:10:30', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mi', 'Search Terms', '2025-03-24 01:10:30'),
(1157, '2025-03-24', '09:15:01', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'User Activity', '2025-03-24 01:15:01'),
(1158, '2025-03-24', '09:16:34', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged out', 'Admin Activity Log', '2025-03-24 01:16:34'),
(1159, '2025-03-24', '09:16:38', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'User Activity', '2025-03-24 01:16:38'),
(1160, '2025-03-24', '09:17:25', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mark', 'Search Terms', '2025-03-24 01:17:25'),
(1161, '2025-03-24', '09:19:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new borrower: Mark Nathaniel  Dela Vega olpot', 'Borrower Management Logs', '2025-03-24 01:19:00'),
(1162, '2025-03-24', '09:19:06', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:19:06'),
(1163, '2025-03-24', '09:19:07', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-24 01:19:07'),
(1164, '2025-03-24', '09:19:59', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new grocery item (Ref: GR-F42B5F) worth ₱10,000.00 for borrower: Mark Nathaniel  Dela Vega olpot', 'Grocery Management', '2025-03-24 01:19:59'),
(1165, '2025-03-24', '09:20:53', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: Mark Nathaniel  Dela Vega olpot', 'Search Terms', '2025-03-24 01:20:53'),
(1166, '2025-03-24', '09:21:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:21:00'),
(1167, '2025-03-24', '09:21:28', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-843E3C) worth ₱321,312.00 for borrower: Mark Nathaniel  Dela Vega olpot', 'Loan Management Logs', '2025-03-24 01:21:28'),
(1168, '2025-03-24', '09:21:28', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-843E3C) worth ₱321,312.00 for borrower: Mark Nathaniel  Dela Vega olpot', 'New Loan', '2025-03-24 01:21:28'),
(1169, '2025-03-24', '09:22:07', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:22:07'),
(1170, '2025-03-24', '09:22:07', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mar', 'Search Terms', '2025-03-24 01:22:07'),
(1171, '2025-03-24', '09:23:44', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:23:44'),
(1172, '2025-03-24', '09:25:49', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-24 01:25:49'),
(1173, '2025-03-24', '09:26:01', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: mic', 'Search Terms', '2025-03-24 01:26:01'),
(1174, '2025-03-24', '09:27:03', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'User Activity', '2025-03-24 01:27:03'),
(1175, '2025-03-24', '09:27:10', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-24 01:27:10'),
(1176, '2025-03-24', '09:29:01', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-24 01:29:01'),
(1177, '2025-03-24', '09:29:35', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'User Activity', '2025-03-24 01:29:35'),
(1178, '2025-03-24', '09:29:37', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:29:37'),
(1179, '2025-03-24', '09:31:43', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:31:43'),
(1180, '2025-03-24', '09:32:00', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:32:00'),
(1181, '2025-03-24', '09:32:20', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-43B59C) worth ₱1,000.00 for borrower: Mark Nathaniel  Dela Vega olpot', 'Loan Management Logs', '2025-03-24 01:32:20'),
(1182, '2025-03-24', '09:32:20', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-43B59C) worth ₱1,000.00 for borrower: Mark Nathaniel  Dela Vega olpot', 'New Loan', '2025-03-24 01:32:20'),
(1183, '2025-03-24', '09:34:40', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:34:40'),
(1184, '2025-03-24', '09:35:02', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-680E76) worth ₱2,000.00 for borrower: Mark Nathaniel  Dela Vega olpot', 'Loan Management Logs', '2025-03-24 01:35:02'),
(1185, '2025-03-24', '09:35:02', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-680E76) worth ₱2,000.00 for borrower: Mark Nathaniel  Dela Vega olpot', 'New Loan', '2025-03-24 01:35:02'),
(1186, '2025-03-24', '09:37:20', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:37:20'),
(1187, '2025-03-24', '09:37:45', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:37:45'),
(1188, '2025-03-24', '09:37:45', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: ma', 'Search Terms', '2025-03-24 01:37:45'),
(1189, '2025-03-24', '09:38:54', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot logged in', 'User Activity', '2025-03-24 01:38:54'),
(1190, '2025-03-24', '09:38:58', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:38:58'),
(1191, '2025-03-24', '09:41:29', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:41:29'),
(1192, '2025-03-24', '09:45:45', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot searched for term: m', 'Search Terms', '2025-03-24 01:45:45'),
(1193, '2025-03-24', '09:46:01', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-986BA5) worth ₱1,000.00 for borrower: Athara Mariel  Mendoza Negrillo', 'Loan Management Logs', '2025-03-24 01:46:01'),
(1194, '2025-03-24', '09:46:01', 'Mark Nathaniel D. Olpot', 'Mark Nathaniel D. Olpot added new loan (Ref: LN-986BA5) worth ₱1,000.00 for borrower: Athara Mariel  Mendoza Negrillo', 'New Loan', '2025-03-24 01:46:01');

-- --------------------------------------------------------

--
-- Table structure for table `borrowers`
--

CREATE TABLE `borrowers` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `surname` varchar(100) NOT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  `sex` enum('male','female') NOT NULL,
  `dob` date NOT NULL,
  `marital_status` enum('single','married','divorced','widowed') NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowers`
--

INSERT INTO `borrowers` (`id`, `first_name`, `middle_name`, `surname`, `suffix`, `sex`, `dob`, `marital_status`, `contact_number`, `address_id`, `is_deleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
(14, 'Athara Mariel ', 'Mendoza', 'Negrillo', 'None', 'female', '2005-03-29', 'single', '09197657974', 29, 1, '2025-03-04 07:15:14', '2025-03-18 03:02:38', '2025-03-04 07:15:14'),
(15, 'Michael', 'Punzalan', 'Seva', 'None', 'male', '2002-09-01', 'single', '09953838730', 31, 1, '2025-03-06 07:00:57', '2025-03-12 02:50:40', '2025-03-06 07:00:57'),
(16, 'Nathaniel ', 'Pogi', 'Padila', 'Sr.', 'female', '1977-10-20', 'divorced', '09953838730', 33, 1, '2025-03-14 01:02:42', '2025-03-14 01:02:42', '2025-03-14 01:02:42'),
(18, 'Mark Nathaniel ', 'Dela Vega', 'olpot', 'None', 'male', '2002-11-24', 'single', '09953838730', 37, 1, '2025-03-24 01:19:00', '2025-03-24 01:19:00', '2025-03-24 01:19:00');

-- --------------------------------------------------------

--
-- Table structure for table `collateral_files`
--

CREATE TABLE `collateral_files` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `collateral_files`
--

INSERT INTO `collateral_files` (`id`, `borrower_id`, `file_path`, `created_at`) VALUES
(33, 14, 'collateral_files/67c6a88224799.png', '2025-03-04 07:15:14'),
(34, 14, 'collateral_files/67c6a882249f0.png', '2025-03-04 07:15:14'),
(35, 14, 'collateral_files/67c6a88224c9c.png', '2025-03-04 07:15:14'),
(36, 14, 'collateral_files/67c6a882253ef.png', '2025-03-04 07:15:14'),
(37, 14, 'collateral_files/67c6a88225664.png', '2025-03-04 07:15:14'),
(38, 15, 'collateral_files/67c94829a5ed9.png', '2025-03-06 07:00:57'),
(39, 15, 'collateral_files/67c94829a62d2.png', '2025-03-06 07:00:57'),
(40, 15, 'collateral_files/67c94829a6544.png', '2025-03-06 07:00:57'),
(41, 16, 'collateral_files/67d38032aab82.jpg', '2025-03-14 01:02:42'),
(42, 16, 'collateral_files/67d38032aafb8.jpg', '2025-03-14 01:02:42'),
(43, 16, 'collateral_files/67d38032ab306.png', '2025-03-14 01:02:42'),
(47, 18, 'collateral_files/67e0b304c195d.png', '2025-03-24 01:19:00'),
(48, 18, 'collateral_files/67e0b304c1c66.png', '2025-03-24 01:19:00');

-- --------------------------------------------------------

--
-- Table structure for table `dependents`
--

CREATE TABLE `dependents` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_number_dependents` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dependents`
--

INSERT INTO `dependents` (`id`, `borrower_id`, `name`, `contact_number_dependents`, `created_at`) VALUES
(9, 14, 'bading', '09191324234', '2025-03-04 07:15:14'),
(10, 15, 'pogi', '12345678', '2025-03-06 07:00:57'),
(11, 16, 'Taka', '09123456789', '2025-03-14 01:02:42'),
(13, 18, 'Michael Seva', '09123456789', '2025-03-24 01:19:00');

-- --------------------------------------------------------

--
-- Table structure for table `employment_details`
--

CREATE TABLE `employment_details` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `employer_name` varchar(255) NOT NULL,
  `years_with_employer` int(11) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `phone_no` varchar(50) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employment_details`
--

INSERT INTO `employment_details` (`id`, `borrower_id`, `employer_name`, `years_with_employer`, `position`, `phone_no`, `salary`, `address_id`, `created_at`) VALUES
(11, 14, 'badong', 1, 'sixty nine', '09197657973', 20000.00, 30, '2025-03-04 07:15:14'),
(12, 15, 'maranatha barredo', 1, 'gm', '09953838730', 21212.00, 32, '2025-03-06 07:00:57'),
(13, 16, 'Jhon lloyd', 12, 'manager', '09953838730', 3123123.00, 34, '2025-03-14 01:02:42'),
(15, 18, 'maranatha barredo', 12, 'manager', '09953838730', 23213123.00, 38, '2025-03-24 01:19:00');

-- --------------------------------------------------------

--
-- Table structure for table `grocery`
--

CREATE TABLE `grocery` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(20) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `grocery_amount` decimal(10,2) NOT NULL,
  `grocery_date` date NOT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery`
--

INSERT INTO `grocery` (`id`, `reference_no`, `borrower_id`, `grocery_amount`, `grocery_date`, `remarks`, `created_at`, `updated_at`) VALUES
(6, 'GR-2D16DE', 14, 111.00, '2025-03-20', 'Grocery added successfully', '2025-03-20 06:21:38', '2025-03-20 14:21:38'),
(7, 'GR-F42B5F', 18, 10000.00, '2025-03-24', 'Grocery added successfully', '2025-03-24 01:19:59', '2025-03-24 09:19:59');

-- --------------------------------------------------------

--
-- Table structure for table `identification_documents`
--

CREATE TABLE `identification_documents` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `id_type` enum('SSS','TIN','PAGIBIG','PhilHealth','PAN','GSIS','National ID','Birth Certificate','Voter''s ID','Driver''s License','Passport') NOT NULL,
  `id_no` varchar(50) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `id_photo_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `identification_documents`
--

INSERT INTO `identification_documents` (`id`, `borrower_id`, `id_type`, `id_no`, `expiry_date`, `id_photo_path`, `created_at`) VALUES
(11, 14, 'TIN', '12312', '2025-03-20', 'id_photos/67c6a88223421.png', '2025-03-04 07:15:14'),
(12, 15, 'Birth Certificate', '999999', '2025-03-12', 'id_photos/67c94829a4b0f.jpg', '2025-03-06 07:00:57'),
(13, 16, 'Driver\'s License', '999999', '2025-03-25', 'id_photos/67d38032a96ff.png', '2025-03-14 01:02:42'),
(15, 18, 'Driver\'s License', '2321312', '2025-03-24', 'id_photos/67e0b304c09f8.jpg', '2025-03-24 01:19:00');

-- --------------------------------------------------------

--
-- Table structure for table `insurance_details`
--

CREATE TABLE `insurance_details` (
  `id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `insurance_provider` varchar(100) NOT NULL,
  `issued_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `insurance_file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `insurance_details`
--

INSERT INTO `insurance_details` (`id`, `borrower_id`, `insurance_provider`, `issued_date`, `expiry_date`, `insurance_file_path`, `created_at`, `updated_at`) VALUES
(8, 14, 'Sun Life', '2025-03-04', '2025-03-20', 'insurance_files/67c6a8822384c.png', '2025-03-04 07:15:14', '2025-03-20 06:22:18'),
(9, 15, 'Manulife', '2025-03-03', '2025-03-12', 'insurance_files/67c94829a5347.png', '2025-03-06 07:00:57', '2025-03-12 03:03:52'),
(10, 16, 'Insular Life', '2025-07-15', '2026-05-14', 'insurance_files/67d38032a9e2a.jpg', '2025-03-14 01:02:42', '2025-03-14 01:02:42'),
(12, 18, 'Sun Life', '2025-03-24', '2025-03-24', 'insurance_files/67e0b304c0e6e.png', '2025-03-24 01:19:00', '2025-03-24 01:19:00');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(20) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `customer_type` enum('Regular','VIP','Other','') NOT NULL,
  `loan_amount` float(10,2) NOT NULL,
  `interest_rate` int(10) NOT NULL,
  `loan_date` date NOT NULL DEFAULT curdate(),
  `term_months` int(11) NOT NULL,
  `repayment_date` date NOT NULL,
  `promissory_id` int(11) NOT NULL,
  `remarks` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`id`, `reference_no`, `borrower_id`, `customer_type`, `loan_amount`, `interest_rate`, `loan_date`, `term_months`, `repayment_date`, `promissory_id`, `remarks`, `created_at`, `updated_at`) VALUES
(133, 'LN-986BA5', 14, 'Regular', 1000.00, 7, '2025-03-24', 12, '2026-03-24', 132, 'd', '2025-03-24 09:46:01', '2025-03-24 09:46:01');

-- --------------------------------------------------------

--
-- Table structure for table `loan_balance`
--

CREATE TABLE `loan_balance` (
  `id` int(11) NOT NULL,
  `loan_reference_no` varchar(128) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `loan_balance` float(10,2) NOT NULL DEFAULT 0.00,
  `month_term_duration` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_balance`
--

INSERT INTO `loan_balance` (`id`, `loan_reference_no`, `borrower_id`, `loan_balance`, `month_term_duration`, `status`, `created_at`, `updated_at`) VALUES
(26, '', 14, 1000.00, 0, 0, '2025-03-24 01:46:01', '2025-03-24 01:46:01');

-- --------------------------------------------------------

--
-- Table structure for table `loan_schedules`
--

CREATE TABLE `loan_schedules` (
  `id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `due_date` date NOT NULL,
  `principal_amount` decimal(10,2) NOT NULL,
  `interest_amount` decimal(10,2) NOT NULL,
  `shortfall` float(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','paid','overdue') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `notif_content` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `notif_content`, `status`, `created_at`) VALUES
(886, 'Mark Nathaniel  Dela Vega olpot\'s  is expiring in 15 days (on Mar 19, 2025)', 0, '2025-03-04 15:12:30'),
(887, 'Mark Nathaniel  Dela Vega olpot\'s Manulife insurance is expiring in 22 days (on Mar 26, 2025)', 0, '2025-03-04 15:12:30'),
(891, 'Jayson Fajardo bustos\'s Manulife insurance is expiring in 20 days (on Mar 24, 2025)', 0, '2025-03-04 15:13:50'),
(893, 'Jayson Fajardo bustos\'s Voter\'s ID is expiring in 15 days (on Mar 19, 2025)', 0, '2025-03-04 15:14:12'),
(895, 'Jayson Fajardo bustos\'s Manulife insurance is expiring in 15 days (on Mar 19, 2025)', 0, '2025-03-04 15:14:12'),
(897, 'Athara Mariel  Mendoza Negrillo\'s TIN is expiring in 0 days (on Mar 04, 2025)', 0, '2025-03-04 15:15:35'),
(902, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 28 days (on Apr 01, 2025)', 0, '2025-03-04 15:15:35'),
(1748, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 24 days (on Mar 28, 2025)', 0, '2025-03-04 16:04:31'),
(2541, 'Jayson Fajardo bustos\'s Voter\'s ID is expiring in 13 days (on Mar 19, 2025)', 0, '2025-03-06 08:42:46'),
(2542, 'Jayson Fajardo bustos\'s Manulife insurance is expiring in 13 days (on Mar 19, 2025)', 0, '2025-03-06 08:42:46'),
(2543, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 22 days (on Mar 28, 2025)', 0, '2025-03-06 08:42:46'),
(2598, 'Mark Nathaniel  Dela Vega olpot\'s TIN is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 08:54:27'),
(4650, 'Mark Nathaniel  Dela olpot\'s TIN is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 14:27:23'),
(4895, 'Mark Nathaniel  Dela Vega Olpot\'s Birth Certificate is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:01:01'),
(4896, 'Mark Nathaniel  Dela Vega Olpot\'s Manulife insurance is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:01:01'),
(4916, 'AHAHAHAHA Dela Vega Olpot\'s Birth Certificate is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:05:02'),
(4917, 'AHAHAHAHA Dela Vega Olpot\'s Manulife insurance is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:05:02'),
(5054, 'Burat  malake sheyt\'s Birth Certificate is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:28:22'),
(5055, 'Burat  malake sheyt\'s Manulife insurance is expiring in 0 days (on Mar 06, 2025)', 0, '2025-03-06 15:28:22'),
(5486, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 18 days (on Mar 28, 2025)', 0, '2025-03-10 14:10:51'),
(5511, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 16 days (on Mar 28, 2025)', 0, '2025-03-12 08:57:50'),
(5526, 'Athara Mariel  Mendoza Negrillo\'s TIN is expiring in 0 days (on Mar 12, 2025)', 0, '2025-03-12 09:08:13'),
(5527, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 0 days (on Mar 12, 2025)', 0, '2025-03-12 09:08:13'),
(5992, 'Michael Punzalan Seva\'s Manulife insurance is expiring in 9 days (on Mar 21, 2025)', 0, '2025-03-12 10:50:59'),
(6014, 'Michael Punzalan Seva\'s Birth Certificate is expiring in 0 days (on Mar 12, 2025)', 0, '2025-03-12 11:03:52'),
(6017, 'Michael Punzalan Seva\'s Manulife insurance is expiring in 0 days (on Mar 12, 2025)', 0, '2025-03-12 11:03:52'),
(7378, 'Athara Mariel  Mendoza Negrillo\'s TIN is expiring in 0 days (on Mar 14, 2025)', 0, '2025-03-14 08:48:55'),
(7391, 'Nathaniel  Pogi Padila\'s Driver\'s License is expiring in 11 days (on Mar 25, 2025)', 0, '2025-03-14 09:04:48'),
(7760, 'Nathaniel  Pogi Padila\'s Driver\'s License is expiring in 7 days (on Mar 25, 2025)', 0, '2025-03-18 08:37:33'),
(7935, 'MArk Dela Vega bustos\'s Driver\'s License is expiring in 0 days (on Mar 18, 2025)', 0, '2025-03-18 09:36:44'),
(7936, 'MArk Dela Vega bustos\'s Sun Life insurance is expiring in 0 days (on Mar 18, 2025)', 0, '2025-03-18 09:36:44'),
(9110, 'Nathaniel  Pogi Padila\'s Driver\'s License is expiring in 5 days (on Mar 25, 2025)', 0, '2025-03-20 09:09:52'),
(9430, 'Athara Mariel  Mendoza Negrillo\'s TIN is expiring in 0 days (on Mar 20, 2025)', 0, '2025-03-20 14:22:20'),
(9431, 'Athara Mariel  Mendoza Negrillo\'s Sun Life insurance is expiring in 0 days (on Mar 20, 2025)', 0, '2025-03-20 14:22:20'),
(9718, 'Nathaniel  Pogi Padila\'s Driver\'s License is expiring in 1 days (on Mar 25, 2025)', 0, '2025-03-24 08:20:10'),
(9747, 'Mark Nathaniel  Dela Vega olpot\'s Driver\'s License is expiring in 0 days (on Mar 24, 2025)', 0, '2025-03-24 09:20:29'),
(9748, 'Mark Nathaniel  Dela Vega olpot\'s Sun Life insurance is expiring in 0 days (on Mar 24, 2025)', 0, '2025-03-24 09:20:29');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(20) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `principal_amount` float(10,2) NOT NULL,
  `interest_amount` float(10,2) NOT NULL,
  `payment_amount` float(10,2) NOT NULL,
  `paid_amount` float(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `remarks` text NOT NULL,
  `status` enum('pending','paid','overdue','') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promissory_files`
--

CREATE TABLE `promissory_files` (
  `id` int(11) NOT NULL,
  `promissory_file_path` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `promissory_files`
--

INSERT INTO `promissory_files` (`id`, `promissory_file_path`, `created_at`) VALUES
(100, '1741073045_67c6aa95a432a.png', '2025-03-04 15:24:05'),
(101, '1741246305_67c94f61c898c.png', '2025-03-06 15:31:45'),
(102, '1741587555_67ce846380b7d.jpg', '2025-03-10 14:19:15'),
(103, '1741769182_67d149de312e5.png', '2025-03-12 16:46:22'),
(104, '1741914424_67d381384cd5e.pdf', '2025-03-14 09:07:04'),
(105, '1741919343_67d3946f052b1.pdf', '2025-03-14 10:29:03'),
(125, '1742438506_67db806a3a957.pdf', '2025-03-20 10:41:46'),
(126, '1742439285_67db8375c150a.pdf', '2025-03-20 10:54:45'),
(127, '1742439407_67db83ef128ce.jpg', '2025-03-20 10:56:47'),
(128, '1742451277_67dbb24d87820.jpg', '2025-03-20 14:14:37'),
(129, '1742779288_67e0b39843ed8.jpg', '2025-03-24 09:21:28'),
(130, '1742779940_67e0b6243b625.jpg', '2025-03-24 09:32:20'),
(131, '1742780102_67e0b6c680f1b.jpg', '2025-03-24 09:35:02'),
(132, '1742780761_67e0b95986c42.jpg', '2025-03-24 09:46:01');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(20) NOT NULL,
  `transaction_type` enum('loan','payment','grocery') NOT NULL,
  `transaction_date` datetime NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `borrower_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `balance` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `reference_no`, `transaction_type`, `transaction_date`, `amount`, `borrower_id`, `created_at`, `updated_at`, `balance`) VALUES
(75, 'LN-986BA5', 'loan', '2025-03-24 09:46:01', 1000.00, 14, '2025-03-24 09:46:01', '2025-03-24 09:46:01', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `role` enum('admin','user') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('active','disabled') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `profile_picture`, `role`, `created_at`, `updated_at`, `status`) VALUES
(47, 'Michael John P. Seva', 'michaeljohnseva@gmail.com', '$2y$10$IhkB2553qpiVFjhEhcliL.cn3HQ1sMu.BduNVy2f8iN/pCoblBb6O', 'uploads/users/michael_john_p__seva/profile/profile.png', 'user', '2025-03-12 07:51:53', '2025-03-20 03:08:01', 'active'),
(49, 'Mark Nathaniel D. Olpot', 'olpottado@gmail.com', '$2y$10$qidGXzbhcbG7v3/5I2jaZedl4t.W5dgE8th56g51pPjZjSZJ2SI2m', 'uploads/users/mark_nathaniel_d__olpot/profile/483311633_1270032217391694_5376076616978464691_n.jpg', 'admin', '2025-03-18 00:56:27', '2025-03-20 02:43:04', 'active'),
(52, 'Leopoldo Servana s', 'mangberting@gmail.com', '$2y$10$8oj69ZMbtOscd1RIndVGB.QEDSNUMztfaD9xU7qpuEJJAbVrUOg3K', 'uploads/users/leopoldo_servana_s/profile/481443120_642779155003662_6089384455521540379_n.jpg', 'admin', '2025-03-20 03:12:12', '2025-03-20 06:00:34', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`id`, `user_id`, `session_id`, `created_at`) VALUES
(2, 49, '8iok0ht9h1fmg5715i33g64s0q', '2025-03-18 01:29:11'),
(22, 49, 'r71olndkqh851agedh06ebe0pb', '2025-03-18 02:21:24'),
(26, 49, 'r71olndkqh851agedh06ebe0pb', '2025-03-18 02:34:40'),
(29, 49, 'r71olndkqh851agedh06ebe0pb', '2025-03-18 02:39:09'),
(34, 49, 'nu89luj8039v8s8sm8jrhm5gpj', '2025-03-18 02:58:52'),
(36, 47, '8iok0ht9h1fmg5715i33g64s0q', '2025-03-18 03:00:34'),
(37, 49, '8iok0ht9h1fmg5715i33g64s0q', '2025-03-18 03:00:45'),
(38, 49, 'nu89luj8039v8s8sm8jrhm5gpj', '2025-03-18 07:24:00'),
(39, 49, 'nu89luj8039v8s8sm8jrhm5gpj', '2025-03-18 07:47:05'),
(40, 49, 'nu89luj8039v8s8sm8jrhm5gpj', '2025-03-18 08:07:26'),
(41, 49, '5d105uokvkokurvojcff0vr0f7', '2025-03-20 01:09:51'),
(42, 47, 'n0en8glbb1dto806fmg7s47s4o', '2025-03-20 01:11:45'),
(43, 47, 'n0en8glbb1dto806fmg7s47s4o', '2025-03-20 01:13:17'),
(44, 49, '5d105uokvkokurvojcff0vr0f7', '2025-03-20 01:15:24'),
(45, 49, '92b6f7ic4sbvo3evqblomo4oho', '2025-03-20 01:28:14'),
(46, 49, '5d105uokvkokurvojcff0vr0f7', '2025-03-20 01:54:25'),
(47, 49, '5d105uokvkokurvojcff0vr0f7', '2025-03-20 02:48:13'),
(48, 49, '5d105uokvkokurvojcff0vr0f7', '2025-03-20 03:13:33'),
(49, 52, '92b6f7ic4sbvo3evqblomo4oho', '2025-03-20 03:14:04'),
(50, 49, '92b6f7ic4sbvo3evqblomo4oho', '2025-03-20 06:00:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `borrowers`
--
ALTER TABLE `borrowers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `collateral_files`
--
ALTER TABLE `collateral_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `dependents`
--
ALTER TABLE `dependents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `employment_details`
--
ALTER TABLE `employment_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `grocery`
--
ALTER TABLE `grocery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `identification_documents`
--
ALTER TABLE `identification_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `insurance_details`
--
ALTER TABLE `insurance_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`),
  ADD KEY `promissory_id` (`promissory_id`);

--
-- Indexes for table `loan_balance`
--
ALTER TABLE `loan_balance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`),
  ADD KEY `loan_reference_no` (`loan_reference_no`);

--
-- Indexes for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_notif` (`notif_content`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `promissory_files`
--
ALTER TABLE `promissory_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_id` (`borrower_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1195;

--
-- AUTO_INCREMENT for table `borrowers`
--
ALTER TABLE `borrowers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `collateral_files`
--
ALTER TABLE `collateral_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `dependents`
--
ALTER TABLE `dependents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `employment_details`
--
ALTER TABLE `employment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `grocery`
--
ALTER TABLE `grocery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `identification_documents`
--
ALTER TABLE `identification_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `insurance_details`
--
ALTER TABLE `insurance_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `loan_balance`
--
ALTER TABLE `loan_balance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=269;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9804;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `promissory_files`
--
ALTER TABLE `promissory_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrowers`
--
ALTER TABLE `borrowers`
  ADD CONSTRAINT `borrowers_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

--
-- Constraints for table `collateral_files`
--
ALTER TABLE `collateral_files`
  ADD CONSTRAINT `collateral_files_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `dependents`
--
ALTER TABLE `dependents`
  ADD CONSTRAINT `dependents_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `employment_details`
--
ALTER TABLE `employment_details`
  ADD CONSTRAINT `employment_details_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`),
  ADD CONSTRAINT `employment_details_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

--
-- Constraints for table `grocery`
--
ALTER TABLE `grocery`
  ADD CONSTRAINT `grocery_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `identification_documents`
--
ALTER TABLE `identification_documents`
  ADD CONSTRAINT `identification_documents_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `insurance_details`
--
ALTER TABLE `insurance_details`
  ADD CONSTRAINT `insurance_details_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`promissory_id`) REFERENCES `promissory_files` (`id`),
  ADD CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `loan_balance`
--
ALTER TABLE `loan_balance`
  ADD CONSTRAINT `loan_balance_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  ADD CONSTRAINT `loan_schedules_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`borrower_id`) REFERENCES `borrowers` (`id`);

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
