-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 20, 2024 at 04:21 PM
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
-- Database: `farmart_ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `activations`
--

CREATE TABLE `activations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(120) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activations`
--

INSERT INTO `activations` (`id`, `user_id`, `code`, `completed`, `completed_at`, `created_at`, `updated_at`) VALUES
(1, 1, '14Dw6wtSgvTGqUb8MJZagCTIYn0I21w0', 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18', '2024-08-05 02:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `action_label` varchar(191) DEFAULT NULL,
  `action_url` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `permission` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE `ads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `expired_at` datetime DEFAULT NULL,
  `location` varchar(120) DEFAULT NULL,
  `key` varchar(120) NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `clicked` bigint(20) NOT NULL DEFAULT 0,
  `order` int(11) DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `open_in_new_tab` tinyint(1) NOT NULL DEFAULT 1,
  `tablet_image` varchar(191) DEFAULT NULL,
  `mobile_image` varchar(191) DEFAULT NULL,
  `ads_type` varchar(191) DEFAULT NULL,
  `google_adsense_slot_id` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`id`, `name`, `expired_at`, `location`, `key`, `image`, `url`, `clicked`, `order`, `status`, `created_at`, `updated_at`, `open_in_new_tab`, `tablet_image`, `mobile_image`, `ads_type`, `google_adsense_slot_id`) VALUES
(1, 'Top Slider Image 1', '2029-08-05 00:00:00', 'not_set', 'VC2C8Q1UGCBG', 'promotion/1.jpg', '/products', 0, 1, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37', 1, NULL, NULL, NULL, NULL),
(2, 'Homepage middle 1', '2029-08-05 00:00:00', 'not_set', 'IZ6WU8KUALYD', 'promotion/2.png', '/products', 0, 2, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37', 1, NULL, NULL, NULL, NULL),
(3, 'Homepage middle 2', '2029-08-05 00:00:00', 'not_set', 'ILSFJVYFGCPZ', 'promotion/3.png', '/products', 0, 3, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37', 1, NULL, NULL, NULL, NULL),
(4, 'Homepage middle 3', '2029-08-05 00:00:00', 'not_set', 'ZDOZUZZIU7FT', 'promotion/4.png', '/products', 0, 4, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37', 1, NULL, NULL, NULL, NULL),
(5, 'Products list 1', '2029-08-05 00:00:00', 'not_set', 'ZDOZUZZIU7FZ', 'promotion/5.png', '/products/beat-headphone', 0, 5, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ads_translations`
--

CREATE TABLE `ads_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ads_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_histories`
--

CREATE TABLE `audit_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `module` varchar(60) NOT NULL,
  `request` longtext DEFAULT NULL,
  `action` varchar(120) NOT NULL,
  `user_agent` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `reference_user` bigint(20) UNSIGNED NOT NULL,
  `reference_id` bigint(20) UNSIGNED NOT NULL,
  `reference_name` varchar(191) NOT NULL,
  `type` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_histories`
--

INSERT INTO `audit_histories` (`id`, `user_id`, `module`, `request`, `action`, `user_agent`, `ip_address`, `reference_user`, `reference_id`, `reference_name`, `type`, `created_at`, `updated_at`) VALUES
(1, 1, 'to the system', NULL, 'logged in', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 0, 1, 'Maida Brekke', 'info', '2024-09-20 02:14:26', '2024-09-20 02:14:26'),
(2, 1, 'product-category', '{\"order\":\"1\",\"name\":\"Eau De Parfum\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"eau-de-parfum\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'Eau De Parfum', 'info', '2024-09-20 02:18:03', '2024-09-20 02:18:03'),
(3, 1, 'product-category', '{\"order\":\"2\",\"name\":\"Concentrated Parfum\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":null,\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 2, 'Concentrated Parfum', 'info', '2024-09-20 02:18:46', '2024-09-20 02:18:46'),
(4, 1, 'product-category', '{\"order\":\"3\",\"name\":\"Dakhoon\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"dakhoon\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 3, 'Dakhoon', 'info', '2024-09-20 02:19:05', '2024-09-20 02:19:05'),
(5, 1, 'product-category', '{\"order\":\"4\",\"name\":\"Gift Sets\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"gift-sets\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Gift Sets', 'info', '2024-09-20 02:19:23', '2024-09-20 02:19:23'),
(6, 1, 'product-category', '{\"order\":\"5\",\"name\":\"Gel\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"gel\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 5, 'Gel', 'info', '2024-09-20 02:19:41', '2024-09-20 02:19:41'),
(7, 1, 'product-category', '{\"order\":\"6\",\"name\":\"Hair Mist\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":null,\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 6, 'Hair Mist', 'info', '2024-09-20 02:20:10', '2024-09-20 02:20:10'),
(8, 1, 'product-category', '{\"order\":\"7\",\"name\":\"Collections\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"collections\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 7, 'Collections', 'info', '2024-09-20 02:20:29', '2024-09-20 02:20:29'),
(9, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Oriental Fragrance\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"oriental-fragrance\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"1\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 8, 'Oriental Fragrance', 'info', '2024-09-20 02:26:33', '2024-09-20 02:26:33'),
(10, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Occidental Fragrance\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"occidental-fragrance\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"1\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 9, 'Occidental Fragrance', 'info', '2024-09-20 02:26:52', '2024-09-20 02:26:52'),
(11, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Dehn Al Oud\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"dehn-al-oud\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"2\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 10, 'Dehn Al Oud', 'info', '2024-09-20 02:27:27', '2024-09-20 02:27:27'),
(12, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Concentrated Oil\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"concentrated-oil\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"2\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 11, 'Concentrated Oil', 'info', '2024-09-20 02:27:48', '2024-09-20 02:27:48'),
(13, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Bakhoor\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"bakhoor\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"3\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 12, 'Bakhoor', 'info', '2024-09-20 02:28:10', '2024-09-20 02:28:10'),
(14, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Natural Oud\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"natural-oud\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"3\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 13, 'Natural Oud', 'info', '2024-09-20 02:28:38', '2024-09-20 02:28:38'),
(15, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Oud Ma\'attar\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"oud-maattar\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"3\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 14, 'Oud Ma\'attar', 'info', '2024-09-20 02:29:24', '2024-09-20 02:29:24'),
(16, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Air Freshener\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"air-freshener\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"3\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 15, 'Air Freshener', 'info', '2024-09-20 02:29:47', '2024-09-20 02:29:47'),
(17, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Gift Sets\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"gift-sets-1\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"4\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 16, 'Gift Sets', 'info', '2024-09-20 02:30:12', '2024-09-20 02:30:12'),
(18, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Body Gel\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"body-gel\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"5\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 17, 'Body Gel', 'info', '2024-09-20 02:30:44', '2024-09-20 02:30:44'),
(19, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Premium Collection\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"premium-collection\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"7\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 18, 'Premium Collection', 'info', '2024-09-20 02:31:13', '2024-09-20 02:31:13'),
(20, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Online Exclusive Sets\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"online-exclusive-sets\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"7\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 19, 'Online Exclusive Sets', 'info', '2024-09-20 02:31:34', '2024-09-20 02:31:34'),
(21, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Summer Collection\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"summer-collection\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"parent_id\":\"7\",\"description\":null,\"status\":\"published\",\"image\":null,\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 20, 'Summer Collection', 'info', '2024-09-20 02:31:59', '2024-09-20 02:31:59'),
(22, 1, 'product-category', '{\"order\":\"1\",\"name\":\"Eau De Parfum\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"fruits-vegetables\",\"slug_id\":\"6\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/marj-banner-1.jpg\",\"icon\":\"0\",\"icon_image\":\"product-categories\\/marj.jpg\",\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'Eau De Parfum', 'primary', '2024-09-20 02:45:48', '2024-09-20 02:45:48'),
(23, 1, 'product-category', '{\"order\":\"2\",\"name\":\"Concentrated Parfum\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"fruits\",\"slug_id\":\"7\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":\"product-categories\\/bidun-esam-oil.jpg\",\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 2, 'Concentrated Parfum', 'primary', '2024-09-20 02:51:31', '2024-09-20 02:51:31'),
(24, 1, 'product-category', '{\"order\":\"3\",\"name\":\"Dakhoon\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"apples\",\"slug_id\":\"8\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":\"product-categories\\/oud-mattar-maliki.jpg\",\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 3, 'Dakhoon', 'primary', '2024-09-20 02:52:54', '2024-09-20 02:52:54'),
(25, 1, 'product-category', '{\"order\":\"5\",\"name\":\"Gel\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"berries\",\"slug_id\":\"10\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":\"product-categories\\/oud-roses-bodygel.jpg\",\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 5, 'Gel', 'primary', '2024-09-20 02:53:52', '2024-09-20 02:53:52'),
(26, 1, 'product-category', '{\"order\":\"7\",\"name\":\"Collections\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"grapes\",\"slug_id\":\"12\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":\"product-categories\\/oud-roses-collection-1.jpg\",\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 7, 'Collections', 'primary', '2024-09-20 02:55:03', '2024-09-20 02:55:03'),
(27, 1, 'product-category', '{\"order\":\"4\",\"name\":\"Gift Sets\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"bananas\",\"slug_id\":\"9\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":\"product-categories\\/little-hearts.jpg\",\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Gift Sets', 'primary', '2024-09-20 02:55:45', '2024-09-20 02:55:45'),
(28, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Occidental Fragrance\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"peaches-nectarines\",\"slug_id\":\"14\",\"is_slug_editable\":\"1\",\"parent_id\":\"1\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 9, 'Occidental Fragrance', 'primary', '2024-09-20 03:05:01', '2024-09-20 03:05:01'),
(29, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Oriental Fragrance\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"lemons-limes\",\"slug_id\":\"13\",\"is_slug_editable\":\"1\",\"parent_id\":\"1\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 8, 'Oriental Fragrance', 'primary', '2024-09-20 03:05:08', '2024-09-20 03:05:08'),
(30, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Concentrated Oil\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"melon\",\"slug_id\":\"16\",\"is_slug_editable\":\"1\",\"parent_id\":\"2\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 11, 'Concentrated Oil', 'primary', '2024-09-20 03:05:14', '2024-09-20 03:05:14'),
(31, 1, 'product-category', '{\"order\":\"8\",\"name\":\"Dehn Al Oud\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"pears\",\"slug_id\":\"15\",\"is_slug_editable\":\"1\",\"parent_id\":\"2\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 10, 'Dehn Al Oud', 'primary', '2024-09-20 03:05:24', '2024-09-20 03:05:24'),
(32, 1, 'product-category', '{\"order\":\"0\",\"name\":\"Bakhoor\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"avocados\",\"slug_id\":\"17\",\"is_slug_editable\":\"1\",\"parent_id\":\"3\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 12, 'Bakhoor', 'primary', '2024-09-20 03:06:20', '2024-09-20 03:06:20'),
(33, 1, 'product-category', '{\"order\":\"1\",\"name\":\"Natural Oud\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"plums-apricots\",\"slug_id\":\"18\",\"is_slug_editable\":\"1\",\"parent_id\":\"3\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 13, 'Natural Oud', 'primary', '2024-09-20 03:06:25', '2024-09-20 03:06:25'),
(34, 1, 'product-category', '{\"order\":\"2\",\"name\":\"Oud Ma\'attar\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"vegetables\",\"slug_id\":\"19\",\"is_slug_editable\":\"1\",\"parent_id\":\"3\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 14, 'Oud Ma\'attar', 'primary', '2024-09-20 03:06:32', '2024-09-20 03:06:32'),
(35, 1, 'product-category', '{\"order\":\"3\",\"name\":\"Air Freshener\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"potatoes\",\"slug_id\":\"20\",\"is_slug_editable\":\"1\",\"parent_id\":\"3\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 15, 'Air Freshener', 'primary', '2024-09-20 03:06:40', '2024-09-20 03:06:40'),
(36, 1, 'product-category', '{\"order\":\"0\",\"name\":\"Body Gel\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"broccoli-cauliflower\",\"slug_id\":\"22\",\"is_slug_editable\":\"1\",\"parent_id\":\"5\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 17, 'Body Gel', 'primary', '2024-09-20 03:07:20', '2024-09-20 03:07:20'),
(37, 1, 'product-category', '{\"order\":\"5\",\"name\":\"Hair Mist\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"oranges-easy-peelers\",\"slug_id\":\"11\",\"is_slug_editable\":\"1\",\"parent_id\":\"0\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 6, 'Hair Mist', 'primary', '2024-09-20 03:07:33', '2024-09-20 03:07:33'),
(38, 1, 'product-category', '{\"order\":\"0\",\"name\":\"Summer Collection\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"mushrooms\",\"slug_id\":\"25\",\"is_slug_editable\":\"1\",\"parent_id\":\"7\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 20, 'Summer Collection', 'primary', '2024-09-20 03:07:42', '2024-09-20 03:07:42'),
(39, 1, 'product-category', '{\"order\":\"1\",\"name\":\"Online Exclusive Sets\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"onions-leeks-garlic\",\"slug_id\":\"24\",\"is_slug_editable\":\"1\",\"parent_id\":\"7\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 19, 'Online Exclusive Sets', 'primary', '2024-09-20 03:07:47', '2024-09-20 03:07:47'),
(40, 1, 'product-category', '{\"order\":\"2\",\"name\":\"Premium Collection\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductCategory\",\"slug\":\"cabbage-spinach-greens\",\"slug_id\":\"23\",\"is_slug_editable\":\"1\",\"parent_id\":\"7\",\"description\":null,\"status\":\"published\",\"image\":\"product-categories\\/laathani-banner.webp\",\"icon\":\"0\",\"icon_image\":null,\"is_featured\":\"0\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 18, 'Premium Collection', 'primary', '2024-09-20 03:07:52', '2024-09-20 03:07:52'),
(41, 1, 'product', '{\"name\":\"Bidun Esam\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"bidun-esam\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\",\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-V8KM\",\"price\":\"60\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'Bidun Esam', 'info', '2024-09-20 03:41:50', '2024-09-20 03:41:50'),
(42, 1, 'product', '{\"name\":\"Bidun Esam\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"dual-camera-20mp\",\"slug_id\":\"95\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\",\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-V8KM\",\"price\":\"60\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"1\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"8\"],\"brand_id\":null,\"image\":\"products\\/gardenia-notes.webp\",\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'Bidun Esam', 'primary', '2024-09-20 03:42:18', '2024-09-20 03:42:18'),
(43, 1, 'product', '{\"name\":\"Kaaf\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"kaaf\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/kaaf-notes.webp\",\"products\\/kaaf-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-GQ7H\",\"price\":\"90\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 2, 'Kaaf', 'info', '2024-09-20 03:51:10', '2024-09-20 03:51:10'),
(44, 1, 'product', '{\"name\":\"Kaaf\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"smart-watches\",\"slug_id\":\"96\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/kaaf-notes.webp\",\"products\\/kaaf-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-GQ7H\",\"price\":\"90\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"2\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"8\"],\"brand_id\":null,\"image\":\"products\\/kaaf-notes.webp\",\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 2, 'Kaaf', 'primary', '2024-09-20 03:51:40', '2024-09-20 03:51:40'),
(45, 1, 'product', '{\"_method\":\"delete\"}', 'deleted', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 2, 'Kaaf', 'danger', '2024-09-20 03:52:16', '2024-09-20 03:52:16'),
(46, 1, 'product', '{\"name\":\"Kaaf\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"kaaf\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/kaaf-notes.webp\",\"products\\/kaaf-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-FEJA\",\"price\":\"90\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"8\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 3, 'Kaaf', 'info', '2024-09-20 03:52:55', '2024-09-20 03:52:55'),
(47, 1, 'product', '{\"name\":\"Kaaf\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"beat-headphone\",\"slug_id\":\"97\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/kaaf-notes.webp\",\"products\\/kaaf-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-FEJA\",\"price\":\"90\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"3\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"8\"],\"brand_id\":null,\"image\":\"products\\/kaaf-notes.webp\",\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 3, 'Kaaf', 'primary', '2024-09-20 03:54:00', '2024-09-20 03:54:00'),
(48, 1, 'producttag', '{\"name\":\"New Launch\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\ProductTag\",\"slug\":\"new-launch\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\",\"status\":\"published\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'New Launch', 'info', '2024-09-20 03:56:38', '2024-09-20 03:56:38'),
(49, 1, 'productlabel', '{\"name\":\"New Launch\",\"color\":\"transparent\",\"submitter\":\"apply\",\"status\":\"published\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'New Launch', 'info', '2024-09-20 03:57:03', '2024-09-20 03:57:03'),
(50, 1, 'product', '{\"name\":\"Laathani\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"laathani\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-4T2B\",\"price\":\"175\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\",\"8\",\"2\",\"11\",\"10\",\"3\",\"12\",\"13\",\"14\",\"15\",\"4\",\"16\",\"5\",\"17\",\"6\",\"7\",\"20\",\"19\",\"18\"],\"brand_id\":null,\"image\":null,\"product_labels\":[\"4\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Laathani', 'info', '2024-09-20 03:57:35', '2024-09-20 03:57:35'),
(51, 1, 'product', '{\"name\":\"Laathani\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"red-black-headphone-digital\",\"slug_id\":\"98\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/laathani-web.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-4T2B\",\"price\":\"175\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"4\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\",\"8\",\"2\",\"11\",\"10\",\"3\",\"12\",\"13\",\"14\",\"15\",\"4\",\"16\",\"5\",\"17\",\"6\",\"7\",\"20\",\"19\",\"18\"],\"brand_id\":null,\"image\":null,\"product_labels\":[\"4\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Laathani', 'primary', '2024-09-20 03:58:05', '2024-09-20 03:58:05'),
(52, 1, 'product', '{\"name\":\"Laathani\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"red-black-headphone-digital\",\"slug_id\":\"98\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/laathani-web.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-4T2B\",\"price\":\"175\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"4\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\",\"8\",\"2\",\"11\",\"10\",\"3\",\"12\",\"13\",\"14\",\"15\",\"4\",\"16\",\"5\",\"17\",\"6\",\"7\",\"20\",\"19\",\"18\"],\"brand_id\":null,\"image\":\"products\\/laathani-web.webp\",\"product_labels\":[\"4\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Laathani', 'primary', '2024-09-20 04:05:01', '2024-09-20 04:05:01'),
(53, 1, 'product', '{\"name\":\"Oud & Roses\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"oud-roses\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/musk-ahmed.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-VPPG\",\"price\":\"135\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 5, 'Oud & Roses', 'info', '2024-09-20 04:07:24', '2024-09-20 04:07:24'),
(54, 1, 'product', '{\"name\":\"Marj\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"marj\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/maani.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-Q41Z\",\"price\":\"165\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"submitter\":\"apply\",\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 6, 'Marj', 'info', '2024-09-20 04:08:22', '2024-09-20 04:08:22'),
(55, 1, 'product', '{\"name\":\"Marj\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"nikon-hd-camera\",\"slug_id\":\"100\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/maani.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-Q41Z\",\"price\":\"165\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"6\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\"],\"brand_id\":null,\"image\":\"products\\/maani.webp\",\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 6, 'Marj', 'primary', '2024-09-20 04:09:52', '2024-09-20 04:09:52'),
(56, 1, 'product', '{\"name\":\"Dehn Al Oud Combodi Omani\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"dehn-al-oud-combodi-omani\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-NSTM\",\"price\":\"55\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"2\",\"10\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 7, 'Dehn Al Oud Combodi Omani', 'info', '2024-09-20 04:11:30', '2024-09-20 04:11:30'),
(57, 1, 'product', '{\"name\":\"Dehn Al Oudh Mubakhar\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"dehn-al-oudh-mubakhar\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-DCAX\",\"price\":\"75\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"2\",\"10\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 8, 'Dehn Al Oudh Mubakhar', 'info', '2024-09-20 04:12:36', '2024-09-20 04:12:36');
INSERT INTO `audit_histories` (`id`, `user_id`, `module`, `request`, `action`, `user_agent`, `ip_address`, `reference_user`, `reference_id`, `reference_name`, `type`, `created_at`, `updated_at`) VALUES
(58, 1, 'product', '{\"name\":\"Ghawi\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"ghawi\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-CTWA\",\"price\":\"131.25\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"2\",\"11\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 9, 'Ghawi', 'info', '2024-09-20 04:13:32', '2024-09-20 04:13:32'),
(59, 1, 'product', '{\"name\":\"Zukhruf\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"zukhruf\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-DZCY\",\"price\":\"37\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"2\",\"11\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 10, 'Zukhruf', 'info', '2024-09-20 04:14:22', '2024-09-20 04:14:22'),
(60, 1, 'product', '{\"name\":\"Bakhoor Baiti 10 tabs\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"bakhoor-baiti-10-tabs\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-H9AK\",\"price\":\"50\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"12\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 11, 'Bakhoor Baiti 10 tabs', 'info', '2024-09-20 04:16:17', '2024-09-20 04:16:17'),
(61, 1, 'product', '{\"name\":\"Bakhoor Oud & Roses\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"bakhoor-oud-roses\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-WEGY\",\"price\":\"110\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"12\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 12, 'Bakhoor Oud & Roses', 'info', '2024-09-20 04:16:52', '2024-09-20 04:16:52'),
(62, 1, 'product', '{\"name\":\"Maria Oud Mubakhar 36 Grams\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"maria-oud-mubakhar-36-grams\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/kaaf-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-HOPL\",\"price\":\"40\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"14\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 13, 'Maria Oud Mubakhar 36 Grams', 'info', '2024-09-20 04:17:57', '2024-09-20 04:17:57'),
(63, 1, 'product', '{\"name\":\"Maria Oud Mubakhar 58 Grams\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"maria-oud-mubakhar-58-grams\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-2D7O\",\"price\":\"70\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"14\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 14, 'Maria Oud Mubakhar 58 Grams', 'info', '2024-09-20 04:21:52', '2024-09-20 04:21:52'),
(64, 1, 'product', '{\"name\":\"Air Freshener Oud & Roses\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"air-freshener-oud-roses\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/maani.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-8LIO\",\"price\":\"29.40\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"15\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 15, 'Air Freshener Oud & Roses', 'info', '2024-09-20 04:23:03', '2024-09-20 04:23:03'),
(65, 1, 'product', '{\"name\":\"Air Freshener Oud Lavender\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"air-freshener-oud-lavender\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-XL6A\",\"price\":\"29.40\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"15\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 16, 'Air Freshener Oud Lavender', 'info', '2024-09-20 04:23:45', '2024-09-20 04:23:45'),
(66, 1, 'product', '{\"name\":\"Air Freshener Oud Lavender\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"apple-macbook-air-retina-12-inch-laptop-digital\",\"slug_id\":\"110\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/musk-ahmed.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-XL6A\",\"price\":\"29.4\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"16\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"15\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 16, 'Air Freshener Oud Lavender', 'primary', '2024-09-20 04:23:57', '2024-09-20 04:23:57'),
(67, 1, 'product', '{\"name\":\"Laathani\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"red-black-headphone-digital\",\"slug_id\":\"98\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/laathani-web.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-4T2B\",\"price\":\"175\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"4\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\",\"8\",\"2\",\"11\",\"10\",\"3\",\"12\",\"14\",\"15\",\"4\",\"16\",\"5\",\"17\",\"6\",\"7\",\"20\",\"19\",\"18\"],\"brand_id\":null,\"image\":\"products\\/laathani-web.webp\",\"product_labels\":[\"4\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Laathani', 'primary', '2024-09-20 04:28:33', '2024-09-20 04:28:33'),
(68, 1, 'product', '{\"name\":\"Oud & Roses Body Gel\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"oud-roses-body-gel\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-NLVW\",\"price\":\"26.25\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"5\",\"17\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 17, 'Oud & Roses Body Gel', 'info', '2024-09-20 04:31:12', '2024-09-20 04:31:12'),
(69, 1, 'product', '{\"name\":\"Supreme Body Gel\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"supreme-body-gel\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/kaaf-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-B6DH\",\"price\":\"26.25\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"5\",\"17\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 18, 'Supreme Body Gel', 'info', '2024-09-20 04:31:50', '2024-09-20 04:31:50'),
(70, 1, 'product', '{\"name\":\"Oud & Roses Collection\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"oud-roses-collection\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-VDQQ\",\"price\":\"246.33\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"7\",\"18\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 19, 'Oud & Roses Collection', 'info', '2024-09-20 04:33:46', '2024-09-20 04:33:46'),
(71, 1, 'product', '{\"name\":\"Little Hearts Collection\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"little-hearts-collection\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/musk-ahmed.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-RYLI\",\"price\":\"89.25\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"7\",\"18\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 20, 'Little Hearts Collection', 'info', '2024-09-20 04:34:18', '2024-09-20 04:34:18'),
(72, 1, 'product', '{\"name\":\"Bakhoor Bushra 10 Tabs\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"bakhoor-bushra-10-tabs\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-LNPU\",\"price\":\"50\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"7\",\"19\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 21, 'Bakhoor Bushra 10 Tabs', 'info', '2024-09-20 04:35:19', '2024-09-20 04:35:19'),
(73, 1, 'product', '{\"name\":\"Summer Collection 1\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"summer-collection-1\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/summer-collection-1-300x400.jpg\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-F6FK\",\"price\":\"416.50\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"7\",\"20\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 22, 'Summer Collection 1', 'info', '2024-09-20 04:37:26', '2024-09-20 04:37:26'),
(74, 1, 'product', '{\"name\":\"Summer Collection 1\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"baxter-care-hair-kit-for-bearded-mens\",\"slug_id\":\"116\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/kaaf-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-F6FK\",\"price\":\"416.5\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"22\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"7\",\"20\"],\"brand_id\":null,\"image\":\"products\\/summer-collection-1-300x400.jpg\",\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 22, 'Summer Collection 1', 'primary', '2024-09-20 04:37:47', '2024-09-20 04:37:47'),
(75, 1, 'product', '{\"name\":\"Marj\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"nikon-hd-camera\",\"slug_id\":\"100\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/maani.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-Q41Z\",\"price\":\"165\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"6\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"10\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\"],\"brand_id\":null,\"image\":\"products\\/maani.webp\",\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 6, 'Marj', 'primary', '2024-09-20 04:41:32', '2024-09-20 04:41:32'),
(76, 1, 'product', '{\"name\":\"Oud & Roses\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"smart-watch-external\",\"slug_id\":\"99\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/musk-ahmed.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-VPPG\",\"price\":\"135\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"5\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"10\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\"],\"brand_id\":null,\"image\":\"products\\/musk-ahmed.webp\",\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 5, 'Oud & Roses', 'primary', '2024-09-20 04:41:53', '2024-09-20 04:41:53'),
(77, 1, 'to the system', NULL, 'logged in', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 0, 1, 'Maida Brekke', 'info', '2024-09-20 06:52:08', '2024-09-20 06:52:08'),
(78, 1, 'product', '{\"name\":\"Test Prod\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"test-prod\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-NWVV\",\"price\":\"100\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"10\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"13\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 23, 'Test Prod', 'info', '2024-09-20 06:53:49', '2024-09-20 06:53:49'),
(79, 1, 'product', '{\"name\":\"Test Prod 2\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"test-prod-2\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-EECI\",\"price\":\"150\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"20\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"13\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 24, 'Test Prod 2', 'info', '2024-09-20 06:54:46', '2024-09-20 06:54:46'),
(80, 1, 'product', '{\"_method\":\"delete\"}', 'deleted', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 24, 'Test Prod 2', 'danger', '2024-09-20 06:56:52', '2024-09-20 06:56:52'),
(81, 1, 'product', '{\"name\":\"Rose Noir\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"rose-noir\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\",\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-WEV2\",\"price\":\"110\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"10\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"9\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 25, 'Rose Noir', 'info', '2024-09-20 07:27:57', '2024-09-20 07:27:57'),
(82, 1, 'product', '{\"name\":\"Oud Lavender\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"oud-lavender\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-0GDA\",\"price\":\"135\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"9\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 26, 'Oud Lavender', 'info', '2024-09-20 07:29:11', '2024-09-20 07:29:11'),
(83, 1, 'product', '{\"name\":\"Oud Lavender\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"taylors-of-harrogate-yorkshire-coffee\",\"slug_id\":\"120\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\",\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-0GDA\",\"price\":\"135\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"26\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"9\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 26, 'Oud Lavender', 'primary', '2024-09-20 07:29:30', '2024-09-20 07:29:30'),
(84, 1, 'product', '{\"name\":\"Oud Classic\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"oud-classic\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/gardenia-notes.webp\",\"products\\/gardenia-notes.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-QCXT\",\"price\":\"60\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"9\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 27, 'Oud Classic', 'info', '2024-09-20 07:30:55', '2024-09-20 07:30:55'),
(85, 1, 'tax', '{\"_method\":\"delete\"}', 'deleted', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 3, 'Import Tax', 'danger', '2024-09-20 09:39:02', '2024-09-20 09:39:02'),
(86, 1, 'tax', '{\"_method\":\"delete\"}', 'deleted', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'VAT', 'danger', '2024-09-20 09:39:04', '2024-09-20 09:39:04'),
(87, 1, 'tax', '{\"_method\":\"delete\"}', 'deleted', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 2, 'None', 'danger', '2024-09-20 09:39:06', '2024-09-20 09:39:06'),
(88, 1, 'product-collection', '{\"name\":\"New Launch\",\"description\":null,\"collection_products\":null,\"submitter\":\"apply\",\"status\":\"published\",\"is_featured\":\"0\",\"image\":null}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'New Launch', 'primary', '2024-09-20 09:40:37', '2024-09-20 09:40:37'),
(89, 1, 'product-collection', '{\"name\":\"New Launch\",\"description\":null,\"collection_products\":\",4\",\"submitter\":\"apply\",\"status\":\"published\",\"is_featured\":\"0\",\"image\":null}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'New Launch', 'primary', '2024-09-20 09:40:46', '2024-09-20 09:40:46'),
(90, 1, 'producttag', '{\"_method\":\"delete\"}', 'deleted', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'New Launch', 'danger', '2024-09-20 09:41:20', '2024-09-20 09:41:20'),
(91, 1, 'product', '{\"name\":\"Test Prod\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"ciate-palemore-lipstick-bold-red-color\",\"slug_id\":\"117\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-NWVV\",\"price\":\"100\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"23\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"10\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"13\"],\"brand_id\":null,\"image\":\"products\\/oud-and-lavender.webp\",\"product_collections\":[\"1\"],\"product_labels\":[\"3\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 23, 'Test Prod', 'primary', '2024-09-20 09:41:55', '2024-09-20 09:41:55'),
(92, 1, 'product', '{\"name\":\"Laathani\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"red-black-headphone-digital\",\"slug_id\":\"98\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/laathani-web.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-4T2B\",\"price\":\"175\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"4\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\",\"8\",\"2\",\"11\",\"10\",\"3\",\"12\",\"14\",\"15\",\"4\",\"16\",\"5\",\"17\",\"6\",\"7\",\"20\",\"19\",\"18\"],\"brand_id\":null,\"image\":\"products\\/laathani-web.webp\",\"product_collections\":[\"1\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Laathani', 'primary', '2024-09-20 09:50:20', '2024-09-20 09:50:20'),
(93, 1, 'product', '{\"name\":\"Laathani\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"red-black-headphone-digital\",\"slug_id\":\"98\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/laathani-web.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-4T2B\",\"price\":\"175\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"4\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\",\"8\",\"2\",\"11\",\"10\",\"3\",\"12\",\"13\",\"14\",\"15\",\"4\",\"16\",\"5\",\"17\",\"6\",\"7\",\"20\",\"19\",\"18\"],\"brand_id\":null,\"image\":\"products\\/laathani-web.webp\",\"product_collections\":[\"1\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Laathani', 'primary', '2024-09-20 10:00:51', '2024-09-20 10:00:51'),
(94, 1, 'product', '{\"name\":\"Test Prod\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"ciate-palemore-lipstick-bold-red-color\",\"slug_id\":\"117\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/oud-and-lavender.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-NWVV\",\"price\":\"100\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"23\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"10\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"13\"],\"brand_id\":null,\"image\":\"products\\/oud-and-lavender.webp\",\"product_labels\":[\"3\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 23, 'Test Prod', 'primary', '2024-09-20 10:01:43', '2024-09-20 10:01:43'),
(95, 1, 'product', '{\"name\":\"Laathani\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"red-black-headphone-digital\",\"slug_id\":\"98\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/laathani-web.webp\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-4T2B\",\"price\":\"175\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":\"4\",\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"1000\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":[[{\"key\":\"question\",\"value\":null},{\"key\":\"answer\",\"value\":null}]],\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"1\",\"9\",\"8\",\"2\",\"11\",\"10\",\"3\",\"12\",\"14\",\"15\",\"4\",\"16\",\"5\",\"17\",\"6\",\"7\",\"20\",\"19\",\"18\"],\"brand_id\":null,\"image\":\"products\\/laathani-web.webp\",\"product_collections\":[\"1\"],\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'Laathani', 'primary', '2024-09-20 10:02:07', '2024-09-20 10:02:07'),
(96, 1, 'product', '{\"name\":\"Test Prod 10\",\"model\":\"Botble\\\\Ecommerce\\\\Models\\\\Product\",\"slug\":\"test-prod-10\",\"slug_id\":\"0\",\"is_slug_editable\":\"1\",\"description\":null,\"content\":null,\"images\":[null,\"products\\/summer-collection-1-300x400.jpg\"],\"video_media\":\"[]\",\"product_type\":\"physical\",\"sale_type\":\"0\",\"sku\":\"FM-2443-UOE0\",\"price\":\"100\",\"sale_price\":null,\"start_date\":null,\"end_date\":null,\"cost_per_item\":\"0\",\"product_id\":null,\"barcode\":null,\"with_storehouse_management\":\"1\",\"quantity\":\"50\",\"allow_checkout_when_out_of_stock\":\"0\",\"stock_status\":\"in_stock\",\"weight\":\"0\",\"length\":\"0\",\"wide\":\"0\",\"height\":\"0\",\"has_product_options\":\"1\",\"related_products\":null,\"faq_schema_config\":\"[]\",\"seo_meta\":{\"seo_title\":null,\"seo_description\":null,\"index\":\"index\"},\"seo_meta_image\":null,\"status\":\"published\",\"store_id\":null,\"is_featured\":\"0\",\"categories\":[\"3\",\"13\"],\"brand_id\":null,\"image\":null,\"minimum_order_quantity\":\"0\",\"maximum_order_quantity\":\"0\",\"tag\":null,\"submitter\":\"apply\"}', 'created', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 28, 'Test Prod 10', 'info', '2024-09-20 10:03:57', '2024-09-20 10:03:57'),
(97, 1, 'product', '{\"_method\":\"delete\"}', 'deleted', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 28, 'Test Prod 10', 'danger', '2024-09-20 10:05:08', '2024-09-20 10:05:08'),
(98, 1, 'productlabel', '{\"_method\":\"delete\"}', 'deleted', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 4, 'New Launch', 'danger', '2024-09-20 10:05:35', '2024-09-20 10:05:35'),
(99, 1, 'productlabel', '{\"name\":\"SALE 30%\",\"color\":\"#fe9931\",\"submitter\":\"apply\",\"status\":\"published\"}', 'updated', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 3, 'SALE 30%', 'primary', '2024-09-20 10:10:12', '2024-09-20 10:10:12'),
(100, 1, 'of the system', '[]', 'logged out', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '::1', 1, 1, 'Admin Admin', 'info', '2024-09-20 10:20:57', '2024-09-20 10:20:57');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `description` varchar(400) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `author_id` bigint(20) UNSIGNED DEFAULT NULL,
  `author_type` varchar(191) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `icon` varchar(60) DEFAULT NULL,
  `order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_featured` tinyint(4) NOT NULL DEFAULT 0,
  `is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `parent_id`, `description`, `status`, `author_id`, `author_type`, `icon`, `order`, `is_featured`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'Ecommerce', 0, 'Dolorum et deserunt voluptatem ut non enim. Ex qui non sed maxime ea. Ipsam placeat alias culpa nam.', 'published', 1, 'Botble\\ACL\\Models\\User', NULL, 0, 0, 1, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(2, 'Fashion', 0, 'Sint facere inventore dignissimos nam voluptatem deserunt impedit et. Ducimus ut rerum et et qui ut sit. Expedita at aspernatur in. Voluptatem sit quia animi.', 'published', 1, 'Botble\\ACL\\Models\\User', NULL, 0, 1, 0, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(3, 'Electronic', 0, 'Dolor sequi possimus enim ipsam et. Saepe odio omnis doloremque consequuntur beatae fuga placeat.', 'published', 1, 'Botble\\ACL\\Models\\User', NULL, 0, 1, 0, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(4, 'Commercial', 0, 'Facere voluptatem quas et velit aut doloribus sequi. Nihil reiciendis doloremque ullam adipisci dolor fuga sunt. Et omnis veritatis dolore doloremque.', 'published', 1, 'Botble\\ACL\\Models\\User', NULL, 0, 1, 0, '2024-08-05 02:26:36', '2024-08-05 02:26:36');

-- --------------------------------------------------------

--
-- Table structure for table `categories_translations`
--

CREATE TABLE `categories_translations` (
  `lang_code` varchar(20) NOT NULL,
  `categories_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `state_id` bigint(20) UNSIGNED DEFAULT NULL,
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `record_id` varchar(40) DEFAULT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `image` varchar(191) DEFAULT NULL,
  `is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cities_translations`
--

CREATE TABLE `cities_translations` (
  `lang_code` varchar(20) NOT NULL,
  `cities_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `slug` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `subject` varchar(120) DEFAULT NULL,
  `content` longtext NOT NULL,
  `custom_fields` text DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'unread',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `phone`, `address`, `subject`, `content`, `custom_fields`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Electa O\'Hara', 'dhudson@example.org', '+1-540-759-5486', '8354 Mona Tunnel Suite 640\nXanderstad, WA 34602', 'Facere et quis nesciunt minus velit nostrum fuga.', 'Voluptas dolorem magni dolores autem ipsum sed. Sapiente possimus assumenda assumenda expedita. Fuga magni consequatur quis mollitia. Nemo exercitationem nostrum et sit. Autem mollitia consequuntur sint aut odio necessitatibus. Id impedit modi fugiat ut repellendus ipsum temporibus. Eius magni perspiciatis sit tempore neque soluta est. Ipsa debitis voluptatum accusantium quisquam. Omnis amet maiores soluta expedita culpa eos.', NULL, 'read', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(2, 'Alivia Nikolaus', 'kling.rosanna@example.net', '(332) 300-3293', '4736 Halvorson Alley\nBertamouth, LA 96010-9238', 'Consequatur minus delectus dolor ducimus et.', 'Occaecati velit voluptatem magnam. Voluptas quia aspernatur vitae earum iste quisquam corrupti. Doloremque saepe quo molestiae sit molestiae doloremque dolore. Quo dicta magni laborum eius. Exercitationem aut excepturi tenetur quia distinctio adipisci. Et a excepturi alias inventore repudiandae adipisci. Minus nihil exercitationem soluta quia quos dignissimos et esse.', NULL, 'read', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(3, 'Lindsey Bartoletti Sr.', 'hammes.salvador@example.org', '231-724-0967', '7782 Lavinia Hills\nNorth Augustus, TX 20105', 'Omnis quia velit nulla voluptatum eaque.', 'Adipisci est eum non libero ipsam ut. Ut similique provident rerum nisi. Eos impedit magnam illo explicabo. Corporis aperiam eum rerum enim sunt illo. Eum voluptas vitae molestias sapiente et. Aut repellendus officia est. Nobis sint at in qui tenetur. Illum ut est quisquam molestias. Illo culpa quaerat facilis dignissimos quis. In praesentium aliquam aut. Fugiat laudantium nihil quaerat quaerat dolor.', NULL, 'unread', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(4, 'Christopher Champlin III', 'upowlowski@example.net', '701.497.2936', '554 Keebler Canyon\nLake Lempi, IL 40226', 'Labore id minus et.', 'Qui recusandae deleniti officiis ullam et est. Eligendi ut quod pariatur. Quia qui dignissimos et quam. Perspiciatis pariatur consequatur omnis commodi aperiam assumenda magnam. Earum sunt delectus saepe. Rerum molestiae iure consequatur at tenetur. Consequatur aliquid nemo asperiores voluptatum. Qui consectetur numquam vel cupiditate corrupti adipisci illo. Autem atque molestiae dolorem libero. Corrupti eos qui inventore doloremque ut reiciendis. Dolorum et qui eveniet ab nulla et asperiores.', NULL, 'unread', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(5, 'Dr. Terence O\'Connell IV', 'kirk.bahringer@example.org', '+1 (810) 763-5532', '4650 Garnet Mountains\nEarlfort, IA 17778-6753', 'Neque aspernatur ex autem consequatur delectus.', 'Voluptatem sint pariatur excepturi distinctio molestiae. Alias quaerat eos sed id. Placeat tempora cum eaque aut vitae aut. Et odio labore aliquam. Ex veniam placeat quis. Ipsum enim dignissimos voluptas sed porro voluptas iste. Sit enim quo enim esse quis id. Ut natus quidem a dolor. Et ut ipsum distinctio distinctio maxime. Dolore perferendis non sapiente dicta non ut enim cupiditate.', NULL, 'unread', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(6, 'Shania Mertz', 'schuster.theresa@example.org', '(661) 939-4360', '30550 Aurelio Extension\nChristiansentown, VT 09698-2538', 'Dicta asperiores est ut voluptatum molestiae.', 'Dolor deserunt voluptatem libero doloremque id ex ea delectus. Non recusandae ut similique voluptatem ullam. Voluptate eum explicabo quas velit alias architecto eum. Dolor beatae expedita nobis voluptatibus et. Expedita sequi quam eius ut. Voluptatem possimus veniam error nobis. Qui et ea veritatis sequi. Eveniet atque illum fugiat nemo itaque dignissimos sit magnam. In voluptatem eum vel repudiandae neque.', NULL, 'unread', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(7, 'Dolores Hartmann', 'xrunolfsson@example.com', '283-833-9775', '19526 Jamir Rest\nKatlynchester, IN 54826-1130', 'Qui qui nihil doloribus nostrum.', 'Eligendi rerum est voluptatem sit facere quisquam. Rerum sit rerum in explicabo ipsum est. Cumque itaque voluptatem rerum molestias. Ullam labore eaque molestias et non. Et enim quia rem enim et qui. Eum et officiis perspiciatis rerum non. Ut commodi illo animi voluptatem tenetur optio. Ut cum dolorum dolorem odio. Enim quia dolorem omnis aut. Voluptates harum et dolorum et voluptatem.', NULL, 'unread', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(8, 'Arturo Gulgowski I', 'hershel05@example.com', '341.205.3368', '18200 Johns Spurs\nPort Lurlineton, GA 06111', 'Corporis voluptas autem non.', 'Molestiae autem nemo quidem molestiae officiis ab quam. Quam natus sequi est praesentium fugit reprehenderit. Autem explicabo iure consequuntur et illo consectetur. Voluptate accusantium unde consequatur mollitia. Quidem consequatur ut et. Quos reiciendis ipsa velit quia hic maxime. Quibusdam similique provident enim magnam et. Minima est facere magni consequatur sit nostrum. Eum temporibus rerum voluptatem est atque omnis. Dolor eum eveniet accusamus.', NULL, 'unread', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(9, 'Mrs. Cassandre Jacobi', 'braun.carmel@example.com', '580.632.5186', '30773 Stella Inlet\nHaagland, UT 66647-5096', 'Voluptatibus repellendus aperiam quibusdam.', 'Mollitia dolorum harum dolorem suscipit et aut. Quod nesciunt culpa dolorum eligendi. Ad minus aut quidem aut. Vero repellat culpa est ab nisi voluptates. Sequi pariatur eum expedita porro quasi. Rem suscipit earum non est. Iusto illum aspernatur rerum molestias cum consectetur minus. Sequi repudiandae voluptatem sapiente. Aut totam modi a. Est nihil dolorum tempore. Qui velit nostrum vitae quo dicta rerum.', NULL, 'unread', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(10, 'Elenora Kautzer III', 'forrest62@example.net', '+1 (336) 930-6238', '8557 Clementine Island Suite 307\nNorth Gregorio, MD 58663-8352', 'Ipsa autem quam nam dolorum possimus.', 'Sunt enim cum saepe ratione. Minima ratione quibusdam rerum magnam numquam id. Voluptatibus et facere non officiis quos enim aut ut. Dolores blanditiis quis ea quos. Voluptas repellendus exercitationem qui quod earum temporibus. Accusamus voluptas magni perferendis aliquam id optio qui et. Et est enim et eligendi placeat itaque molestias. Nesciunt laudantium non sed aut neque. Et nihil sunt ea. Temporibus earum veritatis eum in quod totam.', NULL, 'read', '2024-08-05 02:26:36', '2024-08-05 02:26:36');

-- --------------------------------------------------------

--
-- Table structure for table `contact_custom_fields`
--

CREATE TABLE `contact_custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(191) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(191) NOT NULL,
  `placeholder` varchar(191) DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 999,
  `status` varchar(191) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_custom_fields_translations`
--

CREATE TABLE `contact_custom_fields_translations` (
  `contact_custom_fields_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(191) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `placeholder` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_custom_field_options`
--

CREATE TABLE `contact_custom_field_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `custom_field_id` bigint(20) UNSIGNED NOT NULL,
  `label` varchar(191) DEFAULT NULL,
  `value` varchar(191) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 999,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_custom_field_options_translations`
--

CREATE TABLE `contact_custom_field_options_translations` (
  `contact_custom_field_options_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(191) NOT NULL,
  `label` varchar(191) DEFAULT NULL,
  `value` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_replies`
--

CREATE TABLE `contact_replies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `message` longtext NOT NULL,
  `contact_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `nationality` varchar(120) DEFAULT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries_translations`
--

CREATE TABLE `countries_translations` (
  `lang_code` varchar(20) NOT NULL,
  `countries_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `nationality` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_widgets`
--

CREATE TABLE `dashboard_widgets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dashboard_widgets`
--

INSERT INTO `dashboard_widgets` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'widget_total_1', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(2, 'widget_total_2', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(3, 'widget_total_3', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(4, 'widget_total_4', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(5, 'widget_total_themes', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(6, 'widget_total_users', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(7, 'widget_total_plugins', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(8, 'widget_total_pages', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(9, 'widget_posts_recent', '2024-09-20 02:14:27', '2024-09-20 02:14:27'),
(10, 'widget_audit_logs', '2024-09-20 02:14:28', '2024-09-20 02:14:28'),
(11, 'widget_ecommerce_report_general', '2024-09-20 02:14:28', '2024-09-20 02:14:28');

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_widget_settings`
--

CREATE TABLE `dashboard_widget_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `settings` text DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `widget_id` bigint(20) UNSIGNED NOT NULL,
  `order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_brands`
--

CREATE TABLE `ec_brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `website` varchar(191) DEFAULT NULL,
  `logo` varchar(191) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `is_featured` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_brands`
--

INSERT INTO `ec_brands` (`id`, `name`, `description`, `website`, `logo`, `status`, `order`, `is_featured`, `created_at`, `updated_at`) VALUES
(1, 'FoodPound', 'New Snacks Release', NULL, 'brands/1.png', 'published', 0, 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(2, 'iTea JSC', 'Happy Tea 100% Organic. From $29.9', NULL, 'brands/2.png', 'published', 1, 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(3, 'Soda Brand', 'Fresh Meat Sausage. BUY 2 GET 1!', NULL, 'brands/3.png', 'published', 2, 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(4, 'Farmart', 'Fresh Meat Sausage. BUY 2 GET 1!', NULL, 'brands/4.png', 'published', 3, 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(5, 'Soda Brand', 'Fresh Meat Sausage. BUY 2 GET 1!', NULL, 'brands/3.png', 'published', 4, 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `ec_brands_translations`
--

CREATE TABLE `ec_brands_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_brands_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_cart`
--

CREATE TABLE `ec_cart` (
  `identifier` varchar(60) NOT NULL,
  `instance` varchar(60) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_currencies`
--

CREATE TABLE `ec_currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `is_prefix_symbol` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `decimals` tinyint(3) UNSIGNED DEFAULT 0,
  `order` int(10) UNSIGNED DEFAULT 0,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `exchange_rate` double NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_currencies`
--

INSERT INTO `ec_currencies` (`id`, `title`, `symbol`, `is_prefix_symbol`, `decimals`, `order`, `is_default`, `exchange_rate`, `created_at`, `updated_at`) VALUES
(1, 'USD', '$', 1, 2, 1, 0, 1, '2024-08-05 02:26:18', '2024-09-20 07:57:19'),
(2, 'EUR', '€', 0, 2, 3, 0, 0.84, '2024-08-05 02:26:18', '2024-09-20 07:57:19'),
(3, 'VND', '₫', 0, 0, 5, 0, 23203, '2024-08-05 02:26:18', '2024-09-20 07:57:19'),
(4, 'NGN', '₦', 1, 2, 7, 0, 895.52, '2024-08-05 02:26:18', '2024-09-20 07:57:20'),
(5, 'AED', 'د.إ', 0, 2, 9, 1, 0.27, '2024-09-20 07:57:20', '2024-09-20 07:57:20');

-- --------------------------------------------------------

--
-- Table structure for table `ec_customers`
--

CREATE TABLE `ec_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `password` varchar(191) NOT NULL,
  `avatar` varchar(191) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `email_verify_token` varchar(120) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'activated',
  `private_notes` text DEFAULT NULL,
  `is_vendor` tinyint(1) NOT NULL DEFAULT 0,
  `vendor_verified_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_customers`
--

INSERT INTO `ec_customers` (`id`, `name`, `email`, `password`, `avatar`, `dob`, `phone`, `remember_token`, `created_at`, `updated_at`, `confirmed_at`, `email_verify_token`, `status`, `private_notes`, `is_vendor`, `vendor_verified_at`) VALUES
(1, 'Test Y Test Y', 'testy@gmail.com', '$2y$12$TZV6cHFgcUUHfwg6tpE./.RtsGqMjhcPg5qeZk8p8JR7WXFtI.7om', NULL, NULL, '1234567890', NULL, '2024-09-20 07:38:03', '2024-09-20 07:38:03', NULL, NULL, 'activated', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ec_customer_addresses`
--

CREATE TABLE `ec_customer_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_customer_addresses`
--

INSERT INTO `ec_customer_addresses` (`id`, `name`, `email`, `phone`, `country`, `state`, `city`, `address`, `customer_id`, `is_default`, `created_at`, `updated_at`, `zip_code`) VALUES
(1, 'Prof. Linwood Pfeffer', 'customer@botble.com', '+16206846985', 'AF', 'Oregon', 'Josieton', '190 Dickinson Springs Apt. 111', 1, 1, '2024-08-05 02:26:19', '2024-08-05 02:26:19', '21005'),
(2, 'Prof. Linwood Pfeffer', 'customer@botble.com', '+12817487546', 'MM', 'Wyoming', 'New Modesto', '5091 McKenzie Valley', 1, 0, '2024-08-05 02:26:19', '2024-08-05 02:26:19', '63933-0519'),
(3, 'Ervin Daugherty II', 'vendor@botble.com', '+17578643219', 'BF', 'West Virginia', 'Adamsville', '89173 Senger Track Suite 768', 2, 1, '2024-08-05 02:26:19', '2024-08-05 02:26:19', '43933'),
(4, 'Ervin Daugherty II', 'vendor@botble.com', '+18163288138', 'GW', 'Kentucky', 'East Jaunita', '57402 Goodwin Plain Apt. 075', 2, 0, '2024-08-05 02:26:19', '2024-08-05 02:26:19', '99372-1319'),
(5, 'Frederik Donnelly', 'ythiel@example.org', '+19293539891', 'AQ', 'Kentucky', 'South Missouri', '4516 Smitham Mountains', 3, 1, '2024-08-05 02:26:19', '2024-08-05 02:26:19', '10580-7794'),
(6, 'Mr. Alfredo Rath', 'kathryne78@example.com', '+19842713340', 'MM', 'Vermont', 'East Angela', '25263 Johns Spurs Suite 151', 4, 1, '2024-08-05 02:26:20', '2024-08-05 02:26:20', '73808-8518'),
(7, 'Mrs. Amya Klocko MD', 'enid63@example.net', '+13374821947', 'FR', 'Ohio', 'Carissamouth', '5401 Hessel Mills Apt. 243', 5, 1, '2024-08-05 02:26:20', '2024-08-05 02:26:20', '76514-8335'),
(8, 'Lonnie McGlynn', 'ugerlach@example.net', '+14054538447', 'GY', 'Oklahoma', 'North Spencerstad', '542 Boyer Valley Suite 238', 6, 1, '2024-08-05 02:26:20', '2024-08-05 02:26:20', '36722'),
(9, 'Prof. Hans Kuvalis Jr.', 'syble21@example.com', '+18572142196', 'PR', 'Vermont', 'Samantachester', '57247 Hazle Stravenue Suite 176', 7, 1, '2024-08-05 02:26:20', '2024-08-05 02:26:20', '39775'),
(10, 'Euna Bechtelar', 'dmoen@example.org', '+12157399625', 'BF', 'Louisiana', 'North Tressie', '527 Eduardo Parkways Apt. 067', 8, 1, '2024-08-05 02:26:21', '2024-08-05 02:26:21', '91358'),
(11, 'Dr. Keven Keebler', 'adonnelly@example.org', '+12186982156', 'VG', 'Washington', 'East Micaelastad', '6728 Goyette Lights', 9, 1, '2024-08-05 02:26:21', '2024-08-05 02:26:21', '23073-5823'),
(12, 'Jermain Thompson', 'lowe.christelle@example.com', '+14357321650', 'ML', 'Connecticut', 'Kuhnmouth', '483 Fred Canyon Suite 632', 10, 1, '2024-08-05 02:26:21', '2024-08-05 02:26:21', '68522-1726'),
(13, 'Test Y Test Y', 'testy@gmail.com', '1234567890', 'AE', 'Dubai', 'Dubai', 'Dubai Dubai', 1, 0, '2024-09-20 07:38:03', '2024-09-20 07:38:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ec_customer_deletion_requests`
--

CREATE TABLE `ec_customer_deletion_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `customer_name` varchar(191) DEFAULT NULL,
  `customer_phone` varchar(191) DEFAULT NULL,
  `customer_email` varchar(191) DEFAULT NULL,
  `token` varchar(191) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'waiting_for_confirmation',
  `reason` text DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_customer_password_resets`
--

CREATE TABLE `ec_customer_password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_customer_recently_viewed_products`
--

CREATE TABLE `ec_customer_recently_viewed_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_customer_used_coupons`
--

CREATE TABLE `ec_customer_used_coupons` (
  `discount_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_discounts`
--

CREATE TABLE `ec_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(120) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total_used` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` double DEFAULT NULL,
  `type` varchar(60) DEFAULT 'coupon',
  `can_use_with_promotion` tinyint(1) NOT NULL DEFAULT 0,
  `discount_on` varchar(20) DEFAULT NULL,
  `product_quantity` int(10) UNSIGNED DEFAULT NULL,
  `type_option` varchar(100) NOT NULL DEFAULT 'amount',
  `target` varchar(100) NOT NULL DEFAULT 'all-orders',
  `min_order_price` decimal(15,2) DEFAULT NULL,
  `apply_via_url` tinyint(1) NOT NULL DEFAULT 0,
  `display_at_checkout` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `store_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_discount_customers`
--

CREATE TABLE `ec_discount_customers` (
  `discount_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_discount_products`
--

CREATE TABLE `ec_discount_products` (
  `discount_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_discount_product_categories`
--

CREATE TABLE `ec_discount_product_categories` (
  `discount_id` bigint(20) UNSIGNED NOT NULL,
  `product_category_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_discount_product_collections`
--

CREATE TABLE `ec_discount_product_collections` (
  `discount_id` bigint(20) UNSIGNED NOT NULL,
  `product_collection_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_flash_sales`
--

CREATE TABLE `ec_flash_sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `end_date` datetime NOT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_flash_sales`
--

INSERT INTO `ec_flash_sales` (`id`, `name`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Winter Sale', '2024-09-04 00:00:00', 'published', '2024-08-05 02:26:32', '2024-08-05 02:26:32');

-- --------------------------------------------------------

--
-- Table structure for table `ec_flash_sales_translations`
--

CREATE TABLE `ec_flash_sales_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_flash_sales_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_flash_sale_products`
--

CREATE TABLE `ec_flash_sale_products` (
  `flash_sale_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `price` double UNSIGNED DEFAULT NULL,
  `quantity` int(10) UNSIGNED DEFAULT NULL,
  `sold` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_flash_sale_products`
--

INSERT INTO `ec_flash_sale_products` (`flash_sale_id`, `product_id`, `price`, `quantity`, `sold`) VALUES
(1, 60, 369.46, 16, 2),
(1, 36, 356.44, 10, 5),
(1, 21, 343.64, 9, 5),
(1, 50, 176.04, 10, 1),
(1, 12, 362.232, 10, 5),
(1, 3, 12.6, 11, 2),
(1, 33, 614.55, 8, 3),
(1, 31, 509.64, 20, 4),
(1, 40, 327.18, 20, 5);

-- --------------------------------------------------------

--
-- Table structure for table `ec_global_options`
--

CREATE TABLE `ec_global_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL COMMENT 'Name of options',
  `option_type` varchar(191) NOT NULL COMMENT 'option type',
  `required` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Checked if this option is required',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_global_options`
--

INSERT INTO `ec_global_options` (`id`, `name`, `option_type`, `required`, `created_at`, `updated_at`) VALUES
(1, 'Warranty', 'Botble\\Ecommerce\\Option\\OptionType\\RadioButton', 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(2, 'RAM', 'Botble\\Ecommerce\\Option\\OptionType\\RadioButton', 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(3, 'CPU', 'Botble\\Ecommerce\\Option\\OptionType\\RadioButton', 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(4, 'HDD', 'Botble\\Ecommerce\\Option\\OptionType\\Dropdown', 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `ec_global_options_translations`
--

CREATE TABLE `ec_global_options_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_global_options_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_global_option_value`
--

CREATE TABLE `ec_global_option_value` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `option_id` bigint(20) UNSIGNED NOT NULL COMMENT 'option id',
  `option_value` tinytext DEFAULT NULL COMMENT 'option value',
  `affect_price` double DEFAULT NULL COMMENT 'value of price of this option affect',
  `order` int(11) NOT NULL DEFAULT 9999,
  `affect_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0. fixed 1. percent',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_global_option_value`
--

INSERT INTO `ec_global_option_value` (`id`, `option_id`, `option_value`, `affect_price`, `order`, `affect_type`, `created_at`, `updated_at`) VALUES
(1, 1, '1 Year', 0, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(2, 1, '2 Year', 10, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(3, 1, '3 Year', 20, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(4, 2, '4GB', 0, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(5, 2, '8GB', 10, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(6, 2, '16GB', 20, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(7, 3, 'Core i5', 0, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(8, 3, 'Core i7', 10, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(9, 3, 'Core i9', 20, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(10, 4, '128GB', 0, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(11, 4, '256GB', 10, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(12, 4, '512GB', 20, 9999, 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `ec_global_option_value_translations`
--

CREATE TABLE `ec_global_option_value_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_global_option_value_id` bigint(20) UNSIGNED NOT NULL,
  `option_value` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_grouped_products`
--

CREATE TABLE `ec_grouped_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_product_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `fixed_qty` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_invoices`
--

CREATE TABLE `ec_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_type` varchar(191) NOT NULL,
  `reference_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) NOT NULL,
  `customer_name` varchar(191) DEFAULT NULL,
  `company_name` varchar(191) DEFAULT NULL,
  `company_logo` varchar(191) DEFAULT NULL,
  `customer_email` varchar(191) DEFAULT NULL,
  `customer_phone` varchar(191) DEFAULT NULL,
  `customer_address` varchar(191) DEFAULT NULL,
  `customer_tax_id` varchar(191) DEFAULT NULL,
  `sub_total` decimal(15,2) UNSIGNED NOT NULL,
  `tax_amount` decimal(15,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `shipping_amount` decimal(15,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(15,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `shipping_option` varchar(60) DEFAULT NULL,
  `shipping_method` varchar(60) NOT NULL DEFAULT 'default',
  `coupon_code` varchar(120) DEFAULT NULL,
  `discount_description` varchar(191) DEFAULT NULL,
  `amount` decimal(15,2) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_invoices`
--

INSERT INTO `ec_invoices` (`id`, `reference_type`, `reference_id`, `code`, `customer_name`, `company_name`, `company_logo`, `customer_email`, `customer_phone`, `customer_address`, `customer_tax_id`, `sub_total`, `tax_amount`, `shipping_amount`, `discount_amount`, `shipping_option`, `shipping_method`, `coupon_code`, `discount_description`, `amount`, `description`, `payment_id`, `status`, `paid_at`, `created_at`, `updated_at`) VALUES
(1, 'Botble\\Ecommerce\\Models\\Order', 1, 'INV-1', 'Test Y Test Y', NULL, NULL, 'testy@gmail.com', '1234567890', 'Dubai Dubai', NULL, 440.00, 22.00, 0.00, 0.00, NULL, 'default', NULL, NULL, 443.00, NULL, 1, 'completed', NULL, '2024-09-20 07:38:25', '2024-09-20 07:38:25');

-- --------------------------------------------------------

--
-- Table structure for table `ec_invoice_items`
--

CREATE TABLE `ec_invoice_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` bigint(20) UNSIGNED NOT NULL,
  `reference_type` varchar(191) NOT NULL,
  `reference_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `qty` int(10) UNSIGNED NOT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `sub_total` decimal(15,2) UNSIGNED NOT NULL,
  `tax_amount` decimal(15,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(15,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `amount` decimal(15,2) UNSIGNED NOT NULL,
  `options` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_invoice_items`
--

INSERT INTO `ec_invoice_items` (`id`, `invoice_id`, `reference_type`, `reference_id`, `name`, `description`, `image`, `qty`, `price`, `sub_total`, `tax_amount`, `discount_amount`, `amount`, `options`, `created_at`, `updated_at`) VALUES
(1, 1, 'Botble\\Ecommerce\\Models\\Product', 25, 'Rose Noir', '', 'products/gardenia-notes.webp', 4, 110.00, 440.00, 22.00, 0.00, 443.00, '\"{\\\"name\\\":\\\"Rose Noir\\\",\\\"image\\\":\\\"products\\\\\\/gardenia-notes.webp\\\",\\\"attributes\\\":\\\" \\\",\\\"taxRate\\\":null,\\\"options\\\":[],\\\"extras\\\":[],\\\"sku\\\":\\\"FM-2443-WEV2\\\",\\\"weight\\\":0,\\\"original_price\\\":110,\\\"product_type\\\":{\\\"value\\\":\\\"physical\\\",\\\"label\\\":\\\"Physical\\\"}}\"', '2024-09-20 07:38:25', '2024-09-20 07:38:25');

-- --------------------------------------------------------

--
-- Table structure for table `ec_options`
--

CREATE TABLE `ec_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL COMMENT 'Name of options',
  `option_type` varchar(191) DEFAULT NULL COMMENT 'option type',
  `product_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 9999,
  `required` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Checked if this option is required',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_options_translations`
--

CREATE TABLE `ec_options_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_options_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_option_value`
--

CREATE TABLE `ec_option_value` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `option_id` bigint(20) UNSIGNED NOT NULL COMMENT 'option id',
  `option_value` tinytext DEFAULT NULL COMMENT 'option value',
  `affect_price` double DEFAULT NULL COMMENT 'value of price of this option affect',
  `order` int(11) NOT NULL DEFAULT 9999,
  `affect_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0. fixed 1. percent',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_option_value_translations`
--

CREATE TABLE `ec_option_value_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_option_value_id` bigint(20) UNSIGNED NOT NULL,
  `option_value` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_orders`
--

CREATE TABLE `ec_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `shipping_option` varchar(60) DEFAULT NULL,
  `shipping_method` varchar(60) NOT NULL DEFAULT 'default',
  `status` varchar(120) NOT NULL DEFAULT 'pending',
  `amount` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT NULL,
  `shipping_amount` decimal(15,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `coupon_code` varchar(120) DEFAULT NULL,
  `discount_amount` decimal(15,2) DEFAULT NULL,
  `sub_total` decimal(15,2) NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `discount_description` varchar(191) DEFAULT NULL,
  `is_finished` tinyint(1) DEFAULT 0,
  `cancellation_reason` varchar(191) DEFAULT NULL,
  `cancellation_reason_description` varchar(191) DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `token` varchar(120) DEFAULT NULL,
  `payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `proof_file` varchar(191) DEFAULT NULL,
  `store_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_orders`
--

INSERT INTO `ec_orders` (`id`, `code`, `user_id`, `shipping_option`, `shipping_method`, `status`, `amount`, `tax_amount`, `shipping_amount`, `description`, `coupon_code`, `discount_amount`, `sub_total`, `is_confirmed`, `discount_description`, `is_finished`, `cancellation_reason`, `cancellation_reason_description`, `completed_at`, `token`, `payment_id`, `created_at`, `updated_at`, `proof_file`, `store_id`) VALUES
(1, '#10000001', 1, NULL, 'default', 'processing', 443.00, 22.00, 0.00, 'sadxsacscdcd', NULL, 0.00, 440.00, 1, NULL, 1, NULL, NULL, NULL, NULL, 1, '2024-09-20 07:38:24', '2024-09-20 07:38:24', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ec_order_addresses`
--

CREATE TABLE `ec_order_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `type` varchar(60) NOT NULL DEFAULT 'shipping_address'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_order_addresses`
--

INSERT INTO `ec_order_addresses` (`id`, `name`, `phone`, `email`, `country`, `state`, `city`, `address`, `order_id`, `zip_code`, `type`) VALUES
(1, 'Test Y Test Y', '1234567890', 'testy@gmail.com', 'AE', 'Dubai', 'Dubai', 'Dubai Dubai', 1, NULL, 'billing_address');

-- --------------------------------------------------------

--
-- Table structure for table `ec_order_histories`
--

CREATE TABLE `ec_order_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(120) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `extras` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_order_histories`
--

INSERT INTO `ec_order_histories` (`id`, `action`, `description`, `user_id`, `order_id`, `extras`, `created_at`, `updated_at`) VALUES
(1, 'create_order_from_website', 'Order was created from website', NULL, 1, NULL, '2024-09-20 07:38:24', '2024-09-20 07:38:24'),
(2, 'create_order', 'New order #10000001', NULL, 1, NULL, '2024-09-20 07:38:24', '2024-09-20 07:38:24'),
(3, 'confirm_order', 'Order was verified by %user_name%', 1, 1, NULL, '2024-09-20 07:38:24', '2024-09-20 07:38:24'),
(4, 'confirm_payment', 'Payment was confirmed (amount $443.00) by %user_name%', 1, 1, NULL, '2024-09-20 07:38:25', '2024-09-20 07:38:25');

-- --------------------------------------------------------

--
-- Table structure for table `ec_order_product`
--

CREATE TABLE `ec_order_product` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) NOT NULL,
  `options` text DEFAULT NULL,
  `product_options` text DEFAULT NULL COMMENT 'product option data',
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(191) NOT NULL,
  `product_image` varchar(191) DEFAULT NULL,
  `weight` double(8,2) DEFAULT 0.00,
  `restock_quantity` int(10) UNSIGNED DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_type` varchar(60) NOT NULL DEFAULT 'physical',
  `times_downloaded` int(11) NOT NULL DEFAULT 0,
  `license_code` char(36) DEFAULT NULL,
  `downloaded_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_order_product`
--

INSERT INTO `ec_order_product` (`id`, `order_id`, `qty`, `price`, `tax_amount`, `options`, `product_options`, `product_id`, `product_name`, `product_image`, `weight`, `restock_quantity`, `created_at`, `updated_at`, `product_type`, `times_downloaded`, `license_code`, `downloaded_at`) VALUES
(1, 1, 4, 110.00, 22.00, '\"{\\\"name\\\":\\\"Rose Noir\\\",\\\"image\\\":\\\"products\\\\\\/gardenia-notes.webp\\\",\\\"attributes\\\":\\\" \\\",\\\"taxRate\\\":null,\\\"options\\\":[],\\\"extras\\\":[],\\\"sku\\\":\\\"FM-2443-WEV2\\\",\\\"weight\\\":0,\\\"original_price\\\":110,\\\"product_type\\\":{\\\"value\\\":\\\"physical\\\",\\\"label\\\":\\\"Physical\\\"}}\"', '[]', 25, 'Rose Noir', 'products/gardenia-notes.webp', 0.00, 0, '2024-09-20 07:38:25', '2024-09-20 07:38:25', 'physical', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ec_order_referrals`
--

CREATE TABLE `ec_order_referrals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ip` varchar(39) DEFAULT NULL,
  `landing_domain` varchar(191) DEFAULT NULL,
  `landing_page` varchar(191) DEFAULT NULL,
  `landing_params` varchar(191) DEFAULT NULL,
  `referral` varchar(191) DEFAULT NULL,
  `gclid` varchar(191) DEFAULT NULL,
  `fclid` varchar(191) DEFAULT NULL,
  `utm_source` varchar(191) DEFAULT NULL,
  `utm_campaign` varchar(191) DEFAULT NULL,
  `utm_medium` varchar(191) DEFAULT NULL,
  `utm_term` varchar(191) DEFAULT NULL,
  `utm_content` varchar(191) DEFAULT NULL,
  `referrer_url` text DEFAULT NULL,
  `referrer_domain` varchar(191) DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_order_returns`
--

CREATE TABLE `ec_order_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Order ID',
  `store_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Store ID',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Customer ID',
  `reason` text DEFAULT NULL COMMENT 'Reason return order',
  `order_status` varchar(191) DEFAULT NULL COMMENT 'Order current status',
  `return_status` varchar(191) NOT NULL COMMENT 'Return status',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_order_return_histories`
--

CREATE TABLE `ec_order_return_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_return_id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(191) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `reason` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_order_return_items`
--

CREATE TABLE `ec_order_return_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_return_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Order return id',
  `order_product_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Order product id',
  `product_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Product id',
  `product_name` varchar(191) NOT NULL,
  `product_image` varchar(191) DEFAULT NULL,
  `qty` int(11) NOT NULL COMMENT 'Quantity return',
  `price` decimal(15,2) NOT NULL COMMENT 'Price Product',
  `reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `refund_amount` decimal(12,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_order_tax_information`
--

CREATE TABLE `ec_order_tax_information` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(120) NOT NULL,
  `company_address` varchar(191) NOT NULL,
  `company_tax_code` varchar(20) NOT NULL,
  `company_email` varchar(60) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_products`
--

CREATE TABLE `ec_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `images` text DEFAULT NULL,
  `video_media` text DEFAULT NULL,
  `sku` varchar(191) DEFAULT NULL,
  `order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `quantity` int(10) UNSIGNED DEFAULT NULL,
  `allow_checkout_when_out_of_stock` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `with_storehouse_management` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `is_featured` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_variation` tinyint(4) NOT NULL DEFAULT 0,
  `sale_type` tinyint(4) NOT NULL DEFAULT 0,
  `price` double UNSIGNED DEFAULT NULL,
  `sale_price` double UNSIGNED DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `length` double(8,2) DEFAULT NULL,
  `wide` double(8,2) DEFAULT NULL,
  `height` double(8,2) DEFAULT NULL,
  `weight` double(8,2) DEFAULT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `views` bigint(20) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stock_status` varchar(191) DEFAULT 'in_stock',
  `created_by_id` bigint(20) UNSIGNED DEFAULT 0,
  `created_by_type` varchar(191) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `image` varchar(191) DEFAULT NULL,
  `product_type` varchar(60) DEFAULT 'physical',
  `barcode` varchar(50) DEFAULT NULL,
  `cost_per_item` double DEFAULT NULL,
  `generate_license_code` tinyint(1) NOT NULL DEFAULT 0,
  `minimum_order_quantity` int(10) UNSIGNED DEFAULT 0,
  `maximum_order_quantity` int(10) UNSIGNED DEFAULT 0,
  `notify_attachment_updated` tinyint(1) NOT NULL DEFAULT 0,
  `store_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_by` bigint(20) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_products`
--

INSERT INTO `ec_products` (`id`, `name`, `description`, `content`, `status`, `images`, `video_media`, `sku`, `order`, `quantity`, `allow_checkout_when_out_of_stock`, `with_storehouse_management`, `is_featured`, `brand_id`, `is_variation`, `sale_type`, `price`, `sale_price`, `start_date`, `end_date`, `length`, `wide`, `height`, `weight`, `tax_id`, `views`, `created_at`, `updated_at`, `stock_status`, `created_by_id`, `created_by_type`, `image`, `product_type`, `barcode`, `cost_per_item`, `generate_license_code`, `minimum_order_quantity`, `maximum_order_quantity`, `notify_attachment_updated`, `store_id`, `approved_by`) VALUES
(1, 'Bidun Esam', '', '', 'published', '[\"products\\/gardenia-notes.webp\",\"products\\/gardenia-notes.webp\"]', '\"[]\"', 'FM-2443-V8KM', 0, 1000, 0, 1, 0, NULL, 0, 0, 60, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 03:41:50', '2024-09-20 03:42:18', 'in_stock', 1, 'Botble\\ACL\\Models\\User', 'products/gardenia-notes.webp', 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(3, 'Kaaf', '', '', 'published', '[\"products\\/kaaf-notes.webp\",\"products\\/kaaf-notes.webp\"]', '\"[]\"', 'FM-2443-FEJA', 0, 1000, 0, 1, 0, NULL, 0, 0, 90, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 03:52:55', '2024-09-20 03:54:00', 'in_stock', 1, 'Botble\\ACL\\Models\\User', 'products/kaaf-notes.webp', 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(4, 'Laathani', '', '', 'published', '[\"products\\/laathani-web.webp\"]', '\"[]\"', 'FM-2443-4T2B', 0, 1000, 0, 1, 0, NULL, 0, 0, 175, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 03:57:35', '2024-09-20 10:02:07', 'in_stock', 1, 'Botble\\ACL\\Models\\User', 'products/laathani-web.webp', 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(5, 'Oud &amp; Roses', '', '', 'published', '[\"products\\/musk-ahmed.webp\"]', '\"[]\"', 'FM-2443-VPPG', 0, 10, 0, 1, 0, NULL, 0, 0, 135, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:07:24', '2024-09-20 04:41:53', 'in_stock', 1, 'Botble\\ACL\\Models\\User', 'products/musk-ahmed.webp', 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(6, 'Marj', '', '', 'published', '[\"products\\/maani.webp\"]', '\"[]\"', 'FM-2443-Q41Z', 0, 10, 0, 1, 0, NULL, 0, 0, 165, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:08:22', '2024-09-20 04:41:32', 'in_stock', 1, 'Botble\\ACL\\Models\\User', 'products/maani.webp', 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(7, 'Dehn Al Oud Combodi Omani', '', '', 'published', '[\"products\\/gardenia-notes.webp\"]', '\"[]\"', 'FM-2443-NSTM', 0, 1000, 0, 1, 0, NULL, 0, 0, 55, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:11:29', '2024-09-20 04:11:29', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(8, 'Dehn Al Oudh Mubakhar', '', '', 'published', '[\"products\\/gardenia-notes.webp\"]', '\"[]\"', 'FM-2443-DCAX', 0, 1000, 0, 1, 0, NULL, 0, 0, 75, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:12:36', '2024-09-20 04:12:36', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(9, 'Ghawi', '', '', 'published', '[\"products\\/oud-and-lavender.webp\"]', '\"[]\"', 'FM-2443-CTWA', 0, 1000, 0, 1, 0, NULL, 0, 0, 131.25, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:13:32', '2024-09-20 04:13:32', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(10, 'Zukhruf', '', '', 'published', '[\"products\\/oud-and-lavender.webp\"]', '\"[]\"', 'FM-2443-DZCY', 0, 1000, 0, 1, 0, NULL, 0, 0, 37, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:14:22', '2024-09-20 04:14:22', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(11, 'Bakhoor Baiti 10 tabs', '', '', 'published', '[\"products\\/gardenia-notes.webp\"]', '\"[]\"', 'FM-2443-H9AK', 0, 1000, 0, 1, 0, NULL, 0, 0, 50, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:16:16', '2024-09-20 04:16:16', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(12, 'Bakhoor Oud &amp; Roses', '', '', 'published', '[\"products\\/gardenia-notes.webp\"]', '\"[]\"', 'FM-2443-WEGY', 0, 1000, 0, 1, 0, NULL, 0, 0, 110, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:16:52', '2024-09-20 04:16:52', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(13, 'Maria Oud Mubakhar 36 Grams', '', '', 'published', '[\"products\\/kaaf-notes.webp\"]', '\"[]\"', 'FM-2443-HOPL', 0, 1000, 0, 1, 0, NULL, 0, 0, 40, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:17:56', '2024-09-20 04:17:57', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(14, 'Maria Oud Mubakhar 58 Grams', '', '', 'published', '[\"products\\/oud-and-lavender.webp\"]', '\"[]\"', 'FM-2443-2D7O', 0, 1000, 0, 1, 0, NULL, 0, 0, 70, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:21:52', '2024-09-20 04:21:52', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(15, 'Air Freshener Oud &amp; Roses', '', '', 'published', '[\"products\\/maani.webp\"]', '\"[]\"', 'FM-2443-8LIO', 0, 1000, 0, 1, 0, NULL, 0, 0, 29.4, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:23:03', '2024-09-20 04:23:03', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(16, 'Air Freshener Oud Lavender', '', '', 'published', '[\"products\\/musk-ahmed.webp\"]', '\"[]\"', 'FM-2443-XL6A', 0, 1000, 0, 1, 0, NULL, 0, 0, 29.4, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:23:45', '2024-09-20 04:23:57', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(17, 'Oud &amp; Roses Body Gel', '', '', 'published', '[\"products\\/gardenia-notes.webp\"]', '\"[]\"', 'FM-2443-NLVW', 0, 1000, 0, 1, 0, NULL, 0, 0, 26.25, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:31:12', '2024-09-20 04:31:12', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(18, 'Supreme Body Gel', '', '', 'published', '[\"products\\/kaaf-notes.webp\"]', '\"[]\"', 'FM-2443-B6DH', 0, 1000, 0, 1, 0, NULL, 0, 0, 26.25, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:31:50', '2024-09-20 04:31:50', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(19, 'Oud &amp; Roses Collection', '', '', 'published', '[\"products\\/oud-and-lavender.webp\"]', '\"[]\"', 'FM-2443-VDQQ', 0, 1000, 0, 1, 0, NULL, 0, 0, 246.33, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:33:46', '2024-09-20 04:33:46', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(20, 'Little Hearts Collection', '', '', 'published', '[\"products\\/musk-ahmed.webp\"]', '\"[]\"', 'FM-2443-RYLI', 0, 1000, 0, 1, 0, NULL, 0, 0, 89.25, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:34:18', '2024-09-20 04:34:18', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(21, 'Bakhoor Bushra 10 Tabs', '', '', 'published', '[\"products\\/oud-and-lavender.webp\"]', '\"[]\"', 'FM-2443-LNPU', 0, 1000, 0, 1, 0, NULL, 0, 0, 50, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:35:19', '2024-09-20 04:35:19', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(22, 'Summer Collection 1', '', '', 'published', '[\"products\\/kaaf-notes.webp\"]', '\"[]\"', 'FM-2443-F6FK', 0, 1000, 0, 1, 0, NULL, 0, 0, 416.5, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 04:37:26', '2024-09-20 04:37:47', 'in_stock', 1, 'Botble\\ACL\\Models\\User', 'products/summer-collection-1-300x400.jpg', 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(23, 'Test Prod', '', '', 'published', '[\"products\\/oud-and-lavender.webp\"]', '\"[]\"', 'FM-2443-NWVV', 0, 10, 0, 1, 0, NULL, 0, 0, 100, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 06:53:49', '2024-09-20 10:01:43', 'in_stock', 1, 'Botble\\ACL\\Models\\User', 'products/oud-and-lavender.webp', 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(25, 'Rose Noir', '', '', 'published', '[\"products\\/gardenia-notes.webp\",\"products\\/gardenia-notes.webp\"]', '\"[]\"', 'FM-2443-WEV2', 0, 6, 0, 1, 0, NULL, 0, 0, 110, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 07:27:56', '2024-09-20 07:38:25', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(26, 'Oud Lavender', '', '', 'published', '[\"products\\/oud-and-lavender.webp\",\"products\\/oud-and-lavender.webp\"]', '\"[]\"', 'FM-2443-0GDA', 0, 1000, 0, 1, 0, NULL, 0, 0, 135, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 07:29:11', '2024-09-20 07:29:30', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0),
(27, 'Oud Classic', '', '', 'published', '[\"products\\/gardenia-notes.webp\",\"products\\/gardenia-notes.webp\"]', '\"[]\"', 'FM-2443-QCXT', 0, 1000, 0, 1, 0, NULL, 0, 0, 60, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, 0, '2024-09-20 07:30:54', '2024-09-20 07:30:54', 'in_stock', 1, 'Botble\\ACL\\Models\\User', NULL, 'physical', NULL, 0, 0, 0, 0, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ec_products_translations`
--

CREATE TABLE `ec_products_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_products_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `content` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_attributes`
--

CREATE TABLE `ec_product_attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `attribute_set_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_attributes_translations`
--

CREATE TABLE `ec_product_attributes_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_attributes_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_attribute_sets`
--

CREATE TABLE `ec_product_attribute_sets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `display_layout` varchar(191) NOT NULL DEFAULT 'swatch_dropdown',
  `is_searchable` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `is_comparable` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `is_use_in_product_listing` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `use_image_from_product_variation` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_attribute_sets_translations`
--

CREATE TABLE `ec_product_attribute_sets_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_attribute_sets_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_categories`
--

CREATE TABLE `ec_product_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `description` mediumtext DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `image` varchar(191) DEFAULT NULL,
  `is_featured` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `icon_image` varchar(191) DEFAULT NULL COMMENT 'menu_image',
  `menu_image2` varchar(191) DEFAULT NULL,
  `video` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_product_categories`
--

INSERT INTO `ec_product_categories` (`id`, `name`, `parent_id`, `description`, `status`, `order`, `image`, `is_featured`, `created_at`, `updated_at`, `icon`, `icon_image`, `menu_image2`, `video`) VALUES
(1, 'Eau De Parfum', 0, NULL, 'published', 0, 'product-categories/marj-banner-1.jpg', 0, '2024-09-20 02:18:03', '2024-09-20 03:06:15', '0', 'product-categories/marj.jpg', 'product-categories/laathani.jpg', 'product-categories/SHOP-VIDEO-1.mp4'),
(2, 'Concentrated Parfum', 0, NULL, 'published', 1, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:18:46', '2024-09-20 03:06:15', '0', 'product-categories/bidun-esam-oil.jpg', 'product-categories/dehn-al-oud-banner.jpg', 'product-categories/laathani-short.mp4'),
(3, 'Dakhoon', 0, NULL, 'published', 2, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:19:05', '2024-09-20 03:06:15', '0', 'product-categories/oud-mattar-maliki.jpg', 'product-categories/oud-amber-section.jpg', 'product-categories/SHOP-VIDEO-1.mp4'),
(4, 'Gift Sets', 0, NULL, 'published', 3, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:19:23', '2024-09-20 03:06:15', '0', 'product-categories/little-hearts.jpg', 'product-categories/oud-roses-giftset.jpg', NULL),
(5, 'Gel', 0, NULL, 'published', 4, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:19:41', '2024-09-20 03:06:15', '0', 'product-categories/oud-roses-bodygel.jpg', 'product-categories/bodygel-banner.jpg', 'product-categories/laathani-short.mp4'),
(6, 'Hair Mist', 0, NULL, 'published', 5, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:20:10', '2024-09-20 03:07:33', '0', NULL, NULL, NULL),
(7, 'Collections', 0, NULL, 'published', 6, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:20:29', '2024-09-20 03:06:15', '0', 'product-categories/oud-roses-collection-1.jpg', 'product-categories/little-hearts-collection-2.jpg', 'product-categories/SHOP-VIDEO-1.mp4'),
(8, 'Oriental Fragrance', 1, NULL, 'published', 1, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:26:33', '2024-09-20 03:06:15', '0', NULL, NULL, 'product-categories/Ahmed-Perfume-Street-View.mp4'),
(9, 'Occidental Fragrance', 1, NULL, 'published', 0, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:26:52', '2024-09-20 03:06:15', '0', NULL, NULL, 'product-categories/SHOP-VIDEO-1.mp4'),
(10, 'Dehn Al Oud', 2, NULL, 'published', 1, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:27:27', '2024-09-20 03:06:15', '0', NULL, NULL, 'product-categories/laathani-short.mp4'),
(11, 'Concentrated Oil', 2, NULL, 'published', 0, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:27:48', '2024-09-20 03:06:15', '0', NULL, NULL, 'product-categories/video-animation.mp4'),
(12, 'Bakhoor', 3, NULL, 'published', 0, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:28:10', '2024-09-20 03:06:19', '0', NULL, NULL, 'product-categories/SHOP-VIDEO-1.mp4'),
(13, 'Natural Oud', 3, NULL, 'published', 1, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:28:38', '2024-09-20 03:06:25', '0', NULL, NULL, 'product-categories/laathani-short.mp4'),
(14, 'Oud Ma\'attar', 3, NULL, 'published', 2, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:29:24', '2024-09-20 03:06:32', '0', NULL, NULL, 'product-categories/Ahmed-Perfume-Street-View.mp4'),
(15, 'Air Freshener', 3, NULL, 'published', 3, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:29:47', '2024-09-20 03:06:40', '0', NULL, NULL, 'product-categories/video-animation.mp4'),
(16, 'Gift Sets', 4, NULL, 'published', 0, NULL, 0, '2024-09-20 02:30:11', '2024-09-20 03:06:15', '0', NULL, NULL, NULL),
(17, 'Body Gel', 5, NULL, 'published', 0, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:30:44', '2024-09-20 03:07:20', '0', NULL, NULL, 'product-categories/laathani-short.mp4'),
(18, 'Premium Collection', 7, NULL, 'published', 2, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:31:12', '2024-09-20 03:07:52', '0', NULL, NULL, 'product-categories/SHOP-VIDEO-1.mp4'),
(19, 'Online Exclusive Sets', 7, NULL, 'published', 1, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:31:34', '2024-09-20 03:07:47', '0', NULL, NULL, 'product-categories/Ahmed-Perfume-Street-View.mp4'),
(20, 'Summer Collection', 7, NULL, 'published', 0, 'product-categories/laathani-banner.webp', 0, '2024-09-20 02:31:59', '2024-09-20 03:07:42', '0', NULL, NULL, 'product-categories/video-animation.mp4');

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_categories_translations`
--

CREATE TABLE `ec_product_categories_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_categories_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_categorizables`
--

CREATE TABLE `ec_product_categorizables` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `reference_id` bigint(20) UNSIGNED NOT NULL,
  `reference_type` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_category_product`
--

CREATE TABLE `ec_product_category_product` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_product_category_product`
--

INSERT INTO `ec_product_category_product` (`category_id`, `product_id`) VALUES
(1, 1),
(8, 1),
(1, 3),
(8, 3),
(1, 4),
(2, 4),
(3, 4),
(4, 4),
(5, 4),
(6, 4),
(7, 4),
(8, 4),
(9, 4),
(10, 4),
(11, 4),
(12, 4),
(14, 4),
(15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 4),
(20, 4),
(1, 5),
(9, 5),
(1, 6),
(9, 6),
(2, 7),
(10, 7),
(2, 8),
(10, 8),
(2, 9),
(11, 9),
(2, 10),
(11, 10),
(3, 11),
(12, 11),
(3, 12),
(12, 12),
(3, 13),
(14, 13),
(3, 14),
(14, 14),
(3, 15),
(15, 15),
(3, 16),
(15, 16),
(5, 17),
(17, 17),
(5, 18),
(17, 18),
(7, 19),
(18, 19),
(7, 20),
(18, 20),
(7, 21),
(19, 21),
(7, 22),
(20, 22),
(3, 23),
(13, 23),
(9, 25),
(9, 26),
(9, 27);

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_collections`
--

CREATE TABLE `ec_product_collections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_featured` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_product_collections`
--

INSERT INTO `ec_product_collections` (`id`, `name`, `slug`, `description`, `image`, `status`, `created_at`, `updated_at`, `is_featured`) VALUES
(1, 'New Launch', 'new-launch', NULL, NULL, 'published', '2024-08-05 02:26:18', '2024-09-20 09:40:46', 0),
(2, 'Best Sellers', 'best-sellers', NULL, NULL, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18', 0),
(3, 'Special Offer', 'special-offer', NULL, NULL, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_collections_translations`
--

CREATE TABLE `ec_product_collections_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_collections_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_collection_products`
--

CREATE TABLE `ec_product_collection_products` (
  `product_collection_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_product_collection_products`
--

INSERT INTO `ec_product_collection_products` (`product_collection_id`, `product_id`) VALUES
(1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_cross_sale_relations`
--

CREATE TABLE `ec_product_cross_sale_relations` (
  `from_product_id` bigint(20) UNSIGNED NOT NULL,
  `to_product_id` bigint(20) UNSIGNED NOT NULL,
  `is_variant` tinyint(1) NOT NULL DEFAULT 0,
  `price` decimal(15,2) DEFAULT 0.00,
  `price_type` varchar(191) NOT NULL DEFAULT 'fixed',
  `apply_to_all_variations` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_files`
--

CREATE TABLE `ec_product_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `url` varchar(400) DEFAULT NULL,
  `extras` mediumtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_labels`
--

CREATE TABLE `ec_product_labels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `color` varchar(120) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_product_labels`
--

INSERT INTO `ec_product_labels` (`id`, `name`, `color`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Hot', '#d71e2d', 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(2, 'New', '#02856e', 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(3, 'SALE 30%', '#43930b', 'published', '2024-08-05 02:26:18', '2024-09-20 10:10:12');

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_labels_translations`
--

CREATE TABLE `ec_product_labels_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_labels_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_label_products`
--

CREATE TABLE `ec_product_label_products` (
  `product_label_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_product_label_products`
--

INSERT INTO `ec_product_label_products` (`product_label_id`, `product_id`) VALUES
(3, 23);

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_related_relations`
--

CREATE TABLE `ec_product_related_relations` (
  `from_product_id` bigint(20) UNSIGNED NOT NULL,
  `to_product_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_tags`
--

CREATE TABLE `ec_product_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_tags_translations`
--

CREATE TABLE `ec_product_tags_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_tags_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_tag_product`
--

CREATE TABLE `ec_product_tag_product` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `tag_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_up_sale_relations`
--

CREATE TABLE `ec_product_up_sale_relations` (
  `from_product_id` bigint(20) UNSIGNED NOT NULL,
  `to_product_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_variations`
--

CREATE TABLE `ec_product_variations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `configurable_product_id` bigint(20) UNSIGNED NOT NULL,
  `is_default` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_variation_items`
--

CREATE TABLE `ec_product_variation_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `attribute_id` bigint(20) UNSIGNED NOT NULL,
  `variation_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_views`
--

CREATE TABLE `ec_product_views` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `views` int(11) NOT NULL DEFAULT 1,
  `date` date NOT NULL DEFAULT '2024-08-05'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_product_with_attribute_set`
--

CREATE TABLE `ec_product_with_attribute_set` (
  `attribute_set_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_reviews`
--

CREATE TABLE `ec_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_name` varchar(191) DEFAULT NULL,
  `customer_email` varchar(191) DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `star` double(8,2) NOT NULL,
  `comment` text NOT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `images` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_review_replies`
--

CREATE TABLE `ec_review_replies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `review_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_shared_wishlists`
--

CREATE TABLE `ec_shared_wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) NOT NULL,
  `product_ids` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_shipments`
--

CREATE TABLE `ec_shipments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `weight` double(8,2) DEFAULT 0.00,
  `shipment_id` varchar(120) DEFAULT NULL,
  `rate_id` varchar(120) DEFAULT NULL,
  `note` varchar(120) DEFAULT NULL,
  `status` varchar(120) NOT NULL DEFAULT 'pending',
  `cod_amount` decimal(15,2) DEFAULT 0.00,
  `cod_status` varchar(60) NOT NULL DEFAULT 'pending',
  `cross_checking_status` varchar(60) NOT NULL DEFAULT 'pending',
  `price` decimal(15,2) DEFAULT 0.00,
  `store_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tracking_id` varchar(191) DEFAULT NULL,
  `shipping_company_name` varchar(191) DEFAULT NULL,
  `tracking_link` varchar(191) DEFAULT NULL,
  `estimate_date_shipped` datetime DEFAULT NULL,
  `date_shipped` datetime DEFAULT NULL,
  `label_url` text DEFAULT NULL,
  `metadata` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_shipment_histories`
--

CREATE TABLE `ec_shipment_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(120) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shipment_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_type` varchar(191) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_shipping`
--

CREATE TABLE `ec_shipping` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `country` varchar(120) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_shipping`
--

INSERT INTO `ec_shipping` (`id`, `title`, `country`, `created_at`, `updated_at`) VALUES
(1, 'All', NULL, '2024-08-05 02:26:21', '2024-08-05 02:26:21');

-- --------------------------------------------------------

--
-- Table structure for table `ec_shipping_rules`
--

CREATE TABLE `ec_shipping_rules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `shipping_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(24) DEFAULT 'based_on_price',
  `from` decimal(15,2) DEFAULT 0.00,
  `to` decimal(15,2) DEFAULT 0.00,
  `price` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_shipping_rules`
--

INSERT INTO `ec_shipping_rules` (`id`, `name`, `shipping_id`, `type`, `from`, `to`, `price`, `created_at`, `updated_at`) VALUES
(1, 'Free delivery', 1, 'based_on_price', 1000.00, NULL, 0.00, '2024-08-05 02:26:21', '2024-08-05 02:26:21'),
(2, 'Flat Rate', 1, 'based_on_price', 0.00, NULL, 20.00, '2024-08-05 02:26:21', '2024-08-05 02:26:21'),
(3, 'Local Pickup', 1, 'based_on_price', 0.00, NULL, 0.00, '2024-08-05 02:26:21', '2024-08-05 02:26:21');

-- --------------------------------------------------------

--
-- Table structure for table `ec_shipping_rule_items`
--

CREATE TABLE `ec_shipping_rule_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shipping_rule_id` bigint(20) UNSIGNED NOT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `adjustment_price` decimal(15,2) DEFAULT 0.00,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_store_locators`
--

CREATE TABLE `ec_store_locators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(191) NOT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `is_shipping_location` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ec_store_locators`
--

INSERT INTO `ec_store_locators` (`id`, `name`, `email`, `phone`, `address`, `country`, `state`, `city`, `is_primary`, `is_shipping_location`, `created_at`, `updated_at`, `zip_code`) VALUES
(1, 'Farmart', 'sales@botble.com', '1800979769', '502 New Street', 'AU', 'Brighton VIC', 'Brighton VIC', 1, 1, '2024-08-05 02:26:32', '2024-08-05 02:26:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ec_taxes`
--

CREATE TABLE `ec_taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `percentage` double(8,6) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_tax_products`
--

CREATE TABLE `ec_tax_products` (
  `tax_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_tax_rules`
--

CREATE TABLE `ec_tax_rules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tax_id` bigint(20) UNSIGNED NOT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `percentage` double(8,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ec_wish_lists`
--

CREATE TABLE `ec_wish_lists` (
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`, `category_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'What Shipping Methods Are Available?', 'Ex Portland Pitchfork irure mustache. Eutra fap before they sold out literally. Aliquip ugh bicycle rights actually mlkshk, seitan squid craft beer tempor.', 1, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(2, 'Do You Ship Internationally?', 'Hoodie tote bag mixtape tofu. Typewriter jean shorts wolf quinoa, messenger bag organic freegan cray.', 1, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(3, 'How Long Will It Take To Get My Package?', 'Swag slow-carb quinoa VHS typewriter pork belly brunch, paleo single-origin coffee Wes Anderson. Flexitarian Pitchfork forage, literally paleo fap pour-over. Wes Anderson Pinterest YOLO fanny pack meggings, deep v XOXO chambray sustainable slow-carb raw denim church-key fap chillwave Etsy. +1 typewriter kitsch, American Apparel tofu Banksy Vice.', 1, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(4, 'What Payment Methods Are Accepted?', 'Fashion axe DIY jean shorts, swag kale chips meh polaroid kogi butcher Wes Anderson chambray next level semiotics gentrify yr. Voluptate photo booth fugiat Vice. Austin sed Williamsburg, ea labore raw denim voluptate cred proident mixtape excepteur mustache. Twee chia photo booth readymade food truck, hoodie roof party swag keytar PBR DIY.', 2, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(5, 'Is Buying On-Line Safe?', 'Art party authentic freegan semiotics jean shorts chia cred. Neutra Austin roof party Brooklyn, synth Thundercats swag 8-bit photo booth. Plaid letterpress leggings craft beer meh ethical Pinterest.', 2, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(6, 'How do I place an Order?', 'Keytar cray slow-carb, Godard banh mi salvia pour-over. Slow-carb Odd Future seitan normcore. Master cleanse American Apparel gentrify flexitarian beard slow-carb next level. Raw denim polaroid paleo farm-to-table, put a bird on it lo-fi tattooed Wes Anderson Pinterest letterpress. Fingerstache McSweeney’s pour-over, letterpress Schlitz photo booth master cleanse bespoke hashtag chillwave gentrify.', 3, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(7, 'How Can I Cancel Or Change My Order?', 'Plaid letterpress leggings craft beer meh ethical Pinterest. Art party authentic freegan semiotics jean shorts chia cred. Neutra Austin roof party Brooklyn, synth Thundercats swag 8-bit photo booth.', 3, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(8, 'Do I need an account to place an order?', 'Thundercats swag 8-bit photo booth. Plaid letterpress leggings craft beer meh ethical Pinterest. Twee chia photo booth readymade food truck, hoodie roof party swag keytar PBR DIY. Cray ugh 3 wolf moon fap, fashion axe irony butcher cornhole typewriter chambray VHS banjo street art.', 3, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(9, 'How Do I Track My Order?', 'Keytar cray slow-carb, Godard banh mi salvia pour-over. Slow-carb @Odd Future seitan normcore. Master cleanse American Apparel gentrify flexitarian beard slow-carb next level.', 3, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(10, 'How Can I Return a Product?', 'Kale chips Truffaut Williamsburg, hashtag fixie Pinterest raw denim c hambray drinking vinegar Carles street art Bushwick gastropub. Wolf Tumblr paleo church-key. Plaid food truck Echo Park YOLO bitters hella, direct trade Thundercats leggings quinoa before they sold out. You probably haven’t heard of them wayfarers authentic umami drinking vinegar Pinterest Cosby sweater, fingerstache fap High Life.', 3, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `faqs_translations`
--

CREATE TABLE `faqs_translations` (
  `lang_code` varchar(20) NOT NULL,
  `faqs_id` bigint(20) UNSIGNED NOT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_categories`
--

CREATE TABLE `faq_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faq_categories`
--

INSERT INTO `faq_categories` (`id`, `name`, `order`, `status`, `created_at`, `updated_at`, `description`) VALUES
(1, 'SHIPPING', 0, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL),
(2, 'PAYMENT', 1, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL),
(3, 'ORDER &amp; RETURNS', 2, 'published', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `faq_categories_translations`
--

CREATE TABLE `faq_categories_translations` (
  `lang_code` varchar(20) NOT NULL,
  `faq_categories_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `lang_id` bigint(20) UNSIGNED NOT NULL,
  `lang_name` varchar(120) NOT NULL,
  `lang_locale` varchar(20) NOT NULL,
  `lang_code` varchar(20) NOT NULL,
  `lang_flag` varchar(20) DEFAULT NULL,
  `lang_is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lang_order` int(11) NOT NULL DEFAULT 0,
  `lang_is_rtl` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`lang_id`, `lang_name`, `lang_locale`, `lang_code`, `lang_flag`, `lang_is_default`, `lang_order`, `lang_is_rtl`) VALUES
(1, 'English', 'en', 'en_US', 'us', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `language_meta`
--

CREATE TABLE `language_meta` (
  `lang_meta_id` bigint(20) UNSIGNED NOT NULL,
  `lang_meta_code` varchar(20) DEFAULT NULL,
  `lang_meta_origin` varchar(32) NOT NULL,
  `reference_id` bigint(20) UNSIGNED NOT NULL,
  `reference_type` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `language_meta`
--

INSERT INTO `language_meta` (`lang_meta_id`, `lang_meta_code`, `lang_meta_origin`, `reference_id`, `reference_type`) VALUES
(1, 'en_US', '842a27692368fb12e32c2e795a49d533', 1, 'Botble\\SimpleSlider\\Models\\SimpleSlider'),
(2, 'en_US', '1e77c29a1166a2bf79496937a712ad7e', 1, 'Botble\\Menu\\Models\\MenuLocation'),
(3, 'en_US', '52cc5e4f28a923d2cb8c358454e63312', 1, 'Botble\\Menu\\Models\\Menu'),
(4, 'en_US', 'a6262f18db968eaa64e1ea36588a1e16', 2, 'Botble\\Menu\\Models\\MenuLocation'),
(5, 'en_US', 'a809793ba8a47dfd17550149325c9eeb', 2, 'Botble\\Menu\\Models\\Menu'),
(6, 'en_US', 'b1443d4bdb33ab3b286c938ece5705ac', 3, 'Botble\\Menu\\Models\\Menu'),
(7, 'en_US', '3e842cf2a08647f3bf07c031bd83c734', 4, 'Botble\\Menu\\Models\\Menu'),
(8, 'en_US', '0aede3d528b185ae4d24cc11f6da5bca', 5, 'Botble\\Menu\\Models\\Menu');

-- --------------------------------------------------------

--
-- Table structure for table `media_files`
--

CREATE TABLE `media_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `alt` varchar(191) DEFAULT NULL,
  `folder_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `mime_type` varchar(120) NOT NULL,
  `size` int(11) NOT NULL,
  `url` varchar(191) NOT NULL,
  `options` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `visibility` varchar(191) NOT NULL DEFAULT 'public'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media_files`
--

INSERT INTO `media_files` (`id`, `user_id`, `name`, `alt`, `folder_id`, `mime_type`, `size`, `url`, `options`, `created_at`, `updated_at`, `deleted_at`, `visibility`) VALUES
(1, 0, '1', '1', 1, 'image/png', 5403, 'brands/1.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(2, 0, '2', '2', 1, 'image/png', 5403, 'brands/2.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(3, 0, '3', '3', 1, 'image/png', 5403, 'brands/3.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(4, 0, '4', '4', 1, 'image/png', 5403, 'brands/4.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(5, 0, '1', '1', 2, 'image/png', 5327, 'product-categories/1.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(6, 0, '2', '2', 2, 'image/png', 5327, 'product-categories/2.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(7, 0, '3', '3', 2, 'image/png', 5327, 'product-categories/3.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(8, 0, '4', '4', 2, 'image/png', 5327, 'product-categories/4.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(9, 0, '5', '5', 2, 'image/png', 5327, 'product-categories/5.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(10, 0, '6', '6', 2, 'image/png', 5327, 'product-categories/6.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(11, 0, '7', '7', 2, 'image/png', 5327, 'product-categories/7.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(12, 0, '8', '8', 2, 'image/png', 5327, 'product-categories/8.png', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(13, 0, '1', '1', 3, 'image/jpeg', 9803, 'customers/1.jpg', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(14, 0, '10', '10', 3, 'image/jpeg', 9803, 'customers/10.jpg', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(15, 0, '2', '2', 3, 'image/jpeg', 9803, 'customers/2.jpg', '[]', '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL, 'public'),
(16, 0, '3', '3', 3, 'image/jpeg', 9803, 'customers/3.jpg', '[]', '2024-08-05 02:26:19', '2024-08-05 02:26:19', NULL, 'public'),
(17, 0, '4', '4', 3, 'image/jpeg', 9803, 'customers/4.jpg', '[]', '2024-08-05 02:26:19', '2024-08-05 02:26:19', NULL, 'public'),
(18, 0, '5', '5', 3, 'image/jpeg', 9803, 'customers/5.jpg', '[]', '2024-08-05 02:26:19', '2024-08-05 02:26:19', NULL, 'public'),
(19, 0, '6', '6', 3, 'image/jpeg', 9803, 'customers/6.jpg', '[]', '2024-08-05 02:26:19', '2024-08-05 02:26:19', NULL, 'public'),
(20, 0, '7', '7', 3, 'image/jpeg', 9803, 'customers/7.jpg', '[]', '2024-08-05 02:26:19', '2024-08-05 02:26:19', NULL, 'public'),
(21, 0, '8', '8', 3, 'image/jpeg', 9803, 'customers/8.jpg', '[]', '2024-08-05 02:26:19', '2024-08-05 02:26:19', NULL, 'public'),
(22, 0, '9', '9', 3, 'image/jpeg', 9803, 'customers/9.jpg', '[]', '2024-08-05 02:26:19', '2024-08-05 02:26:19', NULL, 'public'),
(23, 0, '1', '1', 4, 'image/jpeg', 9803, 'products/1.jpg', '[]', '2024-08-05 02:26:21', '2024-08-05 02:26:21', NULL, 'public'),
(24, 0, '10-1', '10-1', 4, 'image/jpeg', 9803, 'products/10-1.jpg', '[]', '2024-08-05 02:26:21', '2024-08-05 02:26:21', NULL, 'public'),
(25, 0, '10-2', '10-2', 4, 'image/jpeg', 9803, 'products/10-2.jpg', '[]', '2024-08-05 02:26:21', '2024-08-05 02:26:21', NULL, 'public'),
(26, 0, '10', '10', 4, 'image/jpeg', 9803, 'products/10.jpg', '[]', '2024-08-05 02:26:21', '2024-08-05 02:26:21', NULL, 'public'),
(27, 0, '11-1', '11-1', 4, 'image/jpeg', 9803, 'products/11-1.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(28, 0, '11-2', '11-2', 4, 'image/jpeg', 9803, 'products/11-2.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(29, 0, '11-3', '11-3', 4, 'image/jpeg', 9803, 'products/11-3.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(30, 0, '11', '11', 4, 'image/jpeg', 9803, 'products/11.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(31, 0, '12-1', '12-1', 4, 'image/jpeg', 9803, 'products/12-1.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(32, 0, '12-2', '12-2', 4, 'image/jpeg', 9803, 'products/12-2.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(33, 0, '12-3', '12-3', 4, 'image/jpeg', 9803, 'products/12-3.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(34, 0, '12', '12', 4, 'image/jpeg', 9803, 'products/12.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(35, 0, '13-1', '13-1', 4, 'image/jpeg', 9803, 'products/13-1.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(36, 0, '13', '13', 4, 'image/jpeg', 9803, 'products/13.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(37, 0, '14', '14', 4, 'image/jpeg', 9803, 'products/14.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(38, 0, '15-1', '15-1', 4, 'image/jpeg', 9803, 'products/15-1.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(39, 0, '15', '15', 4, 'image/jpeg', 9803, 'products/15.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(40, 0, '16', '16', 4, 'image/jpeg', 9803, 'products/16.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(41, 0, '17-1', '17-1', 4, 'image/jpeg', 9803, 'products/17-1.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(42, 0, '17-2', '17-2', 4, 'image/jpeg', 9803, 'products/17-2.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(43, 0, '17-3', '17-3', 4, 'image/jpeg', 9803, 'products/17-3.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(44, 0, '17', '17', 4, 'image/jpeg', 9803, 'products/17.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(45, 0, '18-1', '18-1', 4, 'image/jpeg', 9803, 'products/18-1.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(46, 0, '18-2', '18-2', 4, 'image/jpeg', 9803, 'products/18-2.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(47, 0, '18-3', '18-3', 4, 'image/jpeg', 9803, 'products/18-3.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(48, 0, '18', '18', 4, 'image/jpeg', 9803, 'products/18.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(49, 0, '19-1', '19-1', 4, 'image/jpeg', 9803, 'products/19-1.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(50, 0, '19-2', '19-2', 4, 'image/jpeg', 9803, 'products/19-2.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(51, 0, '19-3', '19-3', 4, 'image/jpeg', 9803, 'products/19-3.jpg', '[]', '2024-08-05 02:26:22', '2024-08-05 02:26:22', NULL, 'public'),
(52, 0, '19', '19', 4, 'image/jpeg', 9803, 'products/19.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(53, 0, '2-1', '2-1', 4, 'image/jpeg', 9803, 'products/2-1.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(54, 0, '2-2', '2-2', 4, 'image/jpeg', 9803, 'products/2-2.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(55, 0, '2-3', '2-3', 4, 'image/jpeg', 9803, 'products/2-3.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(56, 0, '2', '2', 4, 'image/jpeg', 9803, 'products/2.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(57, 0, '20-1', '20-1', 4, 'image/jpeg', 9803, 'products/20-1.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(58, 0, '20-2', '20-2', 4, 'image/jpeg', 9803, 'products/20-2.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(59, 0, '20-3', '20-3', 4, 'image/jpeg', 9803, 'products/20-3.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(60, 0, '20', '20', 4, 'image/jpeg', 9803, 'products/20.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(61, 0, '21-1', '21-1', 4, 'image/jpeg', 9803, 'products/21-1.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(62, 0, '21-2', '21-2', 4, 'image/jpeg', 9803, 'products/21-2.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(63, 0, '21', '21', 4, 'image/jpeg', 9803, 'products/21.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(64, 0, '22-1', '22-1', 4, 'image/jpeg', 9803, 'products/22-1.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(65, 0, '22-2', '22-2', 4, 'image/jpeg', 9803, 'products/22-2.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(66, 0, '22-3', '22-3', 4, 'image/jpeg', 9803, 'products/22-3.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(67, 0, '22', '22', 4, 'image/jpeg', 9803, 'products/22.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(68, 0, '23-1', '23-1', 4, 'image/jpeg', 9803, 'products/23-1.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(69, 0, '23-2', '23-2', 4, 'image/jpeg', 9803, 'products/23-2.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(70, 0, '23-3', '23-3', 4, 'image/jpeg', 9803, 'products/23-3.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(71, 0, '23', '23', 4, 'image/jpeg', 9803, 'products/23.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(72, 0, '24-1', '24-1', 4, 'image/jpeg', 9803, 'products/24-1.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(73, 0, '24-2', '24-2', 4, 'image/jpeg', 9803, 'products/24-2.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(74, 0, '24', '24', 4, 'image/jpeg', 9803, 'products/24.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(75, 0, '25-1', '25-1', 4, 'image/jpeg', 9803, 'products/25-1.jpg', '[]', '2024-08-05 02:26:23', '2024-08-05 02:26:23', NULL, 'public'),
(76, 0, '25-2', '25-2', 4, 'image/jpeg', 9803, 'products/25-2.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(77, 0, '25', '25', 4, 'image/jpeg', 9803, 'products/25.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(78, 0, '26-1', '26-1', 4, 'image/jpeg', 9803, 'products/26-1.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(79, 0, '26', '26', 4, 'image/jpeg', 9803, 'products/26.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(80, 0, '27-1', '27-1', 4, 'image/jpeg', 9803, 'products/27-1.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(81, 0, '27', '27', 4, 'image/jpeg', 9803, 'products/27.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(82, 0, '28-1', '28-1', 4, 'image/jpeg', 9803, 'products/28-1.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(83, 0, '28-2', '28-2', 4, 'image/jpeg', 9803, 'products/28-2.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(84, 0, '28', '28', 4, 'image/jpeg', 9803, 'products/28.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(85, 0, '29-1', '29-1', 4, 'image/jpeg', 9803, 'products/29-1.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(86, 0, '29-2', '29-2', 4, 'image/jpeg', 9803, 'products/29-2.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(87, 0, '29', '29', 4, 'image/jpeg', 9803, 'products/29.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(88, 0, '3', '3', 4, 'image/jpeg', 9803, 'products/3.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(89, 0, '30-1', '30-1', 4, 'image/jpeg', 9803, 'products/30-1.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(90, 0, '30-2', '30-2', 4, 'image/jpeg', 9803, 'products/30-2.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(91, 0, '30', '30', 4, 'image/jpeg', 9803, 'products/30.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(92, 0, '31-1', '31-1', 4, 'image/jpeg', 9803, 'products/31-1.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(93, 0, '31', '31', 4, 'image/jpeg', 9803, 'products/31.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(94, 0, '32-1', '32-1', 4, 'image/jpeg', 9803, 'products/32-1.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(95, 0, '32-2', '32-2', 4, 'image/jpeg', 9803, 'products/32-2.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(96, 0, '32', '32', 4, 'image/jpeg', 9803, 'products/32.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(97, 0, '33-1', '33-1', 4, 'image/jpeg', 9803, 'products/33-1.jpg', '[]', '2024-08-05 02:26:24', '2024-08-05 02:26:24', NULL, 'public'),
(98, 0, '33-2', '33-2', 4, 'image/jpeg', 9803, 'products/33-2.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(99, 0, '33', '33', 4, 'image/jpeg', 9803, 'products/33.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(100, 0, '34-1', '34-1', 4, 'image/jpeg', 9803, 'products/34-1.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(101, 0, '34', '34', 4, 'image/jpeg', 9803, 'products/34.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(102, 0, '35-1', '35-1', 4, 'image/jpeg', 9803, 'products/35-1.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(103, 0, '35', '35', 4, 'image/jpeg', 9803, 'products/35.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(104, 0, '36-1', '36-1', 4, 'image/jpeg', 9803, 'products/36-1.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(105, 0, '36-2', '36-2', 4, 'image/jpeg', 9803, 'products/36-2.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(106, 0, '36', '36', 4, 'image/jpeg', 9803, 'products/36.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(107, 0, '37-1', '37-1', 4, 'image/jpeg', 9803, 'products/37-1.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(108, 0, '37-2', '37-2', 4, 'image/jpeg', 9803, 'products/37-2.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(109, 0, '37', '37', 4, 'image/jpeg', 9803, 'products/37.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(110, 0, '38-1', '38-1', 4, 'image/jpeg', 9803, 'products/38-1.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(111, 0, '38-2', '38-2', 4, 'image/jpeg', 9803, 'products/38-2.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(112, 0, '38-3', '38-3', 4, 'image/jpeg', 9803, 'products/38-3.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(113, 0, '38', '38', 4, 'image/jpeg', 9803, 'products/38.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(114, 0, '39-1', '39-1', 4, 'image/jpeg', 9803, 'products/39-1.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(115, 0, '39-2', '39-2', 4, 'image/jpeg', 9803, 'products/39-2.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(116, 0, '39', '39', 4, 'image/jpeg', 9803, 'products/39.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(117, 0, '4-1', '4-1', 4, 'image/jpeg', 9803, 'products/4-1.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(118, 0, '4-2', '4-2', 4, 'image/jpeg', 9803, 'products/4-2.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(119, 0, '4-3', '4-3', 4, 'image/jpeg', 9803, 'products/4-3.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(120, 0, '4', '4', 4, 'image/jpeg', 9803, 'products/4.jpg', '[]', '2024-08-05 02:26:25', '2024-08-05 02:26:25', NULL, 'public'),
(121, 0, '40-1', '40-1', 4, 'image/jpeg', 9803, 'products/40-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(122, 0, '40', '40', 4, 'image/jpeg', 9803, 'products/40.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(123, 0, '41-1', '41-1', 4, 'image/jpeg', 9803, 'products/41-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(124, 0, '41-2', '41-2', 4, 'image/jpeg', 9803, 'products/41-2.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(125, 0, '41', '41', 4, 'image/jpeg', 9803, 'products/41.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(126, 0, '42-1', '42-1', 4, 'image/jpeg', 9803, 'products/42-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(127, 0, '42-2', '42-2', 4, 'image/jpeg', 9803, 'products/42-2.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(128, 0, '42', '42', 4, 'image/jpeg', 9803, 'products/42.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(129, 0, '43-1', '43-1', 4, 'image/jpeg', 9803, 'products/43-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(130, 0, '43-2', '43-2', 4, 'image/jpeg', 9803, 'products/43-2.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(131, 0, '43', '43', 4, 'image/jpeg', 9803, 'products/43.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(132, 0, '44-1', '44-1', 4, 'image/jpeg', 9803, 'products/44-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(133, 0, '44-2', '44-2', 4, 'image/jpeg', 9803, 'products/44-2.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(134, 0, '44', '44', 4, 'image/jpeg', 9803, 'products/44.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(135, 0, '45-1', '45-1', 4, 'image/jpeg', 9803, 'products/45-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(136, 0, '45', '45', 4, 'image/jpeg', 9803, 'products/45.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(137, 0, '46-1', '46-1', 4, 'image/jpeg', 9803, 'products/46-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(138, 0, '46', '46', 4, 'image/jpeg', 9803, 'products/46.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(139, 0, '47-1', '47-1', 4, 'image/jpeg', 9803, 'products/47-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(140, 0, '47', '47', 4, 'image/jpeg', 9803, 'products/47.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(141, 0, '48-1', '48-1', 4, 'image/jpeg', 9803, 'products/48-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(142, 0, '48-2', '48-2', 4, 'image/jpeg', 9803, 'products/48-2.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(143, 0, '48', '48', 4, 'image/jpeg', 9803, 'products/48.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(144, 0, '49-1', '49-1', 4, 'image/jpeg', 9803, 'products/49-1.jpg', '[]', '2024-08-05 02:26:26', '2024-08-05 02:26:26', NULL, 'public'),
(145, 0, '49-2', '49-2', 4, 'image/jpeg', 9803, 'products/49-2.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(146, 0, '49', '49', 4, 'image/jpeg', 9803, 'products/49.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(147, 0, '5-1', '5-1', 4, 'image/jpeg', 9803, 'products/5-1.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(148, 0, '5-2', '5-2', 4, 'image/jpeg', 9803, 'products/5-2.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(149, 0, '5-3', '5-3', 4, 'image/jpeg', 9803, 'products/5-3.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(150, 0, '5', '5', 4, 'image/jpeg', 9803, 'products/5.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(151, 0, '50-1', '50-1', 4, 'image/jpeg', 9803, 'products/50-1.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(152, 0, '50', '50', 4, 'image/jpeg', 9803, 'products/50.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(153, 0, '51', '51', 4, 'image/jpeg', 9803, 'products/51.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(154, 0, '52-1', '52-1', 4, 'image/jpeg', 9803, 'products/52-1.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(155, 0, '52-2', '52-2', 4, 'image/jpeg', 9803, 'products/52-2.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(156, 0, '52', '52', 4, 'image/jpeg', 9803, 'products/52.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(157, 0, '53-1', '53-1', 4, 'image/jpeg', 9803, 'products/53-1.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(158, 0, '53', '53', 4, 'image/jpeg', 9803, 'products/53.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(159, 0, '54-1', '54-1', 4, 'image/jpeg', 9803, 'products/54-1.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(160, 0, '54', '54', 4, 'image/jpeg', 9803, 'products/54.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(161, 0, '55-1', '55-1', 4, 'image/jpeg', 9803, 'products/55-1.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(162, 0, '55-2', '55-2', 4, 'image/jpeg', 9803, 'products/55-2.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(163, 0, '55', '55', 4, 'image/jpeg', 9803, 'products/55.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(164, 0, '56-1', '56-1', 4, 'image/jpeg', 9803, 'products/56-1.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(165, 0, '56-2', '56-2', 4, 'image/jpeg', 9803, 'products/56-2.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(166, 0, '56', '56', 4, 'image/jpeg', 9803, 'products/56.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(167, 0, '57-1', '57-1', 4, 'image/jpeg', 9803, 'products/57-1.jpg', '[]', '2024-08-05 02:26:27', '2024-08-05 02:26:27', NULL, 'public'),
(168, 0, '57', '57', 4, 'image/jpeg', 9803, 'products/57.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(169, 0, '58-1', '58-1', 4, 'image/jpeg', 9803, 'products/58-1.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(170, 0, '58-2', '58-2', 4, 'image/jpeg', 9803, 'products/58-2.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(171, 0, '58', '58', 4, 'image/jpeg', 9803, 'products/58.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(172, 0, '59-1', '59-1', 4, 'image/jpeg', 9803, 'products/59-1.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(173, 0, '59-2', '59-2', 4, 'image/jpeg', 9803, 'products/59-2.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(174, 0, '59-3', '59-3', 4, 'image/jpeg', 9803, 'products/59-3.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(175, 0, '59', '59', 4, 'image/jpeg', 9803, 'products/59.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(176, 0, '6', '6', 4, 'image/jpeg', 9803, 'products/6.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(177, 0, '60-1', '60-1', 4, 'image/jpeg', 9803, 'products/60-1.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(178, 0, '60-2', '60-2', 4, 'image/jpeg', 9803, 'products/60-2.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(179, 0, '60', '60', 4, 'image/jpeg', 9803, 'products/60.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(180, 0, '61-1', '61-1', 4, 'image/jpeg', 9803, 'products/61-1.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(181, 0, '61', '61', 4, 'image/jpeg', 9803, 'products/61.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(182, 0, '62-1', '62-1', 4, 'image/jpeg', 9803, 'products/62-1.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(183, 0, '62', '62', 4, 'image/jpeg', 9803, 'products/62.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(184, 0, '63-1', '63-1', 4, 'image/jpeg', 9803, 'products/63-1.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(185, 0, '63', '63', 4, 'image/jpeg', 9803, 'products/63.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(186, 0, '64-1', '64-1', 4, 'image/jpeg', 9803, 'products/64-1.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(187, 0, '64', '64', 4, 'image/jpeg', 9803, 'products/64.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(188, 0, '65-1', '65-1', 4, 'image/jpeg', 9803, 'products/65-1.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(189, 0, '65-2', '65-2', 4, 'image/jpeg', 9803, 'products/65-2.jpg', '[]', '2024-08-05 02:26:28', '2024-08-05 02:26:28', NULL, 'public'),
(190, 0, '65', '65', 4, 'image/jpeg', 9803, 'products/65.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(191, 0, '7', '7', 4, 'image/jpeg', 9803, 'products/7.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(192, 0, '8-1', '8-1', 4, 'image/jpeg', 9803, 'products/8-1.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(193, 0, '8-2', '8-2', 4, 'image/jpeg', 9803, 'products/8-2.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(194, 0, '8-3', '8-3', 4, 'image/jpeg', 9803, 'products/8-3.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(195, 0, '8', '8', 4, 'image/jpeg', 9803, 'products/8.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(196, 0, '9-1', '9-1', 4, 'image/jpeg', 9803, 'products/9-1.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(197, 0, '9-2', '9-2', 4, 'image/jpeg', 9803, 'products/9-2.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(198, 0, '9', '9', 4, 'image/jpeg', 9803, 'products/9.jpg', '[]', '2024-08-05 02:26:29', '2024-08-05 02:26:29', NULL, 'public'),
(199, 0, '1', '1', 5, 'image/png', 2691, 'stores/1.png', '[]', '2024-08-05 02:26:32', '2024-08-05 02:26:32', NULL, 'public'),
(200, 0, '10', '10', 5, 'image/png', 2691, 'stores/10.png', '[]', '2024-08-05 02:26:32', '2024-08-05 02:26:32', NULL, 'public'),
(201, 0, '11', '11', 5, 'image/png', 2691, 'stores/11.png', '[]', '2024-08-05 02:26:32', '2024-08-05 02:26:32', NULL, 'public'),
(202, 0, '12', '12', 5, 'image/png', 2691, 'stores/12.png', '[]', '2024-08-05 02:26:32', '2024-08-05 02:26:32', NULL, 'public'),
(203, 0, '13', '13', 5, 'image/png', 2691, 'stores/13.png', '[]', '2024-08-05 02:26:32', '2024-08-05 02:26:32', NULL, 'public'),
(204, 0, '14', '14', 5, 'image/png', 2691, 'stores/14.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(205, 0, '15', '15', 5, 'image/png', 2691, 'stores/15.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(206, 0, '16', '16', 5, 'image/png', 2732, 'stores/16.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(207, 0, '17', '17', 5, 'image/png', 2732, 'stores/17.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(208, 0, '2', '2', 5, 'image/png', 2691, 'stores/2.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(209, 0, '3', '3', 5, 'image/png', 2691, 'stores/3.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(210, 0, '4', '4', 5, 'image/png', 2691, 'stores/4.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(211, 0, '5', '5', 5, 'image/png', 2691, 'stores/5.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(212, 0, '6', '6', 5, 'image/png', 2691, 'stores/6.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(213, 0, '7', '7', 5, 'image/png', 2691, 'stores/7.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(214, 0, '8', '8', 5, 'image/png', 2691, 'stores/8.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(215, 0, '9', '9', 5, 'image/png', 2691, 'stores/9.png', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(216, 0, 'background-1', 'background-1', 5, 'image/jpeg', 5286, 'stores/background-1.jpg', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(217, 0, 'background-2', 'background-2', 5, 'image/jpeg', 5286, 'stores/background-2.jpg', '[]', '2024-08-05 02:26:33', '2024-08-05 02:26:33', NULL, 'public'),
(218, 0, '1', '1', 6, 'image/jpeg', 9803, 'news/1.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(219, 0, '10', '10', 6, 'image/jpeg', 9803, 'news/10.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(220, 0, '11', '11', 6, 'image/jpeg', 9803, 'news/11.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(221, 0, '2', '2', 6, 'image/jpeg', 9803, 'news/2.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(222, 0, '3', '3', 6, 'image/jpeg', 9803, 'news/3.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(223, 0, '4', '4', 6, 'image/jpeg', 9803, 'news/4.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(224, 0, '5', '5', 6, 'image/jpeg', 9803, 'news/5.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(225, 0, '6', '6', 6, 'image/jpeg', 9803, 'news/6.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(226, 0, '7', '7', 6, 'image/jpeg', 9803, 'news/7.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(227, 0, '8', '8', 6, 'image/jpeg', 9803, 'news/8.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(228, 0, '9', '9', 6, 'image/jpeg', 9803, 'news/9.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(229, 0, '01-sm', '01-sm', 7, 'image/jpeg', 10737, 'sliders/01-sm.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(230, 0, '01', '01', 7, 'image/jpeg', 11704, 'sliders/01.jpg', '[]', '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL, 'public'),
(231, 0, '02-sm', '02-sm', 7, 'image/jpeg', 10737, 'sliders/02-sm.jpg', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(232, 0, '02', '02', 7, 'image/jpeg', 11704, 'sliders/02.jpg', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(233, 0, '1', '1', 8, 'image/jpeg', 7935, 'promotion/1.jpg', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(234, 0, '2', '2', 8, 'image/png', 14659, 'promotion/2.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(235, 0, '3', '3', 8, 'image/png', 10632, 'promotion/3.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(236, 0, '4', '4', 8, 'image/png', 10076, 'promotion/4.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(237, 0, '5', '5', 8, 'image/png', 12274, 'promotion/5.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(238, 0, '404', '404', 9, 'image/png', 31617, 'general/404.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(239, 0, 'app-android', 'app-android', 9, 'image/png', 630, 'general/app-android.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(240, 0, 'app-bg', 'app-bg', 9, 'image/png', 11530, 'general/app-bg.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(241, 0, 'app-ios', 'app-ios', 9, 'image/png', 630, 'general/app-ios.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(242, 0, 'background', 'background', 9, 'image/jpeg', 26676, 'general/background.jpg', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(243, 0, 'blog-bg', 'blog-bg', 9, 'image/jpeg', 81226, 'general/blog-bg.jpg', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(244, 0, 'coming-soon', 'coming-soon', 9, 'image/jpeg', 26506, 'general/coming-soon.jpg', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(245, 0, 'facebook', 'facebook', 9, 'image/png', 686, 'general/facebook.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(246, 0, 'favicon', 'favicon', 9, 'image/png', 6542, 'general/favicon.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(247, 0, 'footer-payments', 'footer-payments', 9, 'image/png', 439, 'general/footer-payments.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(248, 0, 'icon-protect', 'icon-protect', 9, 'image/png', 1665, 'general/icon-protect.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(249, 0, 'icon-reload', 'icon-reload', 9, 'image/png', 1442, 'general/icon-reload.png', '[]', '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL, 'public'),
(250, 0, 'icon-rocket', 'icon-rocket', 9, 'image/png', 1541, 'general/icon-rocket.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(251, 0, 'icon-support', 'icon-support', 9, 'image/png', 1813, 'general/icon-support.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(252, 0, 'icon-tag', 'icon-tag', 9, 'image/png', 1127, 'general/icon-tag.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(253, 0, 'instagram', 'instagram', 9, 'image/png', 2355, 'general/instagram.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(254, 0, 'logo-light', 'logo-light', 9, 'image/png', 12700, 'general/logo-light.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(255, 0, 'logo', 'logo', 9, 'image/png', 18493, 'general/logo.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(256, 0, 'newsletter-popup', 'newsletter-popup', 9, 'image/png', 17253, 'general/newsletter-popup.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(257, 0, 'open-graph-image', 'open-graph-image', 9, 'image/png', 406719, 'general/open-graph-image.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(258, 0, 'pinterest', 'pinterest', 9, 'image/png', 1857, 'general/pinterest.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(259, 0, 'placeholder', 'placeholder', 9, 'image/png', 2543, 'general/placeholder.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(260, 0, 'slider-bg', 'slider-bg', 9, 'image/jpeg', 26676, 'general/slider-bg.jpg', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(261, 0, 'twitter', 'twitter', 9, 'image/png', 1587, 'general/twitter.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(262, 0, 'youtube', 'youtube', 9, 'image/png', 947, 'general/youtube.png', '[]', '2024-08-05 02:26:38', '2024-08-05 02:26:38', NULL, 'public'),
(263, 1, 'marj-banner', 'marj-banner', 2, 'image/jpeg', 60921, 'product-categories/marj-banner.jpg', '[]', '2024-09-20 02:43:37', '2024-09-20 02:43:37', NULL, 'public'),
(264, 1, 'marj-banner-1', 'marj-banner-1', 2, 'image/jpeg', 62959, 'product-categories/marj-banner-1.jpg', '[]', '2024-09-20 02:44:45', '2024-09-20 02:44:45', NULL, 'public'),
(265, 1, 'marj', 'marj', 2, 'image/jpeg', 18553, 'product-categories/marj.jpg', '[]', '2024-09-20 02:45:15', '2024-09-20 02:45:15', NULL, 'public'),
(266, 1, 'laathani', 'laathani', 2, 'image/jpeg', 32694, 'product-categories/laathani.jpg', '[]', '2024-09-20 02:45:19', '2024-09-20 02:45:19', NULL, 'public'),
(267, 1, 'little-hearts-collection-2', 'little-hearts-collection-2', 2, 'image/jpeg', 29288, 'product-categories/little-hearts-collection-2.jpg', '[]', '2024-09-20 02:48:22', '2024-09-20 02:48:22', NULL, 'public'),
(268, 1, 'Oud-Roses-Collection-1', 'Oud-Roses-Collection-1', 2, 'image/jpeg', 34043, 'product-categories/oud-roses-collection-1.jpg', '[]', '2024-09-20 02:48:23', '2024-09-20 02:48:23', NULL, 'public'),
(269, 1, 'bodygel-banner', 'bodygel-banner', 2, 'image/jpeg', 16537, 'product-categories/bodygel-banner.jpg', '[]', '2024-09-20 02:48:23', '2024-09-20 02:48:23', NULL, 'public'),
(270, 1, 'oud-roses-bodygel', 'oud-roses-bodygel', 2, 'image/jpeg', 28354, 'product-categories/oud-roses-bodygel.jpg', '[]', '2024-09-20 02:48:23', '2024-09-20 02:48:23', NULL, 'public'),
(271, 1, 'Oud-Roses-giftset', 'Oud-Roses-giftset', 2, 'image/jpeg', 26320, 'product-categories/oud-roses-giftset.jpg', '[]', '2024-09-20 02:48:24', '2024-09-20 02:48:24', NULL, 'public'),
(272, 1, 'little-hearts', 'little-hearts', 2, 'image/jpeg', 24544, 'product-categories/little-hearts.jpg', '[]', '2024-09-20 02:48:24', '2024-09-20 02:48:24', NULL, 'public'),
(273, 1, 'oud-amber-section', 'oud-amber-section', 2, 'image/jpeg', 20176, 'product-categories/oud-amber-section.jpg', '[]', '2024-09-20 02:48:24', '2024-09-20 02:48:24', NULL, 'public'),
(274, 1, 'Oud-Mattar-Maliki', 'Oud-Mattar-Maliki', 2, 'image/jpeg', 29818, 'product-categories/oud-mattar-maliki.jpg', '[]', '2024-09-20 02:48:25', '2024-09-20 02:48:25', NULL, 'public'),
(275, 1, 'Dehn-AL-oud-banner', 'Dehn-AL-oud-banner', 2, 'image/jpeg', 19715, 'product-categories/dehn-al-oud-banner.jpg', '[]', '2024-09-20 02:48:25', '2024-09-20 02:48:25', NULL, 'public'),
(276, 1, 'Bidun-Esam-oil', 'Bidun-Esam-oil', 2, 'image/jpeg', 24848, 'product-categories/bidun-esam-oil.jpg', '[]', '2024-09-20 02:48:25', '2024-09-20 02:48:25', NULL, 'public'),
(277, 1, 'laathani-banner', 'laathani-banner', 2, 'image/webp', 139996, 'product-categories/laathani-banner.webp', '[]', '2024-09-20 02:50:43', '2024-09-20 02:50:43', NULL, 'public'),
(278, 1, 'video-animation', 'video-animation', 2, 'video/mp4', 279790, 'product-categories/video-animation.mp4', '[]', '2024-09-20 03:11:06', '2024-09-20 03:11:06', NULL, 'public'),
(279, 1, 'laathani-short', 'laathani-short', 2, 'video/mp4', 4909173, 'product-categories/laathani-short.mp4', '[]', '2024-09-20 03:11:07', '2024-09-20 03:11:07', NULL, 'public'),
(280, 1, 'Ahmed-Perfume-Street-View', 'Ahmed-Perfume-Street-View', 2, 'video/mp4', 4134320, 'product-categories/ahmed-perfume-street-view.mp4', '[]', '2024-09-20 03:11:07', '2024-09-20 03:11:07', NULL, 'public'),
(281, 1, 'SHOP-VIDEO-1', 'SHOP-VIDEO-1', 2, 'video/mp4', 2636200, 'product-categories/shop-video-1.mp4', '[]', '2024-09-20 03:11:07', '2024-09-20 03:11:07', NULL, 'public'),
(282, 1, 'SHOP-VIDEO-1-1', 'SHOP-VIDEO-1-1', 2, 'video/mp4', 2636200, 'product-categories/shop-video-1-1.mp4', '[]', '2024-09-20 03:11:49', '2024-09-20 03:11:49', NULL, 'public'),
(283, 1, 'SHOP-VIDEO-1-2', 'SHOP-VIDEO-1-2', 2, 'video/mp4', 2636200, 'product-categories/shop-video-1-2.mp4', '[]', '2024-09-20 03:12:59', '2024-09-20 03:12:59', NULL, 'public'),
(284, 1, 'Ahmed-Perfume-Street-View-1', 'Ahmed-Perfume-Street-View-1', 2, 'video/mp4', 4134320, 'product-categories/ahmed-perfume-street-view-1.mp4', '[]', '2024-09-20 03:13:09', '2024-09-20 03:13:09', NULL, 'public'),
(285, 1, 'SHOP-VIDEO-1', 'SHOP-VIDEO-1', 1, 'video/mp4', 2636200, 'brands/shop-video-1.mp4', '[]', '2024-09-20 03:13:34', '2024-09-20 03:13:34', NULL, 'public'),
(286, 1, 'gardenia-notes', 'gardenia-notes', 4, 'image/webp', 39260, 'products/gardenia-notes.webp', '[]', '2024-09-20 03:41:17', '2024-09-20 03:41:17', NULL, 'public'),
(287, 1, 'kaaf-notes', 'kaaf-notes', 4, 'image/webp', 27032, 'products/kaaf-notes.webp', '[]', '2024-09-20 03:41:17', '2024-09-20 03:41:17', NULL, 'public'),
(288, 1, 'maani', 'maani', 4, 'image/webp', 13120, 'products/maani.webp', '[]', '2024-09-20 03:41:18', '2024-09-20 03:41:18', NULL, 'public'),
(289, 1, 'musk-ahmed', 'musk-ahmed', 4, 'image/webp', 14970, 'products/musk-ahmed.webp', '[]', '2024-09-20 03:41:18', '2024-09-20 03:41:18', NULL, 'public'),
(290, 1, 'laathani-web', 'laathani-web', 4, 'image/webp', 130880, 'products/laathani-web.webp', '[]', '2024-09-20 03:41:18', '2024-09-20 03:41:18', NULL, 'public'),
(291, 1, 'oud-and-lavender', 'oud-and-lavender', 4, 'image/webp', 14036, 'products/oud-and-lavender.webp', '[]', '2024-09-20 03:41:19', '2024-09-20 03:41:19', NULL, 'public'),
(292, 1, 'Summer-collection-1-300x400', 'Summer-collection-1-300x400', 4, 'image/jpeg', 18186, 'products/summer-collection-1-300x400.jpg', '[]', '2024-09-20 04:37:19', '2024-09-20 04:37:19', NULL, 'public');

-- --------------------------------------------------------

--
-- Table structure for table `media_folders`
--

CREATE TABLE `media_folders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `color` varchar(191) DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media_folders`
--

INSERT INTO `media_folders` (`id`, `user_id`, `name`, `color`, `slug`, `parent_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 0, 'brands', NULL, 'brands', 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL),
(2, 0, 'product-categories', NULL, 'product-categories', 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL),
(3, 0, 'customers', NULL, 'customers', 0, '2024-08-05 02:26:18', '2024-08-05 02:26:18', NULL),
(4, 0, 'products', NULL, 'products', 0, '2024-08-05 02:26:21', '2024-08-05 02:26:21', NULL),
(5, 0, 'stores', NULL, 'stores', 0, '2024-08-05 02:26:32', '2024-08-05 02:26:32', NULL),
(6, 0, 'news', NULL, 'news', 0, '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL),
(7, 0, 'sliders', NULL, 'sliders', 0, '2024-08-05 02:26:36', '2024-08-05 02:26:36', NULL),
(8, 0, 'promotion', NULL, 'promotion', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL),
(9, 0, 'general', NULL, 'general', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `media_settings`
--

CREATE TABLE `media_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(120) NOT NULL,
  `value` text DEFAULT NULL,
  `media_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Main menu', 'main-menu', 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(2, 'Header menu', 'header-menu', 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(3, 'Useful Links', 'useful-links', 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(4, 'Help Center', 'help-center', 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(5, 'Business', 'business', 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37');

-- --------------------------------------------------------

--
-- Table structure for table `menu_locations`
--

CREATE TABLE `menu_locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `location` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_locations`
--

INSERT INTO `menu_locations` (`id`, `menu_id`, `location`, `created_at`, `updated_at`) VALUES
(1, 1, 'main-menu', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(2, 2, 'header-navigation', '2024-08-05 02:26:37', '2024-08-05 02:26:37');

-- --------------------------------------------------------

--
-- Table structure for table `menu_nodes`
--

CREATE TABLE `menu_nodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `reference_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reference_type` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `icon_font` varchar(191) DEFAULT NULL,
  `position` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `title` varchar(191) DEFAULT NULL,
  `css_class` varchar(191) DEFAULT NULL,
  `target` varchar(20) NOT NULL DEFAULT '_self',
  `has_child` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_nodes`
--

INSERT INTO `menu_nodes` (`id`, `menu_id`, `parent_id`, `reference_id`, `reference_type`, `url`, `icon_font`, `position`, `title`, `css_class`, `target`, `has_child`, `created_at`, `updated_at`) VALUES
(1, 1, 0, NULL, NULL, '/products/smart-watches', 'icon icon-tag', 0, 'Special Prices', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(2, 1, 0, NULL, NULL, '#', NULL, 0, 'Pages', NULL, '_self', 1, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(3, 1, 2, 2, 'Botble\\Page\\Models\\Page', '/about-us', NULL, 0, 'About us', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(4, 1, 2, 3, 'Botble\\Page\\Models\\Page', '/terms-of-use', NULL, 0, 'Terms Of Use', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(5, 1, 2, 4, 'Botble\\Page\\Models\\Page', '/terms-conditions', NULL, 0, 'Terms & Conditions', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(6, 1, 2, 5, 'Botble\\Page\\Models\\Page', '/refund-policy', NULL, 0, 'Refund Policy', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(7, 1, 2, 12, 'Botble\\Page\\Models\\Page', '/coming-soon', NULL, 0, 'Coming soon', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(8, 1, 0, NULL, NULL, '/products', NULL, 0, 'Shop', NULL, '_self', 1, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(9, 1, 8, NULL, NULL, '/products', NULL, 0, 'All products', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(10, 1, 8, 15, 'Botble\\Ecommerce\\Models\\ProductCategory', NULL, NULL, 0, 'Products Of Category', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(11, 1, 8, NULL, NULL, '/products/beat-headphone', NULL, 0, 'Product Single', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(12, 1, 0, NULL, NULL, '/stores', NULL, 0, 'Stores', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(13, 1, 0, 6, 'Botble\\Page\\Models\\Page', NULL, NULL, 0, 'Blog', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(14, 1, 0, 7, 'Botble\\Page\\Models\\Page', NULL, NULL, 0, 'FAQs', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(15, 1, 0, 8, 'Botble\\Page\\Models\\Page', NULL, NULL, 0, 'Contact', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(16, 2, 0, 2, 'Botble\\Page\\Models\\Page', NULL, NULL, 1, 'About Us', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(17, 2, 0, NULL, NULL, 'wishlist', NULL, 1, 'Wishlist', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(18, 2, 0, NULL, NULL, 'orders/tracking', NULL, 1, 'Order Tracking', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(19, 3, 0, 3, 'Botble\\Page\\Models\\Page', NULL, NULL, 2, 'Terms Of Use', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(20, 3, 0, 4, 'Botble\\Page\\Models\\Page', NULL, NULL, 2, 'Terms & Conditions', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(21, 3, 0, 5, 'Botble\\Page\\Models\\Page', NULL, NULL, 2, 'Refund Policy', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(22, 3, 0, 7, 'Botble\\Page\\Models\\Page', NULL, NULL, 2, 'FAQs', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(23, 3, 0, NULL, NULL, '/nothing', NULL, 2, '404 Page', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(24, 4, 0, 2, 'Botble\\Page\\Models\\Page', NULL, NULL, 3, 'About us', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(25, 4, 0, 10, 'Botble\\Page\\Models\\Page', NULL, NULL, 3, 'Affiliate', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(26, 4, 0, 11, 'Botble\\Page\\Models\\Page', NULL, NULL, 3, 'Career', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(27, 4, 0, 8, 'Botble\\Page\\Models\\Page', NULL, NULL, 3, 'Contact us', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(28, 5, 0, 6, 'Botble\\Page\\Models\\Page', NULL, NULL, 4, 'Our blog', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(29, 5, 0, NULL, NULL, '/cart', NULL, 4, 'Cart', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(30, 5, 0, NULL, NULL, '/customer/overview', NULL, 4, 'My account', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(31, 5, 0, NULL, NULL, '/products', NULL, 4, 'Shop', NULL, '_self', 0, '2024-08-05 02:26:37', '2024-08-05 02:26:37');

-- --------------------------------------------------------

--
-- Table structure for table `meta_boxes`
--

CREATE TABLE `meta_boxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(191) NOT NULL,
  `meta_value` text DEFAULT NULL,
  `reference_id` bigint(20) UNSIGNED NOT NULL,
  `reference_type` varchar(120) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meta_boxes`
--

INSERT INTO `meta_boxes` (`id`, `meta_key`, `meta_value`, `reference_id`, `reference_type`, `created_at`, `updated_at`) VALUES
(1, 'faq_ids', '[[]]', 1, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 03:41:50'),
(3, 'faq_ids', '[[]]', 3, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 03:52:55'),
(4, 'faq_ids', '[[]]', 4, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 03:57:35'),
(5, 'faq_ids', '[[]]', 5, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:07:24'),
(6, 'faq_ids', '[[]]', 6, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:08:22'),
(7, 'faq_ids', '[[]]', 7, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:11:30'),
(8, 'faq_ids', '[[]]', 8, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:12:36'),
(9, 'faq_ids', '[[]]', 9, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:13:32'),
(10, 'faq_ids', '[[]]', 10, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:14:22'),
(11, 'faq_ids', '[[]]', 11, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:16:17'),
(12, 'faq_ids', '[[]]', 12, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:16:52'),
(13, 'faq_ids', '[[]]', 13, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:17:57'),
(14, 'faq_ids', '[[]]', 14, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:21:52'),
(15, 'faq_ids', '[[]]', 15, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:23:03'),
(16, 'faq_ids', '[[]]', 16, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:23:45'),
(17, 'faq_ids', '[[]]', 17, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:29', '2024-09-20 04:31:12'),
(18, 'faq_ids', '[[]]', 18, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 04:31:50'),
(19, 'faq_ids', '[[]]', 19, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 04:33:46'),
(20, 'faq_ids', '[[]]', 20, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 04:34:18'),
(21, 'faq_ids', '[[]]', 21, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 04:35:19'),
(22, 'faq_ids', '[[]]', 22, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 04:37:26'),
(23, 'faq_ids', '[[]]', 23, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 06:53:49'),
(25, 'faq_ids', '[[]]', 25, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 07:27:57'),
(26, 'faq_ids', '[[]]', 26, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 07:29:11'),
(27, 'faq_ids', '[[]]', 27, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-09-20 07:30:55'),
(29, 'faq_ids', '[[4,5,7,8,10]]', 29, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(30, 'faq_ids', '[[2,3,5,7,8]]', 30, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(31, 'faq_ids', '[[1,2,4,5,8]]', 31, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(32, 'faq_ids', '[[2,4,7,8,9]]', 32, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(33, 'faq_ids', '[[2,3,4,7,8]]', 33, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(34, 'faq_ids', '[[1,4,6,8,10]]', 34, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(35, 'faq_ids', '[[2,3,5,7,10]]', 35, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(36, 'faq_ids', '[[2,4,5,7,8]]', 36, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(37, 'faq_ids', '[[1,2,5,8,9]]', 37, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(38, 'faq_ids', '[[4,6,7,8,10]]', 38, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(39, 'faq_ids', '[[5,6,7,8,10]]', 39, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(40, 'faq_ids', '[[1,6,8,9,10]]', 40, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(41, 'faq_ids', '[[1,5,6,7,8]]', 41, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(42, 'faq_ids', '[[2,3,5,7,10]]', 42, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(43, 'faq_ids', '[[1,2,5,6,10]]', 43, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(44, 'faq_ids', '[[1,5,6,7,10]]', 44, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(45, 'faq_ids', '[[2,5,7,9,10]]', 45, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(46, 'faq_ids', '[[3,5,7,8,10]]', 46, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(47, 'faq_ids', '[[1,3,5,7,9]]', 47, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(48, 'faq_ids', '[[2,3,4,5,7]]', 48, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(49, 'faq_ids', '[[1,5,6,8,10]]', 49, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(50, 'faq_ids', '[[1,4,7,8,9]]', 50, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(51, 'faq_ids', '[[4,5,7,8,9]]', 51, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(52, 'faq_ids', '[[3,4,5,7,8]]', 52, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(53, 'faq_ids', '[[1,2,6,9,10]]', 53, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(54, 'faq_ids', '[[3,4,5,8,9]]', 54, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(55, 'faq_ids', '[[2,5,6,7,10]]', 55, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(56, 'faq_ids', '[[2,3,4,5,10]]', 56, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(57, 'faq_ids', '[[2,3,4,6,10]]', 57, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(58, 'faq_ids', '[[3,5,8,9,10]]', 58, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(59, 'faq_ids', '[[2,4,5,8,9]]', 59, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(60, 'faq_ids', '[[2,5,6,7,8]]', 60, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(61, 'faq_ids', '[[4,5,6,7,9]]', 61, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(62, 'faq_ids', '[[3,4,5,7,8]]', 62, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(63, 'faq_ids', '[[2,3,6,9,10]]', 63, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(64, 'faq_ids', '[[3,5,6,8,9]]', 64, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(65, 'faq_ids', '[[1,2,4,7,10]]', 65, 'Botble\\Ecommerce\\Models\\Product', '2024-08-05 02:26:31', '2024-08-05 02:26:31'),
(66, 'background', '[\"stores\\/background-2.jpg\"]', 1, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(67, 'socials', '[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]', 1, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(68, 'background', '[\"stores\\/background-2.jpg\"]', 2, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(69, 'socials', '[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]', 2, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(70, 'background', '[\"stores\\/background-1.jpg\"]', 3, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(71, 'socials', '[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]', 3, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(72, 'background', '[\"stores\\/background-2.jpg\"]', 4, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(73, 'socials', '[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]', 4, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(74, 'background', '[\"stores\\/background-1.jpg\"]', 5, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(75, 'socials', '[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]', 5, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(76, 'background', '[\"stores\\/background-2.jpg\"]', 6, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(77, 'socials', '[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]', 6, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(78, 'background', '[\"stores\\/background-2.jpg\"]', 7, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(79, 'socials', '[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]', 7, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(80, 'background', '[\"stores\\/background-2.jpg\"]', 8, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(81, 'socials', '[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]', 8, 'Botble\\Marketplace\\Models\\Store', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(82, 'tablet_image', '[\"sliders\\/01.jpg\"]', 1, 'Botble\\SimpleSlider\\Models\\SimpleSliderItem', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(83, 'mobile_image', '[\"sliders\\/01-sm.jpg\"]', 1, 'Botble\\SimpleSlider\\Models\\SimpleSliderItem', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(84, 'tablet_image', '[\"sliders\\/02.jpg\"]', 2, 'Botble\\SimpleSlider\\Models\\SimpleSliderItem', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(85, 'mobile_image', '[\"sliders\\/02-sm.jpg\"]', 2, 'Botble\\SimpleSlider\\Models\\SimpleSliderItem', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(86, 'seo_meta', '[{\"index\":\"index\"}]', 1, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:18:03', '2024-09-20 02:18:03'),
(87, 'seo_meta', '[{\"index\":\"index\"}]', 2, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:18:46', '2024-09-20 02:18:46'),
(88, 'seo_meta', '[{\"index\":\"index\"}]', 3, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:19:05', '2024-09-20 02:19:05'),
(89, 'seo_meta', '[{\"index\":\"index\"}]', 4, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:19:23', '2024-09-20 02:19:23'),
(90, 'seo_meta', '[{\"index\":\"index\"}]', 5, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:19:41', '2024-09-20 02:19:41'),
(91, 'seo_meta', '[{\"index\":\"index\"}]', 6, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:20:10', '2024-09-20 02:20:10'),
(92, 'seo_meta', '[{\"index\":\"index\"}]', 7, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:20:29', '2024-09-20 02:20:29'),
(93, 'seo_meta', '[{\"index\":\"index\"}]', 8, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:26:33', '2024-09-20 02:26:33'),
(94, 'seo_meta', '[{\"index\":\"index\"}]', 9, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:26:52', '2024-09-20 02:26:52'),
(95, 'seo_meta', '[{\"index\":\"index\"}]', 10, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:27:27', '2024-09-20 02:27:27'),
(96, 'seo_meta', '[{\"index\":\"index\"}]', 11, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:27:48', '2024-09-20 02:27:48'),
(97, 'seo_meta', '[{\"index\":\"index\"}]', 12, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:28:10', '2024-09-20 02:28:10'),
(98, 'seo_meta', '[{\"index\":\"index\"}]', 13, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:28:38', '2024-09-20 02:28:38'),
(99, 'seo_meta', '[{\"index\":\"index\"}]', 14, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:29:24', '2024-09-20 02:29:24'),
(100, 'seo_meta', '[{\"index\":\"index\"}]', 15, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:29:47', '2024-09-20 02:29:47'),
(101, 'seo_meta', '[{\"index\":\"index\"}]', 16, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:30:12', '2024-09-20 02:30:12'),
(102, 'seo_meta', '[{\"index\":\"index\"}]', 17, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:30:44', '2024-09-20 02:30:44'),
(103, 'seo_meta', '[{\"index\":\"index\"}]', 18, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:31:12', '2024-09-20 02:31:12'),
(104, 'seo_meta', '[{\"index\":\"index\"}]', 19, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:31:34', '2024-09-20 02:31:34'),
(105, 'seo_meta', '[{\"index\":\"index\"}]', 20, 'Botble\\Ecommerce\\Models\\ProductCategory', '2024-09-20 02:31:59', '2024-09-20 02:31:59'),
(106, 'seo_meta', '[{\"index\":\"index\"}]', 1, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 03:41:50', '2024-09-20 03:41:50'),
(108, 'seo_meta', '[{\"index\":\"index\"}]', 3, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 03:52:55', '2024-09-20 03:52:55'),
(110, 'seo_meta', '[{\"index\":\"index\"}]', 4, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 03:57:35', '2024-09-20 03:57:35'),
(111, 'seo_meta', '[{\"index\":\"index\"}]', 5, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:07:24', '2024-09-20 04:07:24'),
(112, 'seo_meta', '[{\"index\":\"index\"}]', 6, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:08:22', '2024-09-20 04:08:22'),
(113, 'seo_meta', '[{\"index\":\"index\"}]', 7, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:11:29', '2024-09-20 04:11:29'),
(114, 'seo_meta', '[{\"index\":\"index\"}]', 8, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:12:36', '2024-09-20 04:12:36'),
(115, 'seo_meta', '[{\"index\":\"index\"}]', 9, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:13:32', '2024-09-20 04:13:32'),
(116, 'seo_meta', '[{\"index\":\"index\"}]', 10, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:14:22', '2024-09-20 04:14:22'),
(117, 'seo_meta', '[{\"index\":\"index\"}]', 11, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:16:17', '2024-09-20 04:16:17'),
(118, 'seo_meta', '[{\"index\":\"index\"}]', 12, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:16:52', '2024-09-20 04:16:52'),
(119, 'seo_meta', '[{\"index\":\"index\"}]', 13, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:17:57', '2024-09-20 04:17:57'),
(120, 'seo_meta', '[{\"index\":\"index\"}]', 14, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:21:52', '2024-09-20 04:21:52'),
(121, 'seo_meta', '[{\"index\":\"index\"}]', 15, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:23:03', '2024-09-20 04:23:03'),
(122, 'seo_meta', '[{\"index\":\"index\"}]', 16, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:23:45', '2024-09-20 04:23:45'),
(123, 'seo_meta', '[{\"index\":\"index\"}]', 17, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:31:12', '2024-09-20 04:31:12'),
(124, 'seo_meta', '[{\"index\":\"index\"}]', 18, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:31:50', '2024-09-20 04:31:50'),
(125, 'seo_meta', '[{\"index\":\"index\"}]', 19, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:33:46', '2024-09-20 04:33:46'),
(126, 'seo_meta', '[{\"index\":\"index\"}]', 20, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:34:18', '2024-09-20 04:34:18'),
(127, 'seo_meta', '[{\"index\":\"index\"}]', 21, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:35:19', '2024-09-20 04:35:19'),
(128, 'seo_meta', '[{\"index\":\"index\"}]', 22, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 04:37:26', '2024-09-20 04:37:26'),
(129, 'seo_meta', '[{\"index\":\"index\"}]', 23, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 06:53:49', '2024-09-20 06:53:49'),
(131, 'seo_meta', '[{\"index\":\"index\"}]', 25, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 07:27:57', '2024-09-20 07:27:57'),
(132, 'seo_meta', '[{\"index\":\"index\"}]', 26, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 07:29:11', '2024-09-20 07:29:11'),
(133, 'seo_meta', '[{\"index\":\"index\"}]', 27, 'Botble\\Ecommerce\\Models\\Product', '2024-09-20 07:30:54', '2024-09-20 07:30:54');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2013_04_09_032329_create_base_tables', 1),
(2, '2013_04_09_062329_create_revisions_table', 1),
(3, '2014_10_12_000000_create_users_table', 1),
(4, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(5, '2016_06_10_230148_create_acl_tables', 1),
(6, '2016_06_14_230857_create_menus_table', 1),
(7, '2016_06_28_221418_create_pages_table', 1),
(8, '2016_10_05_074239_create_setting_table', 1),
(9, '2016_11_28_032840_create_dashboard_widget_tables', 1),
(10, '2016_12_16_084601_create_widgets_table', 1),
(11, '2017_05_09_070343_create_media_tables', 1),
(12, '2017_11_03_070450_create_slug_table', 1),
(13, '2019_01_05_053554_create_jobs_table', 1),
(14, '2019_08_19_000000_create_failed_jobs_table', 1),
(15, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(16, '2022_04_20_100851_add_index_to_media_table', 1),
(17, '2022_04_20_101046_add_index_to_menu_table', 1),
(18, '2022_07_10_034813_move_lang_folder_to_root', 1),
(19, '2022_08_04_051940_add_missing_column_expires_at', 1),
(20, '2022_09_01_000001_create_admin_notifications_tables', 1),
(21, '2022_10_14_024629_drop_column_is_featured', 1),
(22, '2022_11_18_063357_add_missing_timestamp_in_table_settings', 1),
(23, '2022_12_02_093615_update_slug_index_columns', 1),
(24, '2023_01_30_024431_add_alt_to_media_table', 1),
(25, '2023_02_16_042611_drop_table_password_resets', 1),
(26, '2023_04_23_005903_add_column_permissions_to_admin_notifications', 1),
(27, '2023_05_10_075124_drop_column_id_in_role_users_table', 1),
(28, '2023_08_21_090810_make_page_content_nullable', 1),
(29, '2023_09_14_021936_update_index_for_slugs_table', 1),
(30, '2023_12_07_095130_add_color_column_to_media_folders_table', 1),
(31, '2023_12_17_162208_make_sure_column_color_in_media_folders_nullable', 1),
(32, '2024_04_04_110758_update_value_column_in_user_meta_table', 1),
(33, '2024_05_04_030654_improve_social_links', 1),
(34, '2024_05_12_091229_add_column_visibility_to_table_media_files', 1),
(35, '2024_07_07_091316_fix_column_url_in_menu_nodes_table', 1),
(36, '2024_07_12_100000_change_random_hash_for_media', 1),
(37, '2020_11_18_150916_ads_create_ads_table', 2),
(38, '2021_12_02_035301_add_ads_translations_table', 2),
(39, '2023_04_17_062645_add_open_in_new_tab', 2),
(40, '2023_11_07_023805_add_tablet_mobile_image', 2),
(41, '2024_04_01_043317_add_google_adsense_slot_id_to_ads_table', 2),
(42, '2024_04_27_100730_improve_analytics_setting', 3),
(43, '2015_06_29_025744_create_audit_history', 4),
(44, '2023_11_14_033417_change_request_column_in_table_audit_histories', 4),
(45, '2015_06_18_033822_create_blog_table', 5),
(46, '2021_02_16_092633_remove_default_value_for_author_type', 5),
(47, '2021_12_03_030600_create_blog_translations', 5),
(48, '2022_04_19_113923_add_index_to_table_posts', 5),
(49, '2023_08_29_074620_make_column_author_id_nullable', 5),
(50, '2024_07_30_091615_fix_order_column_in_categories_table', 5),
(51, '2016_06_17_091537_create_contacts_table', 6),
(52, '2023_11_10_080225_migrate_contact_blacklist_email_domains_to_core', 6),
(53, '2024_03_20_080001_migrate_change_attribute_email_to_nullable_form_contacts_table', 6),
(54, '2024_03_25_000001_update_captcha_settings_for_contact', 6),
(55, '2024_04_19_063914_create_custom_fields_table', 6),
(56, '2020_03_05_041139_create_ecommerce_tables', 7),
(57, '2021_01_01_044147_ecommerce_create_flash_sale_table', 7),
(58, '2021_01_17_082713_add_column_is_featured_to_product_collections_table', 7),
(59, '2021_01_18_024333_add_zip_code_into_table_customer_addresses', 7),
(60, '2021_02_18_073505_update_table_ec_reviews', 7),
(61, '2021_03_10_024419_add_column_confirmed_at_to_table_ec_customers', 7),
(62, '2021_03_10_025153_change_column_tax_amount', 7),
(63, '2021_03_20_033103_add_column_availability_to_table_ec_products', 7),
(64, '2021_04_28_074008_ecommerce_create_product_label_table', 7),
(65, '2021_05_31_173037_ecommerce_create_ec_products_translations', 7),
(66, '2021_08_17_105016_remove_column_currency_id_in_some_tables', 7),
(67, '2021_08_30_142128_add_images_column_to_ec_reviews_table', 7),
(68, '2021_10_04_030050_add_column_created_by_to_table_ec_products', 7),
(69, '2021_10_05_122616_add_status_column_to_ec_customers_table', 7),
(70, '2021_11_03_025806_nullable_phone_number_in_ec_customer_addresses', 7),
(71, '2021_11_23_071403_correct_languages_for_product_variations', 7),
(72, '2021_11_28_031808_add_product_tags_translations', 7),
(73, '2021_12_01_031123_add_featured_image_to_ec_products', 7),
(74, '2022_01_01_033107_update_table_ec_shipments', 7),
(75, '2022_02_16_042457_improve_product_attribute_sets', 7),
(76, '2022_03_22_075758_correct_product_name', 7),
(77, '2022_04_19_113334_add_index_to_ec_products', 7),
(78, '2022_04_28_144405_remove_unused_table', 7),
(79, '2022_05_05_115015_create_ec_customer_recently_viewed_products_table', 7),
(80, '2022_05_18_143720_add_index_to_table_ec_product_categories', 7),
(81, '2022_06_16_095633_add_index_to_some_tables', 7),
(82, '2022_06_30_035148_create_order_referrals_table', 7),
(83, '2022_07_24_153815_add_completed_at_to_ec_orders_table', 7),
(84, '2022_08_14_032836_create_ec_order_returns_table', 7),
(85, '2022_08_14_033554_create_ec_order_return_items_table', 7),
(86, '2022_08_15_040324_add_billing_address', 7),
(87, '2022_08_30_091114_support_digital_products_table', 7),
(88, '2022_09_13_095744_create_options_table', 7),
(89, '2022_09_13_104347_create_option_value_table', 7),
(90, '2022_10_05_163518_alter_table_ec_order_product', 7),
(91, '2022_10_12_041517_create_invoices_table', 7),
(92, '2022_10_12_142226_update_orders_table', 7),
(93, '2022_10_13_024916_update_table_order_returns', 7),
(94, '2022_10_21_030830_update_columns_in_ec_shipments_table', 7),
(95, '2022_10_28_021046_update_columns_in_ec_shipments_table', 7),
(96, '2022_11_16_034522_update_type_column_in_ec_shipping_rules_table', 7),
(97, '2022_11_19_041643_add_ec_tax_product_table', 7),
(98, '2022_12_12_063830_update_tax_defadult_in_ec_tax_products_table', 7),
(99, '2022_12_17_041532_fix_address_in_order_invoice', 7),
(100, '2022_12_26_070329_create_ec_product_views_table', 7),
(101, '2023_01_04_033051_fix_product_categories', 7),
(102, '2023_01_09_050400_add_ec_global_options_translations_table', 7),
(103, '2023_01_10_093754_add_missing_option_value_id', 7),
(104, '2023_01_17_082713_add_column_barcode_and_cost_per_item_to_product_table', 7),
(105, '2023_01_26_021854_add_ec_customer_used_coupons_table', 7),
(106, '2023_02_08_015900_update_options_column_in_ec_order_product_table', 7),
(107, '2023_02_27_095752_remove_duplicate_reviews', 7),
(108, '2023_03_20_115757_add_user_type_column_to_ec_shipment_histories_table', 7),
(109, '2023_04_21_082427_create_ec_product_categorizables_table', 7),
(110, '2023_05_03_011331_add_missing_column_price_into_invoice_items_table', 7),
(111, '2023_05_17_025812_fix_invoice_issue', 7),
(112, '2023_05_26_073140_move_option_make_phone_field_optional_at_checkout_page_to_mandatory_fields', 7),
(113, '2023_05_27_144611_fix_exchange_rate_setting', 7),
(114, '2023_06_22_084331_add_generate_license_code_to_ec_products_table', 7),
(115, '2023_06_30_042512_create_ec_order_tax_information_table', 7),
(116, '2023_07_14_022724_remove_column_id_from_ec_product_collection_products', 7),
(117, '2023_08_09_012940_remove_column_status_in_ec_product_attributes', 7),
(118, '2023_08_15_064505_create_ec_tax_rules_table', 7),
(119, '2023_08_21_021819_make_column_address_in_ec_customer_addresses_nullable', 7),
(120, '2023_08_22_094114_drop_unique_for_barcode', 7),
(121, '2023_08_30_031811_add_apply_via_url_column_to_ec_discounts_table', 7),
(122, '2023_09_07_094312_add_index_to_product_sku_and_translations', 7),
(123, '2023_09_19_024955_create_discount_product_categories_table', 7),
(124, '2023_10_17_070728_add_icon_and_icon_image_to_product_categories_table', 7),
(125, '2023_11_22_154643_add_unique_in_table_ec_products_variations', 7),
(126, '2023_11_27_032313_add_price_columns_to_ec_product_cross_sale_relations_table', 7),
(127, '2023_12_06_023945_add_display_on_checkout_column_to_ec_discounts_table', 7),
(128, '2023_12_25_040604_ec_create_review_replies_table', 7),
(129, '2023_12_26_090340_add_private_notes_column_to_ec_customers_table', 7),
(130, '2024_01_16_070706_fix_translation_tables', 7),
(131, '2024_01_23_075227_add_proof_file_to_ec_orders_table', 7),
(132, '2024_03_26_041531_add_cancel_reason_to_ec_orders_table', 7),
(133, '2024_03_27_062402_create_ec_customer_deletion_requests_table', 7),
(134, '2024_03_29_042242_migrate_old_captcha_settings', 7),
(135, '2024_03_29_093946_create_ec_order_return_histories_table', 7),
(136, '2024_04_01_063523_add_customer_columns_to_ec_reviews_table', 7),
(137, '2024_04_15_092654_migrate_ecommerce_google_tag_manager_code_setting', 7),
(138, '2024_04_16_035713_add_min_max_order_quantity_columns_to_products_table', 7),
(139, '2024_05_07_073153_improve_table_wishlist', 7),
(140, '2024_05_07_093703_add_missing_zip_code_into_table_store_locators', 7),
(141, '2024_05_15_021503_fix_invoice_path', 7),
(142, '2024_06_20_160724_create_ec_shared_wishlists_table', 7),
(143, '2024_06_28_025104_add_notify_attachment_updated_column_to_ec_products_table', 7),
(144, '2024_07_03_030900_add_downloaded_at_column_to_ec_order_product_table', 7),
(145, '2024_07_14_071826_make_customer_email_nullable', 7),
(146, '2024_07_15_104916_add_video_media_column_to_ec_products_table', 7),
(147, '2024_07_26_052530_add_percentage_to_tax_rules_table', 7),
(148, '2018_07_09_221238_create_faq_table', 8),
(149, '2021_12_03_082134_create_faq_translations', 8),
(150, '2023_11_17_063408_add_description_column_to_faq_categories_table', 8),
(151, '2016_10_03_032336_create_languages_table', 9),
(152, '2023_09_14_022423_add_index_for_language_table', 9),
(153, '2021_10_25_021023_fix-priority-load-for-language-advanced', 10),
(154, '2021_12_03_075608_create_page_translations', 10),
(155, '2023_07_06_011444_create_slug_translations_table', 10),
(156, '2019_11_18_061011_create_country_table', 11),
(157, '2021_12_03_084118_create_location_translations', 11),
(158, '2021_12_03_094518_migrate_old_location_data', 11),
(159, '2021_12_10_034440_switch_plugin_location_to_use_language_advanced', 11),
(160, '2022_01_16_085908_improve_plugin_location', 11),
(161, '2022_08_04_052122_delete_location_backup_tables', 11),
(162, '2023_04_23_061847_increase_state_translations_abbreviation_column', 11),
(163, '2023_07_26_041451_add_more_columns_to_location_table', 11),
(164, '2023_07_27_041451_add_more_columns_to_location_translation_table', 11),
(165, '2023_08_15_073307_drop_unique_in_states_cities_translations', 11),
(166, '2023_10_21_065016_make_state_id_in_table_cities_nullable', 11),
(167, '2021_07_06_030002_create_marketplace_table', 12),
(168, '2021_09_04_150137_add_vendor_verified_at_to_ec_customers_table', 12),
(169, '2021_10_04_033903_add_column_approved_by_into_table_ec_products', 12),
(170, '2021_10_06_124943_add_transaction_id_column_to_mp_customer_withdrawals_table', 12),
(171, '2021_10_10_054216_add_columns_to_mp_customer_revenues_table', 12),
(172, '2021_12_06_031304_update_table_mp_customer_revenues', 12),
(173, '2022_10_19_152916_add_columns_to_mp_stores_table', 12),
(174, '2022_10_20_062849_create_mp_category_sale_commissions_table', 12),
(175, '2022_11_02_071413_add_more_info_for_store', 12),
(176, '2022_11_02_080444_add_tax_info', 12),
(177, '2023_02_01_062030_add_store_translations', 12),
(178, '2023_02_13_032133_update_fee_column_mp_customer_revenues_table', 12),
(179, '2023_02_17_023648_fix_store_prefix', 12),
(180, '2024_04_03_062451_add_cover_image_to_table_mp_stores', 12),
(181, '2024_05_07_082630_create_mp_messages_table', 12),
(182, '2024_07_19_131849_add_documents_to_mp_stores_table', 12),
(183, '2017_10_24_154832_create_newsletter_table', 13),
(184, '2024_03_25_000001_update_captcha_settings_for_newsletter', 13),
(185, '2017_05_18_080441_create_payment_tables', 14),
(186, '2021_03_27_144913_add_customer_type_into_table_payments', 14),
(187, '2021_05_24_034720_make_column_currency_nullable', 14),
(188, '2021_08_09_161302_add_metadata_column_to_payments_table', 14),
(189, '2021_10_19_020859_update_metadata_field', 14),
(190, '2022_06_28_151901_activate_paypal_stripe_plugin', 14),
(191, '2022_07_07_153354_update_charge_id_in_table_payments', 14),
(192, '2024_07_04_083133_create_payment_logs_table', 14),
(193, '2017_07_11_140018_create_simple_slider_table', 15),
(194, '2016_10_07_193005_create_translations_table', 16),
(195, '2023_12_12_105220_drop_translations_table', 16);

-- --------------------------------------------------------

--
-- Table structure for table `mp_category_sale_commissions`
--

CREATE TABLE `mp_category_sale_commissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_category_id` bigint(20) UNSIGNED NOT NULL,
  `commission_percentage` decimal(8,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mp_customer_revenues`
--

CREATE TABLE `mp_customer_revenues` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sub_amount` decimal(15,2) DEFAULT 0.00,
  `fee` decimal(15,2) DEFAULT 0.00,
  `amount` decimal(15,2) DEFAULT 0.00,
  `current_balance` decimal(15,2) DEFAULT 0.00,
  `currency` varchar(120) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `type` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mp_customer_withdrawals`
--

CREATE TABLE `mp_customer_withdrawals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fee` decimal(15,2) UNSIGNED DEFAULT 0.00,
  `amount` decimal(15,2) UNSIGNED DEFAULT 0.00,
  `current_balance` decimal(15,2) UNSIGNED DEFAULT 0.00,
  `currency` varchar(120) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `bank_info` text DEFAULT NULL,
  `payment_channel` varchar(60) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'pending',
  `images` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `transaction_id` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mp_messages`
--

CREATE TABLE `mp_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `store_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mp_stores`
--

CREATE TABLE `mp_stores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `logo` varchar(191) DEFAULT NULL,
  `cover_image` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `vendor_verified_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `company` varchar(191) DEFAULT NULL,
  `certificate_file` varchar(191) DEFAULT NULL,
  `government_id_file` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mp_stores`
--

INSERT INTO `mp_stores` (`id`, `name`, `email`, `phone`, `address`, `country`, `state`, `city`, `customer_id`, `logo`, `cover_image`, `description`, `content`, `status`, `vendor_verified_at`, `created_at`, `updated_at`, `zip_code`, `company`, `certificate_file`, `government_id_file`) VALUES
(1, 'GoPro', 'mcdermott.tyrique@example.net', '+18063992565', '38239 Hermann Road Suite 621', 'JM', 'Rhode Island', 'East Herbertberg', 2, 'stores/1.png', NULL, 'Sint ad tempora dignissimos dolorem. Reiciendis quod aspernatur quam vero unde nesciunt. Laudantium molestias dolorem perferendis explicabo. Iure voluptatem eum commodi dolore libero. Autem est optio qui ut eius. Quos assumenda necessitatibus aut nobis harum architecto. Corporis impedit quo eius ea officia quisquam veritatis. Deserunt aperiam dolorem ad.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n', 'published', NULL, '2024-08-05 02:26:35', '2024-08-05 02:26:35', NULL, NULL, NULL, NULL),
(2, 'Global Office', 'mante.devon@example.org', '+16017130209', '190 Conn Trail', 'CH', 'Utah', 'West Albinaberg', 6, 'stores/2.png', NULL, 'Corrupti id quasi expedita sit explicabo. Non saepe aspernatur pariatur odio fugit. Ex repellendus natus aut. Dolorum quisquam aut sunt dignissimos quod. Quidem ipsum itaque voluptatem aut numquam. Voluptate delectus at nam consequatur. Tempore pariatur a et qui consequatur.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n', 'published', NULL, '2024-08-05 02:26:35', '2024-08-05 02:26:35', NULL, NULL, NULL, NULL),
(3, 'Young Shop', 'cayla.schroeder@example.com', '+15202506752', '450 Carolina Green Suite 304', 'DM', 'Michigan', 'Monahanbury', 6, 'stores/3.png', NULL, 'Cupiditate aperiam odit aliquid id sit voluptate. Culpa non nemo culpa officia sed vero consequatur. Eveniet eligendi qui voluptatibus eum autem at sed. Quia qui et autem. Atque consequatur et sequi eos voluptas odio in et. Perferendis eaque nostrum ad placeat qui at odit. Illo cupiditate aut eos sed sit et assumenda. Delectus odit velit iste eos deserunt quam architecto.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n', 'published', NULL, '2024-08-05 02:26:35', '2024-08-05 02:26:35', NULL, NULL, NULL, NULL),
(4, 'Global Store', 'cathrine.walsh@example.net', '+14705767454', '455 Katrine Mount Apt. 335', 'VG', 'Idaho', 'Altenwerthberg', 8, 'stores/4.png', NULL, 'Consequatur omnis minima consectetur in non mollitia consectetur. Eum nostrum et repellendus quis facilis voluptas ea. Dolores itaque vitae voluptate aut maiores. Sint libero adipisci velit excepturi et. Eligendi tenetur officia commodi. Alias eum culpa quia mollitia. Quia ut molestiae molestiae numquam.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n', 'published', NULL, '2024-08-05 02:26:35', '2024-08-05 02:26:35', NULL, NULL, NULL, NULL),
(5, 'Robert’s Store', 'adell70@example.com', '+19203450291', '6637 Marvin Knolls', 'EH', 'New York', 'Lake Justynview', 3, 'stores/5.png', NULL, 'Quod voluptatem tempora voluptatem molestiae qui consectetur. Molestiae distinctio ducimus dignissimos optio nihil esse culpa. Eos quis quibusdam adipisci. Aperiam excepturi sunt id vel similique quo numquam. Voluptatem ut neque rerum nobis voluptatem illo nobis praesentium. Quod repellendus nam iste eum esse voluptatum assumenda. Dolores repellat quia sed ab.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n', 'published', NULL, '2024-08-05 02:26:35', '2024-08-05 02:26:35', NULL, NULL, NULL, NULL),
(6, 'Stouffer', 'glover.alexandre@example.net', '+19163005272', '68105 Jenkins Coves Suite 613', 'TH', 'Idaho', 'Boyerborough', 2, 'stores/6.png', NULL, 'Consequuntur ut enim laborum. Rerum dolor temporibus molestiae dolor et nesciunt sint. Facilis deleniti ipsa voluptate quaerat eaque ad. Necessitatibus adipisci odio neque facere sint in id optio. Aut molestiae debitis aut minus officia sunt molestias qui. Iusto accusantium facere quia doloremque sit. Iure quia quae consequuntur velit. Vel illo ea voluptate consequuntur.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n', 'published', NULL, '2024-08-05 02:26:35', '2024-08-05 02:26:35', NULL, NULL, NULL, NULL),
(7, 'StarKist', 'otha01@example.net', '+18457345052', '701 Johns Manor Suite 292', 'BB', 'Alabama', 'South Devynville', 8, 'stores/7.png', NULL, 'Necessitatibus rem occaecati quasi qui. Aut commodi facilis eum modi quae temporibus. Recusandae quas quo quia ad. Et enim vel impedit voluptatibus facere. Aspernatur minus ut sequi molestiae ea sed. Assumenda eligendi quaerat optio in excepturi placeat. Eos omnis et eius in dolores quibusdam. Maiores expedita molestias vitae et qui voluptas.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n', 'published', NULL, '2024-08-05 02:26:35', '2024-08-05 02:26:35', NULL, NULL, NULL, NULL),
(8, 'Old El Paso', 'stroman.mayra@example.org', '+14309337542', '730 Jannie Center', 'LS', 'Delaware', 'South Matt', 7, 'stores/8.png', NULL, 'Aliquid iste illo voluptatem. Sit in voluptatem expedita quibusdam necessitatibus ut. Placeat id sint ut. Hic similique qui quasi sint laborum. Ea voluptatem placeat pariatur qui voluptatibus nulla. Velit et et ut necessitatibus. Vel aut accusamus tenetur minima.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n', 'published', NULL, '2024-08-05 02:26:35', '2024-08-05 02:26:35', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mp_stores_translations`
--

CREATE TABLE `mp_stores_translations` (
  `lang_code` varchar(191) NOT NULL,
  `mp_stores_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `company` varchar(191) DEFAULT NULL,
  `cover_image` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mp_vendor_info`
--

CREATE TABLE `mp_vendor_info` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_fee` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_revenue` decimal(15,2) NOT NULL DEFAULT 0.00,
  `signature` varchar(191) DEFAULT NULL,
  `bank_info` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payout_payment_method` varchar(120) DEFAULT 'bank_transfer',
  `tax_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mp_vendor_info`
--

INSERT INTO `mp_vendor_info` (`id`, `customer_id`, `balance`, `total_fee`, `total_revenue`, `signature`, `bank_info`, `created_at`, `updated_at`, `payout_payment_method`, `tax_info`) VALUES
(1, 2, 0.00, 0.00, 0.00, '$2y$12$4rxTI7744qA1/7whxZOc..mWOTZk6uMaZk.QpsFeTZMITXmDm2Pjy', '{\"name\":\"Ms. Mabel Kovacek PhD\",\"number\":\"+15517556975\",\"full_name\":\"Prof. Keenan Wilderman DDS\",\"description\":\"Nayeli Olson\"}', '2024-08-05 02:26:33', '2024-08-05 02:26:33', 'bank_transfer', NULL),
(2, 3, 0.00, 0.00, 0.00, '$2y$12$ooWBF0pJK1uMkMU9vdIDtOgTxy98u5yIWOYlRuA4NJcYs4arY1ZaG', '{\"name\":\"Ms. Dixie Gottlieb\",\"number\":\"+18549935084\",\"full_name\":\"Graciela Emmerich\",\"description\":\"Carole Gaylord\"}', '2024-08-05 02:26:34', '2024-08-05 02:26:34', 'bank_transfer', NULL),
(3, 4, 0.00, 0.00, 0.00, '$2y$12$9KHXO1ayF8PsoufU6McyF.FuizK9nSzdyaoZlUN5j0kC/6Pk89Zwa', '{\"name\":\"Dixie Hickle Sr.\",\"number\":\"+17609711625\",\"full_name\":\"Prof. Elmer Schmitt\",\"description\":\"Dr. Kareem Marquardt\"}', '2024-08-05 02:26:34', '2024-08-05 02:26:34', 'bank_transfer', NULL),
(4, 5, 0.00, 0.00, 0.00, '$2y$12$X5irK4UAHi9K5UtSvJ6uQeABGeq40k3ZodXLTMX4Uhfmcz/aoljAG', '{\"name\":\"Mrs. Alisha Altenwerth\",\"number\":\"+15754961207\",\"full_name\":\"Rafael Lindgren II\",\"description\":\"Luisa Botsford\"}', '2024-08-05 02:26:34', '2024-08-05 02:26:34', 'bank_transfer', NULL),
(5, 6, 0.00, 0.00, 0.00, '$2y$12$XOTPWK93f37GRvfSXcpr5OCNaE9wHPNP/1enkdHzXhXMdb6Yv/266', '{\"name\":\"Iva Sauer\",\"number\":\"+12488494177\",\"full_name\":\"Bret Jones\",\"description\":\"Sharon O\'Reilly\"}', '2024-08-05 02:26:35', '2024-08-05 02:26:35', 'bank_transfer', NULL),
(6, 7, 0.00, 0.00, 0.00, '$2y$12$ZPjgr6jrwECNH1CFxSo4n.yDD9vP7Gx7VY7.m6SRoI/7OZtv6fRZS', '{\"name\":\"Mr. Lloyd Robel II\",\"number\":\"+12052430990\",\"full_name\":\"Elsie Medhurst\",\"description\":\"Dr. Mikayla Kunde\"}', '2024-08-05 02:26:35', '2024-08-05 02:26:35', 'bank_transfer', NULL),
(7, 8, 0.00, 0.00, 0.00, '$2y$12$8OE942vpdEtTxGb7H2VpMerv979vzVFDiQu.I.4nuSFrl87F.gEYW', '{\"name\":\"Sydni Kautzer\",\"number\":\"+13803481210\",\"full_name\":\"Mr. Esteban Walsh Sr.\",\"description\":\"Jack Conn\"}', '2024-08-05 02:26:35', '2024-08-05 02:26:35', 'bank_transfer', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

CREATE TABLE `newsletters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(120) NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'subscribed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `content` longtext DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `template` varchar(60) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `name`, `content`, `user_id`, `image`, `template`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Home', '<div>[simple-slider key=\"home-slider\" is_autoplay=\"yes\" autoplay_speed=\"5000\" ads=\"VC2C8Q1UGCBG\" background=\"general/slider-bg.jpg\"][/simple-slider]</div><div>[featured-product-categories title=\"Browse by Category\"][/featured-product-categories]</div><div>[featured-brands title=\"Featured Brands\"][/featured-brands]</div><div>[flash-sale title=\"Top Saver Today\" flash_sale_id=\"1\"][/flash-sale]</div><div>[product-category-products title=\"Just Landing\" category_id=\"23\"][/product-category-products]</div><div>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\"][/theme-ads]</div><div>[featured-products title=\"Featured products\"][/featured-products]</div><div>[product-collections title=\"Essential Products\"][/product-collections]</div><div>[product-category-products category_id=\"18\"][/product-category-products]</div><div>[featured-posts title=\"Health Daily\" background=\"general/blog-bg.jpg\"\n                        app_enabled=\"1\"\n                        app_title=\"Shop faster with Farmart App\"\n                        app_description=\"Available on both iOS & Android\"\n                        app_bg=\"general/app-bg.png\"\n                        app_android_img=\"general/app-android.png\"\n                        app_android_link=\"#\"\n                        app_ios_img=\"general/app-ios.png\"\n                        app_ios_link=\"#\"][/featured-posts]</div>', 1, NULL, 'homepage', NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(2, 'About us', NULL, 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(3, 'Terms Of Use', NULL, 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(4, 'Terms &amp; Conditions', NULL, 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(5, 'Refund Policy', NULL, 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(6, 'Blog', '<p>---</p>', 1, NULL, 'full-width', NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(7, 'FAQs', '<div>[faq title=\"Frequently Asked Questions\"][/faq]</div>', 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(8, 'Contact', '<div>[google-map]502 New Street, Brighton VIC, Australia[/google-map]</div><div>[contact-info-boxes title=\"Contact Info\" subtitle=\"Location\" name_1=\"Store\" address_1=\"68 Atlantic Ave St, Brooklyn, NY 90002, USA\" phone_1=\"(+005) 5896 72 78 79\" email_1=\"support@farmart.com\" name_2=\"Warehouse\" address_2=\"172 Richmond Hill Ave St, Stamford, NY 90002, USA\" phone_2=\"(+005) 5896 03 04 05\" show_contact_form=\"1\" ][/contact-info-boxes]</div>', 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(9, 'Cookie Policy', '<h3>EU Cookie Consent</h3><p>To use this Website we are using Cookies and collecting some Data. To be compliant with the EU GDPR we give you to choose if you allow us to use certain Cookies and to collect some Data.</p><h4>Essential Data</h4><p>The Essential Data is needed to run the Site you are visiting technically. You can not deactivate them.</p><p>- Session Cookie: PHP uses a Cookie to identify user sessions. Without this Cookie the Website is not working.</p><p>- XSRF-Token Cookie: Laravel automatically generates a CSRF \"token\" for each active user session managed by the application. This token is used to verify that the authenticated user is the one actually making the requests to the application.</p>', 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(10, 'Affiliate', NULL, 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(11, 'Career', NULL, 1, NULL, NULL, NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(12, 'Coming soon', '<div>[coming-soon time=\"2025-08-05 09:26:37\" title=\"We’re coming soon.\" subtitle=\"Currently we’re working on our brand new website and will be\nlaunching soon.\" social_title=\"Connect us on social networks\" image=\"general/coming-soon.jpg\"][/coming-soon]</div>', 1, NULL, 'coming-soon', NULL, 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37');

-- --------------------------------------------------------

--
-- Table structure for table `pages_translations`
--

CREATE TABLE `pages_translations` (
  `lang_code` varchar(20) NOT NULL,
  `pages_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency` varchar(120) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `charge_id` varchar(191) DEFAULT NULL,
  `payment_channel` varchar(60) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `amount` decimal(15,2) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(60) DEFAULT 'pending',
  `payment_type` varchar(191) DEFAULT 'confirm',
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `refunded_amount` decimal(15,2) UNSIGNED DEFAULT NULL,
  `refund_note` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_type` varchar(191) DEFAULT NULL,
  `metadata` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `currency`, `user_id`, `charge_id`, `payment_channel`, `description`, `amount`, `order_id`, `status`, `payment_type`, `customer_id`, `refunded_amount`, `refund_note`, `created_at`, `updated_at`, `customer_type`, `metadata`) VALUES
(1, 'USD', 1, '123456789', 'paytabs', NULL, 443.00, 1, 'completed', 'confirm', 1, NULL, NULL, '2024-09-20 07:38:24', '2024-09-20 07:38:24', 'Botble\\Ecommerce\\Models\\Customer', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_logs`
--

CREATE TABLE `payment_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_method` varchar(191) NOT NULL,
  `request` longtext DEFAULT NULL,
  `response` longtext DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `author_id` bigint(20) UNSIGNED DEFAULT NULL,
  `author_type` varchar(191) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `is_featured` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `image` varchar(191) DEFAULT NULL,
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `format_type` varchar(30) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `name`, `description`, `content`, `status`, `author_id`, `author_type`, `is_featured`, `image`, `views`, `format_type`, `created_at`, `updated_at`) VALUES
(1, '4 Expert Tips On How To Choose The Right Men’s Wallet', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/1.jpg', 1208, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(2, 'Sexy Clutches: How to Buy &amp; Wear a Designer Clutch Bag', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/2.jpg', 831, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(3, 'The Top 2020 Handbag Trends to Know', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/3.jpg', 127, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(4, 'How to Match the Color of Your Handbag With an Outfit', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/4.jpg', 1936, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(5, 'How to Care for Leather Bags', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/5.jpg', 2447, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(6, 'We\'re Crushing Hard on Summer\'s 10 Biggest Bag Trends', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/6.jpg', 1511, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(7, 'Essential Qualities of Highly Successful Music', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/7.jpg', 2256, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(8, '9 Things I Love About Shaving My Head', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/8.jpg', 702, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(9, 'Why Teamwork Really Makes The Dream Work', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/9.jpg', 2037, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(10, 'The World Caters to Average People', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 1, 'news/10.jpg', 323, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36');
INSERT INTO `posts` (`id`, `name`, `description`, `content`, `status`, `author_id`, `author_type`, `is_featured`, `image`, `views`, `format_type`, `created_at`, `updated_at`) VALUES
(11, 'The litigants on the screen are not actors', 'You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.', '<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n', 'published', 1, 'Botble\\ACL\\Models\\User', 0, 'news/11.jpg', 1597, NULL, '2024-08-05 02:26:36', '2024-08-05 02:26:36');

-- --------------------------------------------------------

--
-- Table structure for table `posts_translations`
--

CREATE TABLE `posts_translations` (
  `lang_code` varchar(20) NOT NULL,
  `posts_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_categories`
--

CREATE TABLE `post_categories` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_categories`
--

INSERT INTO `post_categories` (`category_id`, `post_id`) VALUES
(1, 1),
(3, 1),
(1, 2),
(3, 2),
(1, 3),
(3, 3),
(2, 4),
(3, 4),
(1, 5),
(4, 5),
(2, 6),
(4, 6),
(2, 7),
(4, 7),
(1, 8),
(3, 8),
(1, 9),
(3, 9),
(1, 10),
(3, 10),
(2, 11),
(3, 11);

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_tags`
--

INSERT INTO `post_tags` (`tag_id`, `post_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(1, 4),
(2, 4),
(3, 4),
(4, 4),
(5, 4),
(1, 5),
(2, 5),
(3, 5),
(4, 5),
(5, 5),
(1, 6),
(2, 6),
(3, 6),
(4, 6),
(5, 6),
(1, 7),
(2, 7),
(3, 7),
(4, 7),
(5, 7),
(1, 8),
(2, 8),
(3, 8),
(4, 8),
(5, 8),
(1, 9),
(2, 9),
(3, 9),
(4, 9),
(5, 9),
(1, 10),
(2, 10),
(3, 10),
(4, 10),
(5, 10),
(1, 11),
(2, 11),
(3, 11),
(4, 11),
(5, 11);

-- --------------------------------------------------------

--
-- Table structure for table `revisions`
--

CREATE TABLE `revisions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `revisionable_type` varchar(191) NOT NULL,
  `revisionable_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `key` varchar(120) NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(120) NOT NULL,
  `name` varchar(120) NOT NULL,
  `permissions` text DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `updated_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `slug`, `name`, `permissions`, `description`, `is_default`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', '{\"users.index\":true,\"users.create\":true,\"users.edit\":true,\"users.destroy\":true,\"roles.index\":true,\"roles.create\":true,\"roles.edit\":true,\"roles.destroy\":true,\"core.system\":true,\"core.cms\":true,\"core.manage.license\":true,\"systems.cronjob\":true,\"core.tools\":true,\"tools.data-synchronize\":true,\"media.index\":true,\"files.index\":true,\"files.create\":true,\"files.edit\":true,\"files.trash\":true,\"files.destroy\":true,\"folders.index\":true,\"folders.create\":true,\"folders.edit\":true,\"folders.trash\":true,\"folders.destroy\":true,\"settings.index\":true,\"settings.common\":true,\"settings.options\":true,\"settings.email\":true,\"settings.media\":true,\"settings.admin-appearance\":true,\"settings.cache\":true,\"settings.datatables\":true,\"settings.email.rules\":true,\"settings.others\":true,\"menus.index\":true,\"menus.create\":true,\"menus.edit\":true,\"menus.destroy\":true,\"optimize.settings\":true,\"pages.index\":true,\"pages.create\":true,\"pages.edit\":true,\"pages.destroy\":true,\"plugins.index\":true,\"plugins.edit\":true,\"plugins.remove\":true,\"plugins.marketplace\":true,\"core.appearance\":true,\"theme.index\":true,\"theme.activate\":true,\"theme.remove\":true,\"theme.options\":true,\"theme.custom-css\":true,\"theme.custom-js\":true,\"theme.custom-html\":true,\"theme.robots-txt\":true,\"settings.website-tracking\":true,\"widgets.index\":true,\"ads.index\":true,\"ads.create\":true,\"ads.edit\":true,\"ads.destroy\":true,\"ads.settings\":true,\"analytics.general\":true,\"analytics.page\":true,\"analytics.browser\":true,\"analytics.referrer\":true,\"analytics.settings\":true,\"audit-log.index\":true,\"audit-log.destroy\":true,\"backups.index\":true,\"backups.create\":true,\"backups.restore\":true,\"backups.destroy\":true,\"plugins.blog\":true,\"posts.index\":true,\"posts.create\":true,\"posts.edit\":true,\"posts.destroy\":true,\"categories.index\":true,\"categories.create\":true,\"categories.edit\":true,\"categories.destroy\":true,\"tags.index\":true,\"tags.create\":true,\"tags.edit\":true,\"tags.destroy\":true,\"blog.settings\":true,\"posts.export\":true,\"posts.import\":true,\"captcha.settings\":true,\"contacts.index\":true,\"contacts.edit\":true,\"contacts.destroy\":true,\"contact.settings\":true,\"plugins.ecommerce\":true,\"ecommerce.report.index\":true,\"products.index\":true,\"products.create\":true,\"products.edit\":true,\"products.destroy\":true,\"products.duplicate\":true,\"ecommerce.product-prices.index\":true,\"ecommerce.product-prices.edit\":true,\"ecommerce.product-inventory.index\":true,\"ecommerce.product-inventory.edit\":true,\"product-categories.index\":true,\"product-categories.create\":true,\"product-categories.edit\":true,\"product-categories.destroy\":true,\"product-tag.index\":true,\"product-tag.create\":true,\"product-tag.edit\":true,\"product-tag.destroy\":true,\"brands.index\":true,\"brands.create\":true,\"brands.edit\":true,\"brands.destroy\":true,\"product-collections.index\":true,\"product-collections.create\":true,\"product-collections.edit\":true,\"product-collections.destroy\":true,\"product-attribute-sets.index\":true,\"product-attribute-sets.create\":true,\"product-attribute-sets.edit\":true,\"product-attribute-sets.destroy\":true,\"product-attributes.index\":true,\"product-attributes.create\":true,\"product-attributes.edit\":true,\"product-attributes.destroy\":true,\"tax.index\":true,\"tax.create\":true,\"tax.edit\":true,\"tax.destroy\":true,\"reviews.index\":true,\"reviews.create\":true,\"reviews.destroy\":true,\"reviews.publish\":true,\"reviews.reply\":true,\"ecommerce.shipments.index\":true,\"ecommerce.shipments.create\":true,\"ecommerce.shipments.edit\":true,\"ecommerce.shipments.destroy\":true,\"orders.index\":true,\"orders.create\":true,\"orders.edit\":true,\"orders.destroy\":true,\"discounts.index\":true,\"discounts.create\":true,\"discounts.edit\":true,\"discounts.destroy\":true,\"customers.index\":true,\"customers.create\":true,\"customers.edit\":true,\"customers.destroy\":true,\"flash-sale.index\":true,\"flash-sale.create\":true,\"flash-sale.edit\":true,\"flash-sale.destroy\":true,\"product-label.index\":true,\"product-label.create\":true,\"product-label.edit\":true,\"product-label.destroy\":true,\"ecommerce.import.products.index\":true,\"ecommerce.export.products.index\":true,\"order_returns.index\":true,\"order_returns.edit\":true,\"order_returns.destroy\":true,\"global-option.index\":true,\"global-option.create\":true,\"global-option.edit\":true,\"global-option.destroy\":true,\"ecommerce.invoice.index\":true,\"ecommerce.invoice.edit\":true,\"ecommerce.invoice.destroy\":true,\"ecommerce.settings\":true,\"ecommerce.settings.general\":true,\"ecommerce.invoice-template.index\":true,\"ecommerce.settings.currencies\":true,\"ecommerce.settings.products\":true,\"ecommerce.settings.product-search\":true,\"ecommerce.settings.digital-products\":true,\"ecommerce.settings.store-locators\":true,\"ecommerce.settings.invoices\":true,\"ecommerce.settings.product-reviews\":true,\"ecommerce.settings.customers\":true,\"ecommerce.settings.shopping\":true,\"ecommerce.settings.taxes\":true,\"ecommerce.settings.shipping\":true,\"ecommerce.settings.tracking\":true,\"ecommerce.settings.standard-and-format\":true,\"ecommerce.settings.checkout\":true,\"ecommerce.settings.return\":true,\"ecommerce.settings.flash-sale\":true,\"product-categories.export\":true,\"product-categories.import\":true,\"plugin.faq\":true,\"faq.index\":true,\"faq.create\":true,\"faq.edit\":true,\"faq.destroy\":true,\"faq_category.index\":true,\"faq_category.create\":true,\"faq_category.edit\":true,\"faq_category.destroy\":true,\"faqs.settings\":true,\"languages.index\":true,\"languages.create\":true,\"languages.edit\":true,\"languages.destroy\":true,\"plugin.location\":true,\"country.index\":true,\"country.create\":true,\"country.edit\":true,\"country.destroy\":true,\"state.index\":true,\"state.create\":true,\"state.edit\":true,\"state.destroy\":true,\"city.index\":true,\"city.create\":true,\"city.edit\":true,\"city.destroy\":true,\"marketplace.index\":true,\"marketplace.store.index\":true,\"marketplace.store.create\":true,\"marketplace.store.edit\":true,\"marketplace.store.destroy\":true,\"marketplace.store.view\":true,\"marketplace.store.revenue.create\":true,\"marketplace.withdrawal.index\":true,\"marketplace.withdrawal.edit\":true,\"marketplace.withdrawal.destroy\":true,\"marketplace.withdrawal.invoice\":true,\"marketplace.vendors.index\":true,\"marketplace.unverified-vendors.index\":true,\"marketplace.unverified-vendors.edit\":true,\"marketplace.reports\":true,\"marketplace.settings\":true,\"newsletter.index\":true,\"newsletter.destroy\":true,\"newsletter.settings\":true,\"payment.index\":true,\"payments.settings\":true,\"payment.destroy\":true,\"payments.logs\":true,\"payments.logs.show\":true,\"payments.logs.destroy\":true,\"simple-slider.index\":true,\"simple-slider.create\":true,\"simple-slider.edit\":true,\"simple-slider.destroy\":true,\"simple-slider-item.index\":true,\"simple-slider-item.create\":true,\"simple-slider-item.edit\":true,\"simple-slider-item.destroy\":true,\"simple-slider.settings\":true,\"social-login.settings\":true,\"plugins.translation\":true,\"translations.locales\":true,\"translations.theme-translations\":true,\"translations.index\":true,\"theme-translations.export\":true,\"other-translations.export\":true,\"theme-translations.import\":true,\"other-translations.import\":true}', 'Admin users role', 1, 1, 1, '2024-08-05 02:26:18', '2024-08-05 02:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `role_users`
--

CREATE TABLE `role_users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(2, 'api_enabled', '0', NULL, '2024-09-20 07:57:17'),
(3, 'activated_plugins', '[\"language\",\"language-advanced\",\"ads\",\"analytics\",\"audit-log\",\"backup\",\"blog\",\"captcha\",\"contact\",\"cookie-consent\",\"ecommerce\",\"faq\",\"location\",\"marketplace\",\"mollie\",\"newsletter\",\"payment\",\"paypal\",\"paypal-payout\",\"paystack\",\"razorpay\",\"shippo\",\"simple-slider\",\"social-login\",\"sslcommerz\",\"stripe\",\"translation\"]', NULL, '2024-09-20 07:57:17'),
(4, 'analytics_dashboard_widgets', '0', '2024-08-05 02:26:16', '2024-09-20 07:57:17'),
(5, 'enable_recaptcha_botble_contact_forms_fronts_contact_form', '1', '2024-08-05 02:26:16', '2024-09-20 07:57:17'),
(6, 'api_layer_api_key', '', NULL, '2024-09-20 07:57:17'),
(9, 'enable_recaptcha_botble_newsletter_forms_fronts_newsletter_form', '1', '2024-08-05 02:26:17', '2024-09-20 07:57:17'),
(12, 'language_hide_default', '1', NULL, '2024-09-20 07:57:17'),
(14, 'language_display', 'all', NULL, '2024-09-20 07:57:17'),
(15, 'language_hide_languages', '[]', NULL, '2024-09-20 07:57:17'),
(16, 'ecommerce_store_name', 'Farmart', NULL, '2024-09-20 07:57:17'),
(17, 'ecommerce_store_phone', '1800979769', NULL, '2024-09-20 07:57:17'),
(18, 'ecommerce_store_address', '502 New Street', NULL, '2024-09-20 07:57:17'),
(19, 'ecommerce_store_state', 'Brighton VIC', NULL, '2024-09-20 07:57:17'),
(20, 'ecommerce_store_city', 'Brighton VIC', NULL, '2024-09-20 07:57:17'),
(21, 'ecommerce_store_country', 'AU', NULL, '2024-09-20 07:57:17'),
(22, 'simple_slider_using_assets', '0', NULL, '2024-09-20 07:57:17'),
(23, 'media_random_hash', 'ab87ed30e617826404eec00889d1e458', NULL, '2024-09-20 07:57:17'),
(24, 'payment_cod_status', '1', NULL, '2024-09-20 07:57:18'),
(25, 'payment_bank_transfer_status', '1', NULL, '2024-09-20 07:57:18'),
(26, 'theme', 'farmart', NULL, '2024-09-20 07:57:18'),
(27, 'show_admin_bar', '1', NULL, '2024-09-20 07:57:18'),
(28, 'language_switcher_display', 'dropdown', NULL, '2024-09-20 07:57:18'),
(29, 'admin_favicon', 'general/favicon.png', NULL, '2024-09-20 07:57:18'),
(30, 'admin_logo', 'general/logo-light.png', NULL, '2024-09-20 07:57:18'),
(31, 'permalink-botble-blog-models-post', 'blog', NULL, '2024-09-20 07:57:18'),
(32, 'permalink-botble-blog-models-category', 'blog', NULL, '2024-09-20 07:57:18'),
(33, 'payment_cod_description', 'Please pay money directly to the postman, if you choose cash on delivery method (COD).', NULL, '2024-09-20 07:57:18'),
(34, 'payment_bank_transfer_description', 'Please send money to our bank account: ACB - 69270 213 19.', NULL, '2024-09-20 07:57:18'),
(35, 'payment_stripe_payment_type', 'stripe_checkout', NULL, '2024-09-20 07:57:18'),
(36, 'plugins_ecommerce_customer_new_order_status', '0', NULL, '2024-09-20 07:57:18'),
(37, 'plugins_ecommerce_admin_new_order_status', '0', NULL, '2024-09-20 07:57:18'),
(38, 'ecommerce_is_enabled_support_digital_products', '1', NULL, '2024-09-20 07:57:18'),
(39, 'ecommerce_load_countries_states_cities_from_location_plugin', '0', NULL, '2024-09-20 07:57:18'),
(40, 'payment_bank_transfer_display_bank_info_at_the_checkout_success_page', '1', NULL, '2024-09-20 07:57:18'),
(41, 'ecommerce_product_sku_format', 'FM-2443-%s%s%s%s', NULL, '2024-09-20 07:57:18'),
(42, 'theme-farmart-site_title', 'Farmart - Laravel Ecommerce system', NULL, '2024-09-20 07:57:18'),
(43, 'theme-farmart-seo_description', 'Farmart is a modern and flexible Multipurpose Marketplace Laravel script. This script is suited for electronic, organic and grocery store, furniture store, clothing store, hitech store and accessories store… With the theme, you can create your own marketplace and allow vendors to sell just like Amazon, Envato, eBay…', NULL, '2024-09-20 07:57:18'),
(44, 'theme-farmart-copyright', '© %Y Farmart. All Rights Reserved.', NULL, '2024-09-20 07:57:18'),
(45, 'theme-farmart-favicon', 'general/favicon.png', NULL, '2024-09-20 07:57:18'),
(46, 'theme-farmart-logo', 'general/logo.png', NULL, '2024-09-20 07:57:18'),
(47, 'theme-farmart-seo_og_image', 'general/open-graph-image.png', NULL, '2024-09-20 07:57:18'),
(48, 'theme-farmart-image-placeholder', 'general/placeholder.png', NULL, '2024-09-20 07:57:18'),
(49, 'theme-farmart-address', '502 New Street, Brighton VIC, Australia', NULL, '2024-09-20 07:57:19'),
(50, 'theme-farmart-hotline', '8 800 332 65-66', NULL, '2024-09-20 07:57:19'),
(51, 'theme-farmart-email', 'contact@fartmart.co', NULL, '2024-09-20 07:57:19'),
(52, 'theme-farmart-working_time', 'Mon - Fri: 07AM - 06PM', NULL, '2024-09-20 07:57:19'),
(53, 'theme-farmart-payment_methods_image', 'general/footer-payments.png', NULL, '2024-09-20 07:57:19'),
(54, 'theme-farmart-homepage_id', '1', NULL, '2024-09-20 07:57:19'),
(55, 'theme-farmart-blog_page_id', '6', NULL, '2024-09-20 07:57:19'),
(56, 'theme-farmart-cookie_consent_message', 'Your experience on this site will be improved by allowing cookies ', NULL, '2024-09-20 07:57:19'),
(57, 'theme-farmart-cookie_consent_learn_more_url', '/cookie-policy', NULL, '2024-09-20 07:57:19'),
(58, 'theme-farmart-cookie_consent_learn_more_text', 'Cookie Policy', NULL, '2024-09-20 07:57:19'),
(59, 'theme-farmart-number_of_products_per_page', '40', NULL, '2024-09-20 07:57:19'),
(60, 'theme-farmart-number_of_cross_sale_product', '6', NULL, '2024-09-20 07:57:19'),
(61, 'theme-farmart-logo_in_the_checkout_page', 'general/logo.png', NULL, '2024-09-20 07:57:19'),
(62, 'theme-farmart-logo_in_invoices', 'general/logo.png', NULL, '2024-09-20 07:57:19'),
(63, 'theme-farmart-logo_vendor_dashboard', 'general/logo.png', NULL, '2024-09-20 07:57:19'),
(64, 'theme-farmart-404_page_image', 'general/404.png', NULL, '2024-09-20 07:57:19'),
(65, 'theme-farmart-social_links', '[[{\"key\":\"name\",\"value\":\"Facebook\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-facebook\"},{\"key\":\"url\",\"value\":\"https:\\/\\/www.facebook.com\"},{\"key\":\"icon_image\",\"value\":null},{\"key\":\"color\",\"value\":\"#fff\"},{\"key\":\"background-color\",\"value\":\"#3b5999\"}],[{\"key\":\"name\",\"value\":\"X (Twitter)\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-x\"},{\"key\":\"url\",\"value\":\"https:\\/\\/x.com\"},{\"key\":\"icon_image\",\"value\":null},{\"key\":\"color\",\"value\":\"#fff\"},{\"key\":\"background-color\",\"value\":\"#000\"}],[{\"key\":\"name\",\"value\":\"linkedin\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-linkedin\"},{\"key\":\"url\",\"value\":\"https:\\/\\/www.linkedin.com\"},{\"key\":\"icon_image\",\"value\":null},{\"key\":\"color\",\"value\":\"#fff\"},{\"key\":\"background-color\",\"value\":\"#0a66c2\"}]]', NULL, '2024-09-20 07:57:19'),
(66, 'theme-farmart-social_sharing', '[[{\"key\":\"social\",\"value\":\"facebook\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-facebook\"},{\"key\":\"icon_image\",\"value\":null},{\"key\":\"color\",\"value\":\"#fff\"},{\"key\":\"background_color\",\"value\":\"#3b5999\"}],[{\"key\":\"social\",\"value\":\"x\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-twitter\"},{\"key\":\"icon_image\",\"value\":null},{\"key\":\"color\",\"value\":\"#fff\"},{\"key\":\"background_color\",\"value\":\"#55acee\"}],[{\"key\":\"social\",\"value\":\"pinterest\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-pinterest\"},{\"key\":\"icon_image\",\"value\":null},{\"key\":\"color\",\"value\":\"#fff\"},{\"key\":\"background_color\",\"value\":\"#b10c0c\"}],[{\"key\":\"social\",\"value\":\"linkedin\"},{\"key\":\"icon\",\"value\":\"ti ti-brand-linkedin\"},{\"key\":\"icon_image\",\"value\":null},{\"key\":\"color\",\"value\":\"#fff\"},{\"key\":\"background_color\",\"value\":\"#0271ae\"}]]', NULL, '2024-09-20 07:57:19'),
(67, 'theme-farmart-primary_font', 'Mulish', NULL, '2024-09-20 07:57:19'),
(68, 'theme-farmart-newsletter_popup_enable', '1', NULL, '2024-09-20 07:57:19'),
(69, 'theme-farmart-newsletter_popup_image', 'general/newsletter-popup.png', NULL, '2024-09-20 07:57:19'),
(70, 'theme-farmart-newsletter_popup_title', 'Subscribe Now', NULL, '2024-09-20 07:57:19'),
(71, 'theme-farmart-newsletter_popup_subtitle', 'Newsletter', NULL, '2024-09-20 07:57:19'),
(72, 'theme-farmart-newsletter_popup_description', 'Subscribe to our newsletter and get 10% off your first purchase', NULL, '2024-09-20 07:57:19'),
(73, 'ecommerce_enable_auto_detect_visitor_currency', '0', NULL, NULL),
(74, 'ecommerce_add_space_between_price_and_currency', '0', NULL, NULL),
(75, 'ecommerce_thousands_separator', ',', NULL, NULL),
(76, 'ecommerce_decimal_separator', '.', NULL, NULL),
(77, 'ecommerce_exchange_rate_api_provider', 'none', NULL, NULL),
(78, 'ecommerce_api_layer_api_key', '', NULL, NULL),
(79, 'ecommerce_open_exchange_app_id', '', NULL, NULL),
(80, 'ecommerce_use_exchange_rate_from_api', '0', NULL, NULL),
(81, 'ecommerce_currencies_is_default', '4', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `simple_sliders`
--

CREATE TABLE `simple_sliders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `key` varchar(120) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `simple_sliders`
--

INSERT INTO `simple_sliders` (`id`, `name`, `key`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Home slider', 'home-slider', 'The main slider on homepage', 'published', '2024-08-05 02:26:37', '2024-08-05 02:26:37');

-- --------------------------------------------------------

--
-- Table structure for table `simple_slider_items`
--

CREATE TABLE `simple_slider_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `simple_slider_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `image` varchar(191) NOT NULL,
  `link` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `simple_slider_items`
--

INSERT INTO `simple_slider_items` (`id`, `simple_slider_id`, `title`, `image`, `link`, `description`, `order`, `created_at`, `updated_at`) VALUES
(1, 1, 'Slider 1', 'sliders/01.jpg', '/products', NULL, 1, '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(2, 1, 'Slider 2', 'sliders/02.jpg', '/products', NULL, 2, '2024-08-05 02:26:37', '2024-08-05 02:26:37');

-- --------------------------------------------------------

--
-- Table structure for table `slugs`
--

CREATE TABLE `slugs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `reference_id` bigint(20) UNSIGNED NOT NULL,
  `reference_type` varchar(191) NOT NULL,
  `prefix` varchar(120) DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slugs`
--

INSERT INTO `slugs` (`id`, `key`, `reference_id`, `reference_type`, `prefix`, `created_at`, `updated_at`) VALUES
(1, 'foodpound', 1, 'Botble\\Ecommerce\\Models\\Brand', 'brands', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(2, 'itea-jsc', 2, 'Botble\\Ecommerce\\Models\\Brand', 'brands', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(3, 'soda-brand', 3, 'Botble\\Ecommerce\\Models\\Brand', 'brands', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(4, 'farmart', 4, 'Botble\\Ecommerce\\Models\\Brand', 'brands', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(5, 'soda-brand', 5, 'Botble\\Ecommerce\\Models\\Brand', 'brands', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(6, 'fruits-vegetables', 1, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(7, 'fruits', 2, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(8, 'apples', 3, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(9, 'bananas', 4, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(10, 'berries', 5, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(11, 'oranges-easy-peelers', 6, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(12, 'grapes', 7, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(13, 'lemons-limes', 8, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(14, 'peaches-nectarines', 9, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(15, 'pears', 10, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(16, 'melon', 11, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(17, 'avocados', 12, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(18, 'plums-apricots', 13, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(19, 'vegetables', 14, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(20, 'potatoes', 15, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(21, 'carrots-root-vegetables', 16, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(22, 'broccoli-cauliflower', 17, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(23, 'cabbage-spinach-greens', 18, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(24, 'onions-leeks-garlic', 19, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(25, 'mushrooms', 20, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(26, 'tomatoes', 21, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(27, 'beans-peas-sweetcorn', 22, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(28, 'freshly-drink-orange-juice', 23, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(29, 'breads-sweets', 24, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(30, 'crisps-snacks-nuts', 25, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(31, 'crisps-popcorn', 26, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(32, 'nuts-seeds', 27, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(33, 'lighter-options', 28, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(34, 'cereal-bars', 29, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(35, 'breadsticks-pretzels', 30, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(36, 'fruit-snacking', 31, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(37, 'rice-corn-cakes', 32, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(38, 'protein-energy-snacks', 33, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(39, 'toddler-snacks', 34, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(40, 'meat-snacks', 35, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(41, 'beans', 36, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(42, 'lentils', 37, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(43, 'chickpeas', 38, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(44, 'tins-cans', 39, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(45, 'tomatoes', 40, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(46, 'baked-beans-spaghetti', 41, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(47, 'fish', 42, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(48, 'beans-pulses', 43, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(49, 'fruit', 44, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(50, 'coconut-milk-cream', 45, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(51, 'lighter-options', 46, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(52, 'olives', 47, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(53, 'sweetcorn', 48, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(54, 'carrots', 49, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(55, 'peas', 50, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(56, 'mixed-vegetables', 51, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(57, 'frozen-seafoods', 52, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(58, 'raw-meats', 53, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(59, 'wines-alcohol-drinks', 54, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(60, 'ready-meals', 55, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(61, 'meals-for-1', 56, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(62, 'meals-for-2', 57, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(63, 'indian', 58, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(64, 'italian', 59, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(65, 'chinese', 60, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(66, 'traditional-british', 61, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(67, 'thai-oriental', 62, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(68, 'mediterranean-moroccan', 63, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(69, 'mexican-caribbean', 64, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(70, 'lighter-meals', 65, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(71, 'lunch-veg-pots', 66, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(72, 'salad-herbs', 67, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(73, 'salad-bags', 68, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(74, 'cucumber', 69, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(75, 'tomatoes', 70, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(76, 'lettuce', 71, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(77, 'lunch-salad-bowls', 72, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(78, 'lunch-salad-bowls', 73, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(79, 'fresh-herbs', 74, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(80, 'avocados', 75, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(81, 'peppers', 76, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(82, 'coleslaw-potato-salad', 77, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(83, 'spring-onions', 78, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(84, 'chilli-ginger-garlic', 79, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(85, 'tea-coffee', 80, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(86, 'milks-and-dairies', 81, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(87, 'pet-foods', 82, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(88, 'food-cupboard', 83, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-08-05 02:26:18', '2024-08-05 02:26:18'),
(90, 'mobile', 2, 'Botble\\Ecommerce\\Models\\ProductTag', 'product-tags', '2024-08-05 02:26:21', '2024-08-05 02:26:21'),
(91, 'iphone', 3, 'Botble\\Ecommerce\\Models\\ProductTag', 'product-tags', '2024-08-05 02:26:21', '2024-08-05 02:26:21'),
(92, 'printer', 4, 'Botble\\Ecommerce\\Models\\ProductTag', 'product-tags', '2024-08-05 02:26:21', '2024-08-05 02:26:21'),
(93, 'office', 5, 'Botble\\Ecommerce\\Models\\ProductTag', 'product-tags', '2024-08-05 02:26:21', '2024-08-05 02:26:21'),
(94, 'it', 6, 'Botble\\Ecommerce\\Models\\ProductTag', 'product-tags', '2024-08-05 02:26:21', '2024-08-05 02:26:21'),
(95, 'dual-camera-20mp', 1, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(97, 'beat-headphone', 3, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(98, 'red-black-headphone-digital', 4, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:38'),
(99, 'smart-watch-external', 5, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(100, 'nikon-hd-camera', 6, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(101, 'audio-equipment', 7, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(102, 'smart-televisions-digital', 8, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:38'),
(103, 'samsung-smart-phone', 9, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(104, 'herschel-leather-duffle-bag-in-brown-color', 10, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(105, 'xbox-one-wireless-controller-black-color', 11, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(106, 'epsion-plaster-printer-digital', 12, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:38'),
(107, 'sound-intone-i65-earphone-white-version', 13, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(108, 'bo-play-mini-bluetooth-speaker', 14, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(109, 'apple-macbook-air-retina-133-inch-laptop', 15, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(110, 'apple-macbook-air-retina-12-inch-laptop-digital', 16, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:38'),
(111, 'samsung-gear-vr-virtual-reality-headset', 17, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:29', '2024-08-05 02:26:29'),
(112, 'aveeno-moisturizing-body-shower-450ml', 18, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(113, 'nyx-beauty-couton-pallete-makeup-12', 19, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(114, 'nyx-beauty-couton-pallete-makeup-12-digital', 20, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(115, 'mvmth-classical-leather-watch-in-black', 21, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(116, 'baxter-care-hair-kit-for-bearded-mens', 22, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(117, 'ciate-palemore-lipstick-bold-red-color', 23, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(119, 'crock-pot-slow-cooker', 25, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(120, 'taylors-of-harrogate-yorkshire-coffee', 26, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(121, 'soft-mochi-galeto-ice-cream', 27, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(123, 'saute-pan-silver', 29, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(124, 'bar-s-classic-bun-length-franks', 30, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(125, 'broccoli-crowns', 31, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(126, 'slimming-world-vegan-mac-greens-digital', 32, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(127, 'haagen-dazs-salted-caramel', 33, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(128, 'iceland-3-solo-exotic-burst', 34, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(129, 'extreme-budweiser-light-can', 35, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(130, 'iceland-macaroni-cheese-traybake-digital', 36, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(131, 'dolmio-bolognese-pasta-sauce', 37, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(132, 'sitema-bakeit-plastic-box', 38, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(133, 'wayfair-basics-dinner-plate-storage', 39, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(134, 'miko-the-panda-water-bottle-digital', 40, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(135, 'sesame-seed-bread', 41, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(136, 'morrisons-the-best-beef', 42, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(137, 'avocado-hass-large', 43, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(138, 'italia-beef-lasagne-digital', 44, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(139, 'maxwell-house-classic-roast-mocha', 45, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(140, 'bottled-pure-water-500ml', 46, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(141, 'famart-farmhouse-soft-white', 47, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(142, 'coca-cola-original-taste-digital', 48, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(143, 'casillero-diablo-cabernet-sauvignon', 49, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(144, 'arla-organic-free-range-milk', 50, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(145, 'aptamil-follow-on-baby-milk', 51, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(146, 'cuisinart-chefs-classic-hard-anodized-digital', 52, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(147, 'corn-yellow-sweet', 53, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(148, 'hobnobs-the-nobbly-biscuit', 54, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(149, 'honest-organic-still-lemonade', 55, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(150, 'ice-becks-beer-350ml-x-24-pieces-digital', 56, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(151, 'iceland-6-hot-cross-buns', 57, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(152, 'iceland-luxury-4-panini-rolls', 58, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(153, 'iceland-soft-scoop-vanilla', 59, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(154, 'iceland-spaghetti-bolognese-digital', 60, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(155, 'kelloggs-coco-pops-cereal', 61, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(156, 'kit-kat-chunky-milk-chocolate', 62, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(157, 'large-green-bell-pepper', 63, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:30'),
(158, 'pice-94w-beasley-journal-digital', 64, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:30', '2024-08-05 02:26:38'),
(159, 'province-piece-glass-drinking-glass', 65, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:31', '2024-08-05 02:26:31'),
(160, 'gopro', 1, 'Botble\\Marketplace\\Models\\Store', 'stores', '2024-08-05 02:26:35', '2024-08-05 02:26:35'),
(161, 'global-office', 2, 'Botble\\Marketplace\\Models\\Store', 'stores', '2024-08-05 02:26:35', '2024-08-05 02:26:35'),
(162, 'young-shop', 3, 'Botble\\Marketplace\\Models\\Store', 'stores', '2024-08-05 02:26:35', '2024-08-05 02:26:35'),
(163, 'global-store', 4, 'Botble\\Marketplace\\Models\\Store', 'stores', '2024-08-05 02:26:35', '2024-08-05 02:26:35'),
(164, 'roberts-store', 5, 'Botble\\Marketplace\\Models\\Store', 'stores', '2024-08-05 02:26:35', '2024-08-05 02:26:35'),
(165, 'stouffer', 6, 'Botble\\Marketplace\\Models\\Store', 'stores', '2024-08-05 02:26:35', '2024-08-05 02:26:35'),
(166, 'starkist', 7, 'Botble\\Marketplace\\Models\\Store', 'stores', '2024-08-05 02:26:35', '2024-08-05 02:26:35'),
(167, 'old-el-paso', 8, 'Botble\\Marketplace\\Models\\Store', 'stores', '2024-08-05 02:26:35', '2024-08-05 02:26:35'),
(168, 'ecommerce', 1, 'Botble\\Blog\\Models\\Category', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(169, 'fashion', 2, 'Botble\\Blog\\Models\\Category', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(170, 'electronic', 3, 'Botble\\Blog\\Models\\Category', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(171, 'commercial', 4, 'Botble\\Blog\\Models\\Category', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(172, 'general', 1, 'Botble\\Blog\\Models\\Tag', 'tag', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(173, 'design', 2, 'Botble\\Blog\\Models\\Tag', 'tag', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(174, 'fashion', 3, 'Botble\\Blog\\Models\\Tag', 'tag', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(175, 'branding', 4, 'Botble\\Blog\\Models\\Tag', 'tag', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(176, 'modern', 5, 'Botble\\Blog\\Models\\Tag', 'tag', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(177, '4-expert-tips-on-how-to-choose-the-right-mens-wallet', 1, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(178, 'sexy-clutches-how-to-buy-wear-a-designer-clutch-bag', 2, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(179, 'the-top-2020-handbag-trends-to-know', 3, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(180, 'how-to-match-the-color-of-your-handbag-with-an-outfit', 4, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(181, 'how-to-care-for-leather-bags', 5, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(182, 'were-crushing-hard-on-summers-10-biggest-bag-trends', 6, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(183, 'essential-qualities-of-highly-successful-music', 7, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(184, '9-things-i-love-about-shaving-my-head', 8, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(185, 'why-teamwork-really-makes-the-dream-work', 9, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(186, 'the-world-caters-to-average-people', 10, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(187, 'the-litigants-on-the-screen-are-not-actors', 11, 'Botble\\Blog\\Models\\Post', 'blog', '2024-08-05 02:26:36', '2024-08-05 02:26:37'),
(188, 'home', 1, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(189, 'about-us', 2, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(190, 'terms-of-use', 3, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(191, 'terms-conditions', 4, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(192, 'refund-policy', 5, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(193, 'blog', 6, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(194, 'faqs', 7, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(195, 'contact', 8, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(196, 'cookie-policy', 9, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(197, 'affiliate', 10, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(198, 'career', 11, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(199, 'coming-soon', 12, 'Botble\\Page\\Models\\Page', '', '2024-08-05 02:26:37', '2024-08-05 02:26:37'),
(200, 'smart-watches', 66, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(201, 'smart-watches', 67, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(202, 'smart-watches', 68, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(203, 'beat-headphone', 69, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(204, 'beat-headphone', 70, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(205, 'red-black-headphone-digital', 71, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(206, 'smart-watch-external', 72, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(207, 'smart-watch-external', 73, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(208, 'smart-watch-external', 74, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(209, 'smart-televisions-digital', 75, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(210, 'smart-televisions-digital', 76, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(211, 'samsung-smart-phone', 77, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(212, 'samsung-smart-phone', 78, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(213, 'samsung-smart-phone', 79, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(214, 'xbox-one-wireless-controller-black-color', 80, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(215, 'epsion-plaster-printer-digital', 81, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(216, 'epsion-plaster-printer-digital', 82, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(217, 'sound-intone-i65-earphone-white-version', 83, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(218, 'sound-intone-i65-earphone-white-version', 84, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(219, 'sound-intone-i65-earphone-white-version', 85, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(220, 'bo-play-mini-bluetooth-speaker', 86, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(221, 'bo-play-mini-bluetooth-speaker', 87, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(222, 'apple-macbook-air-retina-133-inch-laptop', 88, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(223, 'apple-macbook-air-retina-133-inch-laptop', 89, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(224, 'apple-macbook-air-retina-133-inch-laptop', 90, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(225, 'apple-macbook-air-retina-12-inch-laptop-digital', 91, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(226, 'apple-macbook-air-retina-12-inch-laptop-digital', 92, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(227, 'apple-macbook-air-retina-12-inch-laptop-digital', 93, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(228, 'samsung-gear-vr-virtual-reality-headset', 94, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(229, 'samsung-gear-vr-virtual-reality-headset', 95, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(230, 'nyx-beauty-couton-pallete-makeup-12', 96, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(231, 'nyx-beauty-couton-pallete-makeup-12', 97, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(232, 'nyx-beauty-couton-pallete-makeup-12', 98, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(233, 'nyx-beauty-couton-pallete-makeup-12', 99, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(234, 'nyx-beauty-couton-pallete-makeup-12-digital', 100, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(235, 'nyx-beauty-couton-pallete-makeup-12-digital', 101, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(236, 'nyx-beauty-couton-pallete-makeup-12-digital', 102, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(237, 'nyx-beauty-couton-pallete-makeup-12-digital', 103, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(238, 'mvmth-classical-leather-watch-in-black', 104, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(239, 'mvmth-classical-leather-watch-in-black', 105, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(240, 'mvmth-classical-leather-watch-in-black', 106, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(241, 'vimto-squash-remix-apple-15-litres-digital', 107, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(242, 'taylors-of-harrogate-yorkshire-coffee', 108, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(243, 'taylors-of-harrogate-yorkshire-coffee', 109, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(244, 'taylors-of-harrogate-yorkshire-coffee', 110, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(245, 'taylors-of-harrogate-yorkshire-coffee', 111, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(246, 'taylors-of-harrogate-yorkshire-coffee', 112, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(247, 'naked-noodle-egg-noodles-singapore-digital', 113, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(248, 'naked-noodle-egg-noodles-singapore-digital', 114, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(249, 'bar-s-classic-bun-length-franks', 115, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(250, 'bar-s-classic-bun-length-franks', 116, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(251, 'broccoli-crowns', 117, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(252, 'broccoli-crowns', 118, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(253, 'broccoli-crowns', 119, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(254, 'broccoli-crowns', 120, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(255, 'slimming-world-vegan-mac-greens-digital', 121, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(256, 'slimming-world-vegan-mac-greens-digital', 122, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(257, 'haagen-dazs-salted-caramel', 123, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(258, 'haagen-dazs-salted-caramel', 124, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(259, 'sesame-seed-bread', 125, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(260, 'sesame-seed-bread', 126, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(261, 'sesame-seed-bread', 127, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(262, 'morrisons-the-best-beef', 128, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(263, 'avocado-hass-large', 129, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(264, 'avocado-hass-large', 130, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(265, 'avocado-hass-large', 131, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(266, 'bottled-pure-water-500ml', 132, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(267, 'bottled-pure-water-500ml', 133, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(268, 'bottled-pure-water-500ml', 134, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(269, 'bottled-pure-water-500ml', 135, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(270, 'aptamil-follow-on-baby-milk', 136, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(271, 'aptamil-follow-on-baby-milk', 137, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(272, 'aptamil-follow-on-baby-milk', 138, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(273, 'corn-yellow-sweet', 139, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(274, 'corn-yellow-sweet', 140, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(275, 'honest-organic-still-lemonade', 141, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(276, 'iceland-6-hot-cross-buns', 142, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(277, 'iceland-6-hot-cross-buns', 143, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(278, 'iceland-luxury-4-panini-rolls', 144, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(279, 'iceland-luxury-4-panini-rolls', 145, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(280, 'iceland-luxury-4-panini-rolls', 146, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(281, 'kelloggs-coco-pops-cereal', 147, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(282, 'kelloggs-coco-pops-cereal', 148, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(283, 'kelloggs-coco-pops-cereal', 149, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(284, 'kit-kat-chunky-milk-chocolate', 150, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(285, 'large-green-bell-pepper', 151, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(286, 'large-green-bell-pepper', 152, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(287, 'large-green-bell-pepper', 153, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(288, 'large-green-bell-pepper', 154, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(289, 'province-piece-glass-drinking-glass', 155, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(290, 'province-piece-glass-drinking-glass', 156, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(291, 'eau-de-parfum', 1, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:18:03', '2024-09-20 02:18:03'),
(292, 'concentrated-parfum', 2, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:18:46', '2024-09-20 02:18:46'),
(293, 'dakhoon', 3, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:19:05', '2024-09-20 02:19:05'),
(294, 'gift-sets', 4, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:19:23', '2024-09-20 02:19:23'),
(295, 'gel', 5, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:19:41', '2024-09-20 02:19:41'),
(296, 'hair-mist', 6, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:20:10', '2024-09-20 02:20:10'),
(297, 'collections', 7, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:20:29', '2024-09-20 02:20:29'),
(298, 'oriental-fragrance', 8, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:26:33', '2024-09-20 02:26:33'),
(299, 'occidental-fragrance', 9, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:26:52', '2024-09-20 02:26:52'),
(300, 'dehn-al-oud', 10, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:27:27', '2024-09-20 02:27:27'),
(301, 'concentrated-oil', 11, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:27:48', '2024-09-20 02:27:48'),
(302, 'bakhoor', 12, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:28:10', '2024-09-20 02:28:10'),
(303, 'natural-oud', 13, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:28:38', '2024-09-20 02:28:38'),
(304, 'oud-maattar', 14, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:29:24', '2024-09-20 02:29:24'),
(305, 'air-freshener', 15, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:29:47', '2024-09-20 02:29:47'),
(306, 'gift-sets-1', 16, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:30:12', '2024-09-20 02:30:12'),
(307, 'body-gel', 17, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:30:44', '2024-09-20 02:30:44'),
(308, 'premium-collection', 18, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:31:12', '2024-09-20 02:31:12'),
(309, 'online-exclusive-sets', 19, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:31:34', '2024-09-20 02:31:34'),
(310, 'summer-collection', 20, 'Botble\\Ecommerce\\Models\\ProductCategory', 'product-categories', '2024-09-20 02:31:59', '2024-09-20 02:31:59'),
(311, 'bidun-esam', 1, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 03:41:50', '2024-09-20 03:41:50'),
(313, 'kaaf', 3, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 03:52:55', '2024-09-20 03:52:55'),
(315, 'laathani', 4, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 03:57:35', '2024-09-20 03:57:35'),
(316, 'oud-roses', 5, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:07:24', '2024-09-20 04:07:24'),
(317, 'marj', 6, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:08:22', '2024-09-20 04:08:22'),
(318, 'dehn-al-oud-combodi-omani', 7, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:11:30', '2024-09-20 04:11:30'),
(319, 'dehn-al-oudh-mubakhar', 8, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:12:36', '2024-09-20 04:12:36'),
(320, 'ghawi', 9, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:13:32', '2024-09-20 04:13:32'),
(321, 'zukhruf', 10, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:14:22', '2024-09-20 04:14:22'),
(322, 'bakhoor-baiti-10-tabs', 11, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:16:17', '2024-09-20 04:16:17'),
(323, 'bakhoor-oud-roses', 12, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:16:52', '2024-09-20 04:16:52'),
(324, 'maria-oud-mubakhar-36-grams', 13, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:17:57', '2024-09-20 04:17:57'),
(325, 'maria-oud-mubakhar-58-grams', 14, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:21:52', '2024-09-20 04:21:52'),
(326, 'air-freshener-oud-roses', 15, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:23:03', '2024-09-20 04:23:03'),
(327, 'air-freshener-oud-lavender', 16, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:23:45', '2024-09-20 04:23:45'),
(328, 'oud-roses-body-gel', 17, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:31:12', '2024-09-20 04:31:12'),
(329, 'supreme-body-gel', 18, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:31:50', '2024-09-20 04:31:50'),
(330, 'oud-roses-collection', 19, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:33:46', '2024-09-20 04:33:46'),
(331, 'little-hearts-collection', 20, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:34:18', '2024-09-20 04:34:18'),
(332, 'bakhoor-bushra-10-tabs', 21, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:35:19', '2024-09-20 04:35:19'),
(333, 'summer-collection-1', 22, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 04:37:26', '2024-09-20 04:37:26'),
(334, 'test-prod', 23, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 06:53:49', '2024-09-20 06:53:49'),
(336, 'rose-noir', 25, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 07:27:57', '2024-09-20 07:27:57'),
(337, 'oud-lavender', 26, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 07:29:11', '2024-09-20 07:29:11'),
(338, 'oud-classic', 27, 'Botble\\Ecommerce\\Models\\Product', 'products', '2024-09-20 07:30:55', '2024-09-20 07:30:55');

-- --------------------------------------------------------

--
-- Table structure for table `slugs_translations`
--

CREATE TABLE `slugs_translations` (
  `lang_code` varchar(20) NOT NULL,
  `slugs_id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) DEFAULT NULL,
  `prefix` varchar(120) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `image` varchar(191) DEFAULT NULL,
  `is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `states_translations`
--

CREATE TABLE `states_translations` (
  `lang_code` varchar(20) NOT NULL,
  `states_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `abbreviation` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `author_id` bigint(20) UNSIGNED DEFAULT NULL,
  `author_type` varchar(191) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `description` varchar(400) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `author_id`, `author_type`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'General', 1, 'Botble\\ACL\\Models\\User', NULL, 'published', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(2, 'Design', 1, 'Botble\\ACL\\Models\\User', NULL, 'published', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(3, 'Fashion', 1, 'Botble\\ACL\\Models\\User', NULL, 'published', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(4, 'Branding', 1, 'Botble\\ACL\\Models\\User', NULL, 'published', '2024-08-05 02:26:36', '2024-08-05 02:26:36'),
(5, 'Modern', 1, 'Botble\\ACL\\Models\\User', NULL, 'published', '2024-08-05 02:26:36', '2024-08-05 02:26:36');

-- --------------------------------------------------------

--
-- Table structure for table `tags_translations`
--

CREATE TABLE `tags_translations` (
  `lang_code` varchar(20) NOT NULL,
  `tags_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(191) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(120) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(120) DEFAULT NULL,
  `last_name` varchar(120) DEFAULT NULL,
  `username` varchar(60) DEFAULT NULL,
  `avatar_id` bigint(20) UNSIGNED DEFAULT NULL,
  `super_user` tinyint(1) NOT NULL DEFAULT 0,
  `manage_supers` tinyint(1) NOT NULL DEFAULT 0,
  `permissions` text DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `first_name`, `last_name`, `username`, `avatar_id`, `super_user`, `manage_supers`, `permissions`, `last_login`) VALUES
(1, 'tiana87@hyatt.biz', NULL, '$2y$12$TSvDd5zcHk9beOvfugifz.leGjCF9PSSnnCoWJvIDcp9BUgizGO8e', 'rlh2luUdK6WBGzXf2jSSugUtGrP6uMx76KTefortN5GiMkqQl2WDrIsJOgPc', '2024-08-05 02:26:18', '2024-08-05 02:26:18', 'Admin', 'Admin', 'admin', NULL, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_meta`
--

CREATE TABLE `user_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(120) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_meta`
--

INSERT INTO `user_meta` (`id`, `key`, `value`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'theme_mode', 'dark', 1, '2024-09-20 02:16:02', '2024-09-20 02:16:02');

-- --------------------------------------------------------

--
-- Table structure for table `widgets`
--

CREATE TABLE `widgets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `widget_id` varchar(120) NOT NULL,
  `sidebar_id` varchar(120) NOT NULL,
  `theme` varchar(120) NOT NULL,
  `position` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `widgets`
--

INSERT INTO `widgets` (`id`, `widget_id`, `sidebar_id`, `theme`, `position`, `data`, `created_at`, `updated_at`) VALUES
(1, 'SiteInfoWidget', 'footer_sidebar', 'farmart', 0, '{\"id\":\"SiteInfoWidget\",\"name\":\"Farmart \\u2013 Your Online Foods & Grocery\",\"about\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finibus viverra iaculis. Etiam vulputate et justo eget scelerisque.\",\"phone\":\"(+965) 7492-4277\",\"address\":\"959 Homestead Street Eastlake, NYC\",\"email\":\"support@farmart.com\",\"working_time\":\"Mon - Fri: 07AM - 06PM\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(2, 'CustomMenuWidget', 'footer_sidebar', 'farmart', 1, '{\"id\":\"CustomMenuWidget\",\"name\":\"Useful Links\",\"menu_id\":\"useful-links\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(3, 'CustomMenuWidget', 'footer_sidebar', 'farmart', 2, '{\"id\":\"CustomMenuWidget\",\"name\":\"Help Center\",\"menu_id\":\"help-center\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(4, 'CustomMenuWidget', 'footer_sidebar', 'farmart', 3, '{\"id\":\"CustomMenuWidget\",\"name\":\"Business\",\"menu_id\":\"business\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(5, 'NewsletterWidget', 'footer_sidebar', 'farmart', 4, '{\"id\":\"NewsletterWidget\",\"title\":\"Newsletter\",\"subtitle\":\"Register now to get updates on promotions and coupon. Don\\u2019t worry! We not spam\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(6, 'BlogSearchWidget', 'primary_sidebar', 'farmart', 1, '{\"id\":\"BlogSearchWidget\",\"name\":\"Search\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(7, 'BlogCategoriesWidget', 'primary_sidebar', 'farmart', 2, '{\"id\":\"BlogCategoriesWidget\",\"name\":\"Categories\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(8, 'RecentPostsWidget', 'primary_sidebar', 'farmart', 3, '{\"id\":\"RecentPostsWidget\",\"name\":\"Recent Posts\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(9, 'BlogTagsWidget', 'primary_sidebar', 'farmart', 4, '{\"id\":\"BlogTagsWidget\",\"name\":\"Popular Tags\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(10, 'SiteFeaturesWidget', 'pre_footer_sidebar', 'farmart', 1, '{\"id\":\"SiteFeaturesWidget\",\"title\":\"Site Features\",\"data\":{\"1\":{\"icon\":\"general\\/icon-rocket.png\",\"title\":\"Free Shipping\",\"subtitle\":\"For all orders over $200\"},\"2\":{\"icon\":\"general\\/icon-reload.png\",\"title\":\"1 & 1 Returns\",\"subtitle\":\"Cancellation after 1 day\"},\"3\":{\"icon\":\"general\\/icon-protect.png\",\"title\":\"100% Secure Payment\",\"subtitle\":\"Guarantee secure payments\"},\"4\":{\"icon\":\"general\\/icon-support.png\",\"title\":\"24\\/7 Dedicated Support\",\"subtitle\":\"Anywhere & anytime\"},\"5\":{\"icon\":\"general\\/icon-tag.png\",\"title\":\"Daily Offers\",\"subtitle\":\"Discount up to 70% OFF\"}}}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(11, 'AdsWidget', 'products_list_sidebar', 'farmart', 1, '{\"id\":\"AdsWidget\",\"title\":\"Ads\",\"ads_key\":\"ZDOZUZZIU7FZ\",\"background\":\"general\\/background.jpg\",\"size\":\"full-width\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(12, 'SiteFeaturesWidget', 'product_detail_sidebar', 'farmart', 1, '{\"id\":\"SiteFeaturesWidget\",\"title\":\"Site Features\",\"data\":{\"1\":{\"icon\":\"general\\/icon-rocket.png\",\"title\":\"Free Shipping\",\"subtitle\":\"For all orders over $200\"},\"2\":{\"icon\":\"general\\/icon-reload.png\",\"title\":\"1 & 1 Returns\",\"subtitle\":\"Cancellation after 1 day\"},\"3\":{\"icon\":\"general\\/icon-protect.png\",\"title\":\"Secure Payment\",\"subtitle\":\"Guarantee secure payments\"}}}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(13, 'SiteInfoWidget', 'product_detail_sidebar', 'farmart', 2, '{\"id\":\"SiteInfoWidget\",\"name\":\"Store information\",\"phone\":\"(+965) 7492-4277\",\"working_time\":\"Mon - Fri: 07AM - 06PM\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(14, 'BecomeVendorWidget', 'product_detail_sidebar', 'farmart', 3, '{\"id\":\"BecomeVendorWidget\",\"name\":\"Become a Vendor?\"}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(15, 'ProductCategoriesWidget', 'bottom_footer_sidebar', 'farmart', 1, '{\"id\":\"ProductCategoriesWidget\",\"name\":\"Consumer Electric\",\"categories\":[18,2,3,4,5,6,7]}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(16, 'ProductCategoriesWidget', 'bottom_footer_sidebar', 'farmart', 2, '{\"id\":\"ProductCategoriesWidget\",\"name\":\"Clothing & Apparel\",\"categories\":[8,9,10,11,12]}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(17, 'ProductCategoriesWidget', 'bottom_footer_sidebar', 'farmart', 3, '{\"id\":\"ProductCategoriesWidget\",\"name\":\"Home, Garden & Kitchen\",\"categories\":[13,14,15,16,17]}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(18, 'ProductCategoriesWidget', 'bottom_footer_sidebar', 'farmart', 4, '{\"id\":\"ProductCategoriesWidget\",\"name\":\"Health & Beauty\",\"categories\":[20,21,22,23,24]}', '2024-08-05 02:26:38', '2024-08-05 02:26:38'),
(19, 'ProductCategoriesWidget', 'bottom_footer_sidebar', 'farmart', 5, '{\"id\":\"ProductCategoriesWidget\",\"name\":\"Computer & Technologies\",\"categories\":[25,26,27,28,29,19]}', '2024-08-05 02:26:38', '2024-08-05 02:26:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activations`
--
ALTER TABLE `activations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activations_user_id_index` (`user_id`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ads_key_unique` (`key`);

--
-- Indexes for table `ads_translations`
--
ALTER TABLE `ads_translations`
  ADD PRIMARY KEY (`lang_code`,`ads_id`);

--
-- Indexes for table `audit_histories`
--
ALTER TABLE `audit_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_histories_user_id_index` (`user_id`),
  ADD KEY `audit_histories_module_index` (`module`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_parent_id_index` (`parent_id`),
  ADD KEY `categories_status_index` (`status`),
  ADD KEY `categories_created_at_index` (`created_at`);

--
-- Indexes for table `categories_translations`
--
ALTER TABLE `categories_translations`
  ADD PRIMARY KEY (`lang_code`,`categories_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cities_slug_unique` (`slug`);

--
-- Indexes for table `cities_translations`
--
ALTER TABLE `cities_translations`
  ADD PRIMARY KEY (`lang_code`,`cities_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_custom_fields`
--
ALTER TABLE `contact_custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_custom_fields_translations`
--
ALTER TABLE `contact_custom_fields_translations`
  ADD PRIMARY KEY (`lang_code`,`contact_custom_fields_id`);

--
-- Indexes for table `contact_custom_field_options`
--
ALTER TABLE `contact_custom_field_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_custom_field_options_translations`
--
ALTER TABLE `contact_custom_field_options_translations`
  ADD PRIMARY KEY (`lang_code`,`contact_custom_field_options_id`);

--
-- Indexes for table `contact_replies`
--
ALTER TABLE `contact_replies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries_translations`
--
ALTER TABLE `countries_translations`
  ADD PRIMARY KEY (`lang_code`,`countries_id`);

--
-- Indexes for table `dashboard_widgets`
--
ALTER TABLE `dashboard_widgets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dashboard_widget_settings`
--
ALTER TABLE `dashboard_widget_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dashboard_widget_settings_user_id_index` (`user_id`),
  ADD KEY `dashboard_widget_settings_widget_id_index` (`widget_id`);

--
-- Indexes for table `ec_brands`
--
ALTER TABLE `ec_brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_brands_translations`
--
ALTER TABLE `ec_brands_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_brands_id`);

--
-- Indexes for table `ec_cart`
--
ALTER TABLE `ec_cart`
  ADD PRIMARY KEY (`identifier`,`instance`);

--
-- Indexes for table `ec_currencies`
--
ALTER TABLE `ec_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_customers`
--
ALTER TABLE `ec_customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_customers_email_unique` (`email`);

--
-- Indexes for table `ec_customer_addresses`
--
ALTER TABLE `ec_customer_addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_customer_deletion_requests`
--
ALTER TABLE `ec_customer_deletion_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_customer_deletion_requests_token_unique` (`token`);

--
-- Indexes for table `ec_customer_password_resets`
--
ALTER TABLE `ec_customer_password_resets`
  ADD KEY `ec_customer_password_resets_email_index` (`email`),
  ADD KEY `ec_customer_password_resets_token_index` (`token`);

--
-- Indexes for table `ec_customer_recently_viewed_products`
--
ALTER TABLE `ec_customer_recently_viewed_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_customer_used_coupons`
--
ALTER TABLE `ec_customer_used_coupons`
  ADD PRIMARY KEY (`discount_id`,`customer_id`);

--
-- Indexes for table `ec_discounts`
--
ALTER TABLE `ec_discounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_discounts_code_unique` (`code`);

--
-- Indexes for table `ec_discount_customers`
--
ALTER TABLE `ec_discount_customers`
  ADD PRIMARY KEY (`discount_id`,`customer_id`);

--
-- Indexes for table `ec_discount_products`
--
ALTER TABLE `ec_discount_products`
  ADD PRIMARY KEY (`discount_id`,`product_id`);

--
-- Indexes for table `ec_discount_product_categories`
--
ALTER TABLE `ec_discount_product_categories`
  ADD PRIMARY KEY (`discount_id`,`product_category_id`);

--
-- Indexes for table `ec_discount_product_collections`
--
ALTER TABLE `ec_discount_product_collections`
  ADD PRIMARY KEY (`discount_id`,`product_collection_id`);

--
-- Indexes for table `ec_flash_sales`
--
ALTER TABLE `ec_flash_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_flash_sales_translations`
--
ALTER TABLE `ec_flash_sales_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_flash_sales_id`);

--
-- Indexes for table `ec_global_options`
--
ALTER TABLE `ec_global_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_global_options_translations`
--
ALTER TABLE `ec_global_options_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_global_options_id`);

--
-- Indexes for table `ec_global_option_value`
--
ALTER TABLE `ec_global_option_value`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_global_option_value_translations`
--
ALTER TABLE `ec_global_option_value_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_global_option_value_id`);

--
-- Indexes for table `ec_grouped_products`
--
ALTER TABLE `ec_grouped_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_invoices`
--
ALTER TABLE `ec_invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_invoices_code_unique` (`code`),
  ADD KEY `ec_invoices_reference_type_reference_id_index` (`reference_type`,`reference_id`),
  ADD KEY `ec_invoices_payment_id_index` (`payment_id`),
  ADD KEY `ec_invoices_status_index` (`status`);

--
-- Indexes for table `ec_invoice_items`
--
ALTER TABLE `ec_invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ec_invoice_items_reference_type_reference_id_index` (`reference_type`,`reference_id`);

--
-- Indexes for table `ec_options`
--
ALTER TABLE `ec_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_options_translations`
--
ALTER TABLE `ec_options_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_options_id`);

--
-- Indexes for table `ec_option_value`
--
ALTER TABLE `ec_option_value`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_option_value_translations`
--
ALTER TABLE `ec_option_value_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_option_value_id`);

--
-- Indexes for table `ec_orders`
--
ALTER TABLE `ec_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_orders_code_unique` (`code`),
  ADD KEY `ec_orders_user_id_status_created_at_index` (`user_id`,`status`,`created_at`);

--
-- Indexes for table `ec_order_addresses`
--
ALTER TABLE `ec_order_addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_order_histories`
--
ALTER TABLE `ec_order_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_order_product`
--
ALTER TABLE `ec_order_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_order_referrals`
--
ALTER TABLE `ec_order_referrals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ec_order_referrals_order_id_index` (`order_id`);

--
-- Indexes for table `ec_order_returns`
--
ALTER TABLE `ec_order_returns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_order_returns_code_unique` (`code`);

--
-- Indexes for table `ec_order_return_histories`
--
ALTER TABLE `ec_order_return_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_order_return_items`
--
ALTER TABLE `ec_order_return_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_order_tax_information`
--
ALTER TABLE `ec_order_tax_information`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ec_order_tax_information_order_id_index` (`order_id`);

--
-- Indexes for table `ec_products`
--
ALTER TABLE `ec_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ec_products_brand_id_status_is_variation_created_at_index` (`brand_id`,`status`,`is_variation`,`created_at`),
  ADD KEY `sale_type_index` (`sale_type`),
  ADD KEY `start_date_index` (`start_date`),
  ADD KEY `end_date_index` (`end_date`),
  ADD KEY `sale_price_index` (`sale_price`),
  ADD KEY `is_variation_index` (`is_variation`),
  ADD KEY `ec_products_sku_index` (`sku`);

--
-- Indexes for table `ec_products_translations`
--
ALTER TABLE `ec_products_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_products_id`);

--
-- Indexes for table `ec_product_attributes`
--
ALTER TABLE `ec_product_attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attribute_set_status_index` (`attribute_set_id`);

--
-- Indexes for table `ec_product_attributes_translations`
--
ALTER TABLE `ec_product_attributes_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_product_attributes_id`);

--
-- Indexes for table `ec_product_attribute_sets`
--
ALTER TABLE `ec_product_attribute_sets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_product_attribute_sets_translations`
--
ALTER TABLE `ec_product_attribute_sets_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_product_attribute_sets_id`);

--
-- Indexes for table `ec_product_categories`
--
ALTER TABLE `ec_product_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ec_product_categories_parent_id_status_created_at_index` (`parent_id`,`status`,`created_at`),
  ADD KEY `ec_product_categories_parent_id_status_index` (`parent_id`,`status`);

--
-- Indexes for table `ec_product_categories_translations`
--
ALTER TABLE `ec_product_categories_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_product_categories_id`);

--
-- Indexes for table `ec_product_categorizables`
--
ALTER TABLE `ec_product_categorizables`
  ADD PRIMARY KEY (`category_id`,`reference_id`,`reference_type`),
  ADD KEY `ec_product_categorizables_category_id_index` (`category_id`),
  ADD KEY `ec_product_categorizables_reference_id_index` (`reference_id`),
  ADD KEY `ec_product_categorizables_reference_type_index` (`reference_type`);

--
-- Indexes for table `ec_product_category_product`
--
ALTER TABLE `ec_product_category_product`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `ec_product_category_product_category_id_index` (`category_id`),
  ADD KEY `ec_product_category_product_product_id_index` (`product_id`);

--
-- Indexes for table `ec_product_collections`
--
ALTER TABLE `ec_product_collections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_product_collections_translations`
--
ALTER TABLE `ec_product_collections_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_product_collections_id`);

--
-- Indexes for table `ec_product_collection_products`
--
ALTER TABLE `ec_product_collection_products`
  ADD PRIMARY KEY (`product_id`,`product_collection_id`),
  ADD KEY `ec_product_collection_products_product_collection_id_index` (`product_collection_id`),
  ADD KEY `ec_product_collection_products_product_id_index` (`product_id`);

--
-- Indexes for table `ec_product_cross_sale_relations`
--
ALTER TABLE `ec_product_cross_sale_relations`
  ADD PRIMARY KEY (`from_product_id`,`to_product_id`),
  ADD KEY `ec_product_cross_sale_relations_from_product_id_index` (`from_product_id`),
  ADD KEY `ec_product_cross_sale_relations_to_product_id_index` (`to_product_id`);

--
-- Indexes for table `ec_product_files`
--
ALTER TABLE `ec_product_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ec_product_files_product_id_index` (`product_id`);

--
-- Indexes for table `ec_product_labels`
--
ALTER TABLE `ec_product_labels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_product_labels_translations`
--
ALTER TABLE `ec_product_labels_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_product_labels_id`);

--
-- Indexes for table `ec_product_label_products`
--
ALTER TABLE `ec_product_label_products`
  ADD PRIMARY KEY (`product_label_id`,`product_id`),
  ADD KEY `ec_product_label_products_product_label_id_index` (`product_label_id`),
  ADD KEY `ec_product_label_products_product_id_index` (`product_id`);

--
-- Indexes for table `ec_product_related_relations`
--
ALTER TABLE `ec_product_related_relations`
  ADD PRIMARY KEY (`from_product_id`,`to_product_id`),
  ADD KEY `ec_product_related_relations_from_product_id_index` (`from_product_id`),
  ADD KEY `ec_product_related_relations_to_product_id_index` (`to_product_id`);

--
-- Indexes for table `ec_product_tags`
--
ALTER TABLE `ec_product_tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_product_tags_translations`
--
ALTER TABLE `ec_product_tags_translations`
  ADD PRIMARY KEY (`lang_code`,`ec_product_tags_id`);

--
-- Indexes for table `ec_product_tag_product`
--
ALTER TABLE `ec_product_tag_product`
  ADD PRIMARY KEY (`product_id`,`tag_id`),
  ADD KEY `ec_product_tag_product_product_id_index` (`product_id`),
  ADD KEY `ec_product_tag_product_tag_id_index` (`tag_id`);

--
-- Indexes for table `ec_product_up_sale_relations`
--
ALTER TABLE `ec_product_up_sale_relations`
  ADD PRIMARY KEY (`from_product_id`,`to_product_id`),
  ADD KEY `ec_product_up_sale_relations_from_product_id_index` (`from_product_id`),
  ADD KEY `ec_product_up_sale_relations_to_product_id_index` (`to_product_id`);

--
-- Indexes for table `ec_product_variations`
--
ALTER TABLE `ec_product_variations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_product_variations_product_id_configurable_product_id_unique` (`product_id`,`configurable_product_id`),
  ADD KEY `configurable_product_index` (`product_id`,`configurable_product_id`);

--
-- Indexes for table `ec_product_variation_items`
--
ALTER TABLE `ec_product_variation_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_product_variation_items_attribute_id_variation_id_unique` (`attribute_id`,`variation_id`),
  ADD KEY `attribute_variation_index` (`attribute_id`,`variation_id`);

--
-- Indexes for table `ec_product_views`
--
ALTER TABLE `ec_product_views`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_product_views_product_id_date_unique` (`product_id`,`date`),
  ADD KEY `ec_product_views_product_id_index` (`product_id`);

--
-- Indexes for table `ec_product_with_attribute_set`
--
ALTER TABLE `ec_product_with_attribute_set`
  ADD PRIMARY KEY (`product_id`,`attribute_set_id`);

--
-- Indexes for table `ec_reviews`
--
ALTER TABLE `ec_reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_reviews_product_id_customer_id_unique` (`product_id`,`customer_id`),
  ADD KEY `ec_reviews_product_id_customer_id_status_created_at_index` (`product_id`,`customer_id`,`status`,`created_at`),
  ADD KEY `review_relation_index` (`product_id`,`customer_id`,`status`);

--
-- Indexes for table `ec_review_replies`
--
ALTER TABLE `ec_review_replies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_review_replies_review_id_user_id_unique` (`review_id`,`user_id`);

--
-- Indexes for table `ec_shared_wishlists`
--
ALTER TABLE `ec_shared_wishlists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ec_shared_wishlists_code_unique` (`code`);

--
-- Indexes for table `ec_shipments`
--
ALTER TABLE `ec_shipments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_shipment_histories`
--
ALTER TABLE `ec_shipment_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_shipping`
--
ALTER TABLE `ec_shipping`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_shipping_rules`
--
ALTER TABLE `ec_shipping_rules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_shipping_rule_items`
--
ALTER TABLE `ec_shipping_rule_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_store_locators`
--
ALTER TABLE `ec_store_locators`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_taxes`
--
ALTER TABLE `ec_taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_tax_products`
--
ALTER TABLE `ec_tax_products`
  ADD PRIMARY KEY (`product_id`,`tax_id`),
  ADD KEY `ec_tax_products_tax_id_index` (`tax_id`),
  ADD KEY `ec_tax_products_product_id_index` (`product_id`);

--
-- Indexes for table `ec_tax_rules`
--
ALTER TABLE `ec_tax_rules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_wish_lists`
--
ALTER TABLE `ec_wish_lists`
  ADD PRIMARY KEY (`customer_id`,`product_id`),
  ADD KEY `wishlist_relation_index` (`product_id`,`customer_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faqs_translations`
--
ALTER TABLE `faqs_translations`
  ADD PRIMARY KEY (`lang_code`,`faqs_id`);

--
-- Indexes for table `faq_categories`
--
ALTER TABLE `faq_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faq_categories_translations`
--
ALTER TABLE `faq_categories_translations`
  ADD PRIMARY KEY (`lang_code`,`faq_categories_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`lang_id`),
  ADD KEY `lang_locale_index` (`lang_locale`),
  ADD KEY `lang_code_index` (`lang_code`),
  ADD KEY `lang_is_default_index` (`lang_is_default`);

--
-- Indexes for table `language_meta`
--
ALTER TABLE `language_meta`
  ADD PRIMARY KEY (`lang_meta_id`),
  ADD KEY `language_meta_reference_id_index` (`reference_id`),
  ADD KEY `meta_code_index` (`lang_meta_code`),
  ADD KEY `meta_origin_index` (`lang_meta_origin`),
  ADD KEY `meta_reference_type_index` (`reference_type`);

--
-- Indexes for table `media_files`
--
ALTER TABLE `media_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_files_user_id_index` (`user_id`),
  ADD KEY `media_files_index` (`folder_id`,`user_id`,`created_at`);

--
-- Indexes for table `media_folders`
--
ALTER TABLE `media_folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_folders_user_id_index` (`user_id`),
  ADD KEY `media_folders_index` (`parent_id`,`user_id`,`created_at`);

--
-- Indexes for table `media_settings`
--
ALTER TABLE `media_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_slug_unique` (`slug`);

--
-- Indexes for table `menu_locations`
--
ALTER TABLE `menu_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_locations_menu_id_created_at_index` (`menu_id`,`created_at`);

--
-- Indexes for table `menu_nodes`
--
ALTER TABLE `menu_nodes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_nodes_menu_id_index` (`menu_id`),
  ADD KEY `menu_nodes_parent_id_index` (`parent_id`),
  ADD KEY `reference_id` (`reference_id`),
  ADD KEY `reference_type` (`reference_type`);

--
-- Indexes for table `meta_boxes`
--
ALTER TABLE `meta_boxes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meta_boxes_reference_id_index` (`reference_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mp_category_sale_commissions`
--
ALTER TABLE `mp_category_sale_commissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mp_category_sale_commissions_product_category_id_unique` (`product_category_id`);

--
-- Indexes for table `mp_customer_revenues`
--
ALTER TABLE `mp_customer_revenues`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mp_customer_withdrawals`
--
ALTER TABLE `mp_customer_withdrawals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mp_messages`
--
ALTER TABLE `mp_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mp_stores`
--
ALTER TABLE `mp_stores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mp_stores_translations`
--
ALTER TABLE `mp_stores_translations`
  ADD PRIMARY KEY (`lang_code`,`mp_stores_id`);

--
-- Indexes for table `mp_vendor_info`
--
ALTER TABLE `mp_vendor_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `newsletters`
--
ALTER TABLE `newsletters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pages_user_id_index` (`user_id`);

--
-- Indexes for table `pages_translations`
--
ALTER TABLE `pages_translations`
  ADD PRIMARY KEY (`lang_code`,`pages_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_logs`
--
ALTER TABLE `payment_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_status_index` (`status`),
  ADD KEY `posts_author_id_index` (`author_id`),
  ADD KEY `posts_author_type_index` (`author_type`),
  ADD KEY `posts_created_at_index` (`created_at`);

--
-- Indexes for table `posts_translations`
--
ALTER TABLE `posts_translations`
  ADD PRIMARY KEY (`lang_code`,`posts_id`);

--
-- Indexes for table `post_categories`
--
ALTER TABLE `post_categories`
  ADD KEY `post_categories_category_id_index` (`category_id`),
  ADD KEY `post_categories_post_id_index` (`post_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD KEY `post_tags_tag_id_index` (`tag_id`),
  ADD KEY `post_tags_post_id_index` (`post_id`);

--
-- Indexes for table `revisions`
--
ALTER TABLE `revisions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `revisions_revisionable_id_revisionable_type_index` (`revisionable_id`,`revisionable_type`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`),
  ADD KEY `roles_created_by_index` (`created_by`),
  ADD KEY `roles_updated_by_index` (`updated_by`);

--
-- Indexes for table `role_users`
--
ALTER TABLE `role_users`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_users_user_id_index` (`user_id`),
  ADD KEY `role_users_role_id_index` (`role_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `simple_sliders`
--
ALTER TABLE `simple_sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `simple_slider_items`
--
ALTER TABLE `simple_slider_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slugs`
--
ALTER TABLE `slugs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slugs_reference_id_index` (`reference_id`),
  ADD KEY `slugs_key_index` (`key`),
  ADD KEY `slugs_prefix_index` (`prefix`),
  ADD KEY `slugs_reference_index` (`reference_id`,`reference_type`);

--
-- Indexes for table `slugs_translations`
--
ALTER TABLE `slugs_translations`
  ADD PRIMARY KEY (`lang_code`,`slugs_id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `states_slug_unique` (`slug`);

--
-- Indexes for table `states_translations`
--
ALTER TABLE `states_translations`
  ADD PRIMARY KEY (`lang_code`,`states_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tags_translations`
--
ALTER TABLE `tags_translations`
  ADD PRIMARY KEY (`lang_code`,`tags_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `user_meta`
--
ALTER TABLE `user_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_meta_user_id_index` (`user_id`);

--
-- Indexes for table `widgets`
--
ALTER TABLE `widgets`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activations`
--
ALTER TABLE `activations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ads`
--
ALTER TABLE `ads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `audit_histories`
--
ALTER TABLE `audit_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `contact_custom_fields`
--
ALTER TABLE `contact_custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_custom_field_options`
--
ALTER TABLE `contact_custom_field_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_replies`
--
ALTER TABLE `contact_replies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dashboard_widgets`
--
ALTER TABLE `dashboard_widgets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `dashboard_widget_settings`
--
ALTER TABLE `dashboard_widget_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_brands`
--
ALTER TABLE `ec_brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ec_currencies`
--
ALTER TABLE `ec_currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ec_customers`
--
ALTER TABLE `ec_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_customer_addresses`
--
ALTER TABLE `ec_customer_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `ec_customer_deletion_requests`
--
ALTER TABLE `ec_customer_deletion_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_customer_recently_viewed_products`
--
ALTER TABLE `ec_customer_recently_viewed_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_discounts`
--
ALTER TABLE `ec_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_flash_sales`
--
ALTER TABLE `ec_flash_sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_global_options`
--
ALTER TABLE `ec_global_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ec_global_option_value`
--
ALTER TABLE `ec_global_option_value`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `ec_grouped_products`
--
ALTER TABLE `ec_grouped_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_invoices`
--
ALTER TABLE `ec_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_invoice_items`
--
ALTER TABLE `ec_invoice_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_options`
--
ALTER TABLE `ec_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_option_value`
--
ALTER TABLE `ec_option_value`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_orders`
--
ALTER TABLE `ec_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_order_addresses`
--
ALTER TABLE `ec_order_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_order_histories`
--
ALTER TABLE `ec_order_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ec_order_product`
--
ALTER TABLE `ec_order_product`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_order_referrals`
--
ALTER TABLE `ec_order_referrals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_order_returns`
--
ALTER TABLE `ec_order_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_order_return_histories`
--
ALTER TABLE `ec_order_return_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_order_return_items`
--
ALTER TABLE `ec_order_return_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_order_tax_information`
--
ALTER TABLE `ec_order_tax_information`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_products`
--
ALTER TABLE `ec_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `ec_product_attributes`
--
ALTER TABLE `ec_product_attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_product_attribute_sets`
--
ALTER TABLE `ec_product_attribute_sets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_product_categories`
--
ALTER TABLE `ec_product_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `ec_product_collections`
--
ALTER TABLE `ec_product_collections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ec_product_files`
--
ALTER TABLE `ec_product_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_product_labels`
--
ALTER TABLE `ec_product_labels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ec_product_tags`
--
ALTER TABLE `ec_product_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_product_variations`
--
ALTER TABLE `ec_product_variations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_product_variation_items`
--
ALTER TABLE `ec_product_variation_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_product_views`
--
ALTER TABLE `ec_product_views`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_reviews`
--
ALTER TABLE `ec_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_review_replies`
--
ALTER TABLE `ec_review_replies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_shared_wishlists`
--
ALTER TABLE `ec_shared_wishlists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_shipments`
--
ALTER TABLE `ec_shipments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_shipment_histories`
--
ALTER TABLE `ec_shipment_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_shipping`
--
ALTER TABLE `ec_shipping`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_shipping_rules`
--
ALTER TABLE `ec_shipping_rules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ec_shipping_rule_items`
--
ALTER TABLE `ec_shipping_rule_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_store_locators`
--
ALTER TABLE `ec_store_locators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_taxes`
--
ALTER TABLE `ec_taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ec_tax_rules`
--
ALTER TABLE `ec_tax_rules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `faq_categories`
--
ALTER TABLE `faq_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `lang_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `language_meta`
--
ALTER TABLE `language_meta`
  MODIFY `lang_meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `media_files`
--
ALTER TABLE `media_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

--
-- AUTO_INCREMENT for table `media_folders`
--
ALTER TABLE `media_folders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `media_settings`
--
ALTER TABLE `media_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `menu_locations`
--
ALTER TABLE `menu_locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_nodes`
--
ALTER TABLE `menu_nodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `meta_boxes`
--
ALTER TABLE `meta_boxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=196;

--
-- AUTO_INCREMENT for table `mp_category_sale_commissions`
--
ALTER TABLE `mp_category_sale_commissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mp_customer_revenues`
--
ALTER TABLE `mp_customer_revenues`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mp_customer_withdrawals`
--
ALTER TABLE `mp_customer_withdrawals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mp_messages`
--
ALTER TABLE `mp_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mp_stores`
--
ALTER TABLE `mp_stores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mp_vendor_info`
--
ALTER TABLE `mp_vendor_info`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `newsletters`
--
ALTER TABLE `newsletters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_logs`
--
ALTER TABLE `payment_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `revisions`
--
ALTER TABLE `revisions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `simple_sliders`
--
ALTER TABLE `simple_sliders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `simple_slider_items`
--
ALTER TABLE `simple_slider_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `slugs`
--
ALTER TABLE `slugs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=340;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_meta`
--
ALTER TABLE `user_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `widgets`
--
ALTER TABLE `widgets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
