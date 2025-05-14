-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2025 at 12:31 PM
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
-- Database: `farm_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action_type` enum('login','logout','add_item','update_item','delete_item','increase_stock','reduce_stock') NOT NULL,
  `description` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `action_logs`
--

INSERT INTO `action_logs` (`id`, `user_id`, `action_type`, `description`, `timestamp`) VALUES
(1, 2, 'login', 'User logged in', '2025-05-10 17:13:30'),
(2, 2, 'login', 'User logged in', '2025-05-10 17:13:41'),
(3, 2, 'login', 'User logged in', '2025-05-10 17:13:42'),
(4, 2, 'login', 'User logged in', '2025-05-10 17:13:42'),
(5, 2, 'login', 'User logged in', '2025-05-10 17:13:42'),
(6, 2, 'login', 'User logged in', '2025-05-10 17:13:42'),
(7, 2, 'login', 'User logged in', '2025-05-10 17:13:42'),
(8, 3, 'login', 'User logged in', '2025-05-10 17:15:05'),
(9, 2, 'login', 'User logged in', '2025-05-10 20:17:41'),
(10, 2, 'login', 'User logged in', '2025-05-10 20:17:41'),
(11, 2, 'login', 'User logged in', '2025-05-10 20:17:41'),
(12, 2, 'login', 'User logged in', '2025-05-10 20:17:41'),
(13, 2, 'login', 'User logged in', '2025-05-10 20:17:41'),
(14, 3, 'login', 'User logged in', '2025-05-10 22:24:54'),
(15, 2, 'login', 'User logged in', '2025-05-10 22:25:21'),
(16, 1, 'login', 'User logged in', '2025-05-10 22:25:41'),
(17, 1, 'login', 'User logged in', '2025-05-10 22:25:42'),
(18, 2, 'login', 'User logged in', '2025-05-11 00:40:48'),
(19, 2, 'login', 'User logged in', '2025-05-11 02:27:48'),
(20, 3, 'login', 'User logged in', '2025-05-11 02:43:01'),
(21, 3, 'login', 'User logged in', '2025-05-11 02:43:03'),
(22, 1, 'login', 'User logged in', '2025-05-11 02:44:05'),
(23, 2, 'login', 'User logged in', '2025-05-11 02:46:06'),
(24, 2, 'login', 'User logged in', '2025-05-12 00:28:29'),
(25, 2, 'login', 'User logged in', '2025-05-12 00:29:59'),
(26, 1, 'login', 'User logged in', '2025-05-12 00:31:42'),
(27, 2, 'login', 'User logged in', '2025-05-12 00:32:23'),
(28, 2, 'login', 'User logged in', '2025-05-12 00:35:36'),
(29, 2, 'login', 'User logged in', '2025-05-12 01:12:09'),
(30, 2, 'login', 'User logged in', '2025-05-12 01:24:20'),
(31, 2, 'login', 'User logged in', '2025-05-12 01:29:48'),
(32, 2, 'login', 'User logged in', '2025-05-12 02:36:21'),
(33, 1, 'login', 'User logged in', '2025-05-12 03:03:43'),
(34, 2, 'login', 'User logged in', '2025-05-12 03:19:41'),
(35, 2, 'login', 'User logged in', '2025-05-12 03:48:01'),
(36, 3, 'login', 'User logged in', '2025-05-12 04:59:07'),
(37, 1, 'login', 'User logged in', '2025-05-12 04:59:19'),
(38, 2, 'login', 'User logged in', '2025-05-12 04:59:38'),
(39, 3, 'login', 'User logged in', '2025-05-12 06:39:48'),
(40, 2, 'login', 'User logged in', '2025-05-12 06:41:19'),
(41, 1, 'login', 'User logged in', '2025-05-12 06:44:28'),
(42, 3, 'login', 'User logged in', '2025-05-12 06:45:11'),
(43, 2, 'login', 'User logged in', '2025-05-12 06:47:27'),
(44, 1, 'login', 'User logged in', '2025-05-12 08:29:52'),
(45, 3, 'login', 'User logged in', '2025-05-12 08:31:36'),
(46, 2, 'login', 'User logged in', '2025-05-12 08:38:38'),
(47, 2, 'login', 'User logged in', '2025-05-12 10:20:43'),
(48, 3, 'login', 'User logged in', '2025-05-12 16:48:53'),
(49, 1, 'login', 'User logged in', '2025-05-12 16:51:23'),
(50, 2, 'login', 'User logged in', '2025-05-12 16:56:12'),
(51, 2, 'login', 'User logged in', '2025-05-13 03:05:56'),
(52, 2, 'login', 'User logged in', '2025-05-13 04:32:58'),
(53, 2, 'login', 'User logged in', '2025-05-13 13:24:40'),
(54, 1, 'login', 'User logged in', '2025-05-13 13:25:02'),
(55, 3, 'login', 'User logged in', '2025-05-13 13:25:23'),
(56, 2, 'login', 'User logged in', '2025-05-13 13:25:44'),
(57, 2, 'login', 'User logged in', '2025-05-13 23:11:36'),
(58, 2, 'login', 'User logged in', '2025-05-13 23:11:55'),
(59, 2, 'login', 'User logged in', '2025-05-13 23:28:25'),
(60, 1, 'login', 'User logged in', '2025-05-14 01:00:39'),
(61, 3, 'login', 'User logged in', '2025-05-14 01:01:14'),
(62, 2, 'login', 'User logged in', '2025-05-14 01:01:30'),
(63, 2, 'login', 'User logged in', '2025-05-14 05:35:42'),
(64, 2, 'login', 'User logged in', '2025-05-14 06:37:36'),
(65, 2, 'reduce_stock', 'Reduced stock for item ID: 1 by -1 units.', '2025-05-14 07:04:35'),
(66, 2, 'reduce_stock', 'Reduced stock for item ID: 12 by -1 units.', '2025-05-14 07:07:22'),
(67, 1, 'login', 'User logged in', '2025-05-14 07:08:42'),
(68, 2, 'login', 'User logged in', '2025-05-14 07:09:15'),
(69, 2, 'increase_stock', 'Increased stock for item ID: 13 by 10 units.', '2025-05-14 07:14:34'),
(70, 2, 'increase_stock', 'Increased stock for item ID: 13 by 1 units.', '2025-05-14 07:15:16'),
(71, 2, 'increase_stock', 'Increased stock for item ID: 12 by 1 units.', '2025-05-14 07:15:22'),
(72, 2, 'increase_stock', 'Increased stock for item ID: 13 by 1 units.', '2025-05-14 07:25:25'),
(73, 2, 'reduce_stock', 'Reduced stock for item ID: 13 by -1 units.', '2025-05-14 07:46:02'),
(74, 2, 'login', 'User logged in', '2025-05-14 07:49:23'),
(75, 2, 'login', 'User logged in', '2025-05-14 07:49:43'),
(76, 2, 'login', 'User logged in', '2025-05-14 08:22:17'),
(77, 1, 'login', 'User logged in', '2025-05-14 08:25:23'),
(78, 3, 'login', 'User logged in', '2025-05-14 08:25:50'),
(79, 2, 'login', 'User logged in', '2025-05-14 08:26:04'),
(80, 2, 'increase_stock', 'Increased stock for item ID: 14 by 2 units.', '2025-05-14 08:26:40'),
(81, 2, 'increase_stock', 'Increased stock for item ID: 15 by 1 units.', '2025-05-14 09:42:19'),
(82, 2, 'increase_stock', 'Increased stock for item ID: 17 by 1 units.', '2025-05-14 09:44:33'),
(83, 2, 'increase_stock', 'Increased stock for item ID: 16 by 1 units.', '2025-05-14 09:44:39'),
(84, 2, 'increase_stock', 'Increased stock for item ID: 18 by 1 units.', '2025-05-14 09:44:41'),
(85, 2, 'increase_stock', 'Increased stock for item ID: 19 by 1 units.', '2025-05-14 09:55:31');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `is_system` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `label`, `is_system`, `created_at`) VALUES
(1, 'agricultural', 'Agricultural', 1, '2025-05-12 01:47:06'),
(2, 'non-agricultural', 'Non-Agricultural', 1, '2025-05-12 01:47:06');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `predefined_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `harvest_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `predefined_item_id`, `quantity`, `harvest_date`, `created_at`, `updated_at`) VALUES
(1, 6, 1, '2025-05-13', '2025-05-12 22:13:15', '2025-05-14 07:04:35'),
(12, 3, 2, '2025-05-14', '2025-05-14 00:34:54', '2025-05-14 07:15:22'),
(13, 3, 14, '2025-05-14', '2025-05-14 01:10:39', '2025-05-14 07:46:02'),
(14, 8, 3, '2025-05-01', '2025-05-14 02:26:26', '2025-05-14 08:26:40'),
(15, 22, 2, '2025-05-14', '2025-05-14 03:39:18', '2025-05-14 09:42:19'),
(16, 20, 2, '2025-05-15', '2025-05-14 03:40:56', '2025-05-14 09:44:39'),
(17, 23, 3, '2025-05-16', '2025-05-14 03:43:56', '2025-05-14 09:44:33'),
(18, 21, 2, '2025-05-01', '2025-05-14 03:44:21', '2025-05-14 09:44:41'),
(19, 10, 3, '2025-05-14', '2025-05-14 03:49:24', '2025-05-14 09:55:31'),
(20, 17, 1, '2025-05-14', '2025-05-14 03:55:45', '2025-05-14 03:55:45'),
(21, 16, 1, NULL, '2025-05-14 03:58:37', '2025-05-14 03:58:37'),
(22, 15, 1, NULL, '2025-05-14 04:11:47', '2025-05-14 04:11:47'),
(23, 19, 1, NULL, '2025-05-14 04:20:51', '2025-05-14 04:20:51'),
(24, 18, 1, NULL, '2025-05-14 04:21:26', '2025-05-14 04:21:26');

-- --------------------------------------------------------

--
-- Table structure for table `item_history`
--

CREATE TABLE `item_history` (
  `id` int(11) NOT NULL,
  `predefined_item_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `change_type` enum('add','reduce','increase') DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `harvest_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item_history`
--

INSERT INTO `item_history` (`id`, `predefined_item_id`, `quantity`, `notes`, `change_type`, `date`, `harvest_date`) VALUES
(1, 6, -1, 'Stock reduced', 'reduce', '2025-05-14 06:55:48', NULL),
(2, 6, -1, 'Stock reduced', 'reduce', '2025-05-14 06:58:10', NULL),
(3, 3, -1, 'Stock reduced', 'reduce', '2025-05-14 07:02:59', NULL),
(4, 6, -1, 'Stock reduced', 'reduce', '2025-05-14 07:04:35', NULL),
(5, 3, -1, 'Stock reduced', 'reduce', '2025-05-14 07:07:22', NULL),
(6, 3, 1, 'Stock increased', 'increase', '2025-05-14 07:11:51', NULL),
(7, 3, 1, 'Stock increased', 'increase', '2025-05-14 07:13:58', NULL),
(8, 3, 10, 'Stock increased', 'increase', '2025-05-14 07:14:34', NULL),
(9, 3, 1, 'Stock increased', 'increase', '2025-05-14 07:15:16', NULL),
(10, 3, 1, 'Stock increased', 'increase', '2025-05-14 07:15:22', NULL),
(11, 3, 1, 'Stock increased', 'increase', '2025-05-14 07:25:25', NULL),
(12, 3, -1, 'Stock reduced', 'reduce', '2025-05-14 07:46:02', NULL),
(13, 8, 2, 'Stock increased', 'increase', '2025-05-14 08:26:40', NULL),
(14, 22, 1, 'Stock increased', 'increase', '2025-05-14 09:42:19', NULL),
(15, 23, 1, 'Stock increased', 'increase', '2025-05-14 09:44:33', NULL),
(16, 20, 1, 'Stock increased', 'increase', '2025-05-14 09:44:39', NULL),
(17, 21, 1, 'Stock increased', 'increase', '2025-05-14 09:44:41', NULL),
(18, 10, 1, 'Stock increased', 'increase', '2025-05-14 09:55:31', NULL),
(19, 16, 1, '', 'add', '2025-05-14 03:58:37', '2025-05-14'),
(20, 15, 1, '', 'add', '2025-05-14 04:11:47', '2025-05-14'),
(21, 19, 1, '', 'add', '2025-05-14 04:20:51', '2025-05-14'),
(22, 18, 1, '', 'add', '2025-05-14 04:21:26', '2025-05-14');

-- --------------------------------------------------------

--
-- Table structure for table `legacy_categories`
--

CREATE TABLE `legacy_categories` (
  `id` int(11) NOT NULL,
  `main_category` varchar(50) NOT NULL,
  `main_category_label` varchar(100) NOT NULL,
  `subcategory` varchar(50) NOT NULL,
  `subcategory_label` varchar(100) NOT NULL,
  `is_system` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `legacy_categories`
--

INSERT INTO `legacy_categories` (`id`, `main_category`, `main_category_label`, `subcategory`, `subcategory_label`, `is_system`, `created_at`) VALUES
(1, 'agricultural', 'Agricultural', 'vegetables', 'Vegetables', 1, '2025-05-12 01:43:03'),
(2, 'agricultural', 'Agricultural', 'soil', 'Soil', 1, '2025-05-12 01:43:03'),
(3, 'agricultural', 'Agricultural', 'fertilizer', 'Fertilizer', 1, '2025-05-12 01:43:03'),
(4, 'agricultural', 'Agricultural', 'cocopots', 'Cocopots', 1, '2025-05-12 01:43:03'),
(5, 'agricultural', 'Agricultural', 'seedlings', 'Seedlings', 1, '2025-05-12 01:43:03'),
(6, 'non-agricultural', 'Non-Agricultural', 'repurposed_items', 'Repurposed Items', 1, '2025-05-12 01:43:03');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_requests`
--

CREATE TABLE `password_reset_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `predefined_items`
--

CREATE TABLE `predefined_items` (
  `id` int(11) NOT NULL,
  `subcat_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `unit` enum('Kgs','Pcs') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `main_category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `predefined_items`
--

INSERT INTO `predefined_items` (`id`, `subcat_id`, `name`, `unit`, `created_at`, `main_category_id`) VALUES
(1, 1, 'Ampalaya', 'Kgs', '2025-05-11 21:19:09', 1),
(2, 1, 'Gabi', 'Kgs', '2025-05-11 21:19:09', 1),
(3, 1, 'Kalabasa', 'Kgs', '2025-05-11 21:19:09', 1),
(4, 1, 'Kamatis', 'Kgs', '2025-05-11 21:19:09', 1),
(5, 1, 'Kamias', 'Kgs', '2025-05-11 21:19:09', 1),
(6, 1, 'Kamote', 'Kgs', '2025-05-11 21:19:09', 1),
(7, 1, 'Kangkong', 'Kgs', '2025-05-11 21:19:09', 1),
(8, 1, 'Luya', 'Kgs', '2025-05-11 21:19:09', 1),
(9, 1, 'Malunggay', 'Kgs', '2025-05-11 21:19:09', 1),
(10, 1, 'Mustasa', 'Kgs', '2025-05-11 21:19:09', 1),
(11, 1, 'Okra', 'Kgs', '2025-05-11 21:19:09', 1),
(12, 1, 'Oregano', 'Kgs', '2025-05-11 21:19:09', 1),
(13, 1, 'Patola', 'Kgs', '2025-05-11 21:19:09', 1),
(14, 1, 'Pechay', 'Kgs', '2025-05-11 21:19:09', 1),
(15, 1, 'Papaya', 'Kgs', '2025-05-11 21:19:09', 1),
(16, 1, 'Siling Haba', 'Kgs', '2025-05-11 21:19:09', 1),
(17, 1, 'Sitaw', 'Kgs', '2025-05-11 21:19:09', 1),
(18, 1, 'Talbos ng Kamote', 'Kgs', '2025-05-11 21:19:09', 1),
(19, 1, 'Talong', 'Kgs', '2025-05-11 21:19:09', 1),
(20, 6, 'Clothes', 'Pcs', '2025-05-11 21:19:09', 2),
(21, 6, 'Rugs', 'Pcs', '2025-05-11 21:19:09', 2),
(22, 6, 'Bags', 'Pcs', '2025-05-11 21:19:09', 2),
(23, 6, 'Ecobricks', 'Pcs', '2025-05-11 21:19:09', 2);

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `unit` enum('kg','pcs') DEFAULT 'kg',
  `is_system` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`id`, `category_id`, `name`, `label`, `unit`, `is_system`, `created_at`) VALUES
(1, 1, 'vegetables', 'Vegetables', 'kg', 1, '2025-05-12 01:47:13'),
(2, 1, 'soil', 'Soil', 'kg', 1, '2025-05-12 01:47:13'),
(3, 1, 'fertilizer', 'Fertilizer', 'kg', 1, '2025-05-12 01:47:13'),
(4, 1, 'cocopots', 'Cocopots', 'pcs', 1, '2025-05-12 01:47:13'),
(5, 1, 'seedlings', 'Seedlings', 'pcs', 1, '2025-05-12 01:47:13'),
(6, 2, 'repurposed_items', 'Repurposed Items', 'pcs', 1, '2025-05-12 01:47:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','operator','supervisor') NOT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `subdivision` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `contact`, `subdivision`, `created_at`, `updated_at`) VALUES
(1, 'supervisor1', 'sup@example.com', 'su123', 'supervisor', '09171234567', 'Phase 1', '2025-05-10 16:44:07', '2025-05-11 02:26:32'),
(2, 'operator1', 'op@example.com', 'op123', 'operator', '09179876543', 'Phase 2', '2025-05-10 16:44:07', '2025-05-11 02:24:45'),
(3, 'user1', 'user@example.com', 'us123', 'user', '09179998888', 'Block 3', '2025-05-10 16:44:07', '2025-05-11 02:25:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `predefined_item_id` (`predefined_item_id`);

--
-- Indexes for table `item_history`
--
ALTER TABLE `item_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `predefined_item_id` (`predefined_item_id`);

--
-- Indexes for table `legacy_categories`
--
ALTER TABLE `legacy_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `predefined_items`
--
ALTER TABLE `predefined_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`subcat_id`),
  ADD KEY `fk_main_category` (`main_category_id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `item_history`
--
ALTER TABLE `item_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `legacy_categories`
--
ALTER TABLE `legacy_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `predefined_items`
--
ALTER TABLE `predefined_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD CONSTRAINT `action_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`predefined_item_id`) REFERENCES `predefined_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `item_history`
--
ALTER TABLE `item_history`
  ADD CONSTRAINT `item_history_ibfk_1` FOREIGN KEY (`predefined_item_id`) REFERENCES `predefined_items` (`id`);

--
-- Constraints for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  ADD CONSTRAINT `password_reset_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `password_reset_requests_ibfk_2` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `predefined_items`
--
ALTER TABLE `predefined_items`
  ADD CONSTRAINT `fk_main_category` FOREIGN KEY (`main_category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_subcategory` FOREIGN KEY (`subcat_id`) REFERENCES `subcategories` (`id`),
  ADD CONSTRAINT `predefined_items_ibfk_1` FOREIGN KEY (`subcat_id`) REFERENCES `legacy_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
