-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2022 at 05:38 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `slits_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `favrt_tble`
--

DROP TABLE IF EXISTS `favrt_tble`;
CREATE TABLE IF NOT EXISTS `favrt_tble` (
  `v_id` varchar(300) DEFAULT NULL,
  `v_title` varchar(600) DEFAULT NULL,
  `v_description` varchar(600) DEFAULT NULL,
  `thumb_img` varchar(600) DEFAULT NULL,
  `video_url` varchar(600) DEFAULT NULL,
  `user_id` varchar(250) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `suggestion_tbl`
--

DROP TABLE IF EXISTS `suggestion_tbl`;
CREATE TABLE IF NOT EXISTS `suggestion_tbl` (
  `s_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(500) DEFAULT NULL,
  `admin_id` varchar(500) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `s_title` varchar(250) DEFAULT NULL,
  `s_description` varchar(500) DEFAULT NULL,
  `image` varchar(1000) DEFAULT NULL,
  `is_view` varchar(50) DEFAULT NULL,
  `user_type` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suggestion_tbl`
--

INSERT INTO `suggestion_tbl` (`s_id`, `user_id`, `admin_id`, `name`, `s_title`, `s_description`, `image`, `is_view`, `user_type`) VALUES
(1, '1', '2', 'Atif Khan', 'Can we add somthing else', 'means we can also add subtitle in the video', 'img', '0', 'Admin'),
(2, '1', NULL, 'atif', 'hello world', '', NULL, '1', 'User'),
(3, '1', NULL, 'atif', 'hello world', '', NULL, '1', 'User'),
(4, '1', NULL, 'atif', 'hello world', 'hi bro', NULL, '1', 'User'),
(5, '1', NULL, 'atif', 'hello world', 'hi bro', NULL, '1', 'User'),
(6, '1', NULL, 'Admin', 'hello world: thanks for your suggestions', NULL, NULL, '0', 'Admin'),
(7, '1', NULL, 'atif', 'test title', 'description', NULL, '1', 'User'),
(8, '1', NULL, 'Admin', 'test title: okay', NULL, NULL, '0', 'Admin'),
(9, '1', NULL, 'atif', 'fffhhh', 'vvvvvvvh', NULL, '1', 'User'),
(10, '1', NULL, 'Admin', 'fffhhh: ok', NULL, NULL, '0', 'Admin'),
(11, '1', NULL, 'atif', 'llll', 'kkkk', NULL, '1', 'User'),
(12, '1', NULL, 'Admin', 'llll: ooo', NULL, NULL, '0', 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `user_registration`
--

DROP TABLE IF EXISTS `user_registration`;
CREATE TABLE IF NOT EXISTS `user_registration` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(500) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `phoneNumber` varchar(500) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `password` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_registration`
--

INSERT INTO `user_registration` (`user_id`, `user_type`, `name`, `phoneNumber`, `email`, `password`) VALUES
(1, 'User', 'atif', '333333333', 'cccc@gmail.com', '123456'),
(2, 'Admin', 'Admin', '013234234', 'superadmin@gmail.com', 'admin001'),
(3, 'User', 'Mahad', '885555', 'm@gmail.com', '123456'),
(4, 'User', 'kk', '00055566', 'kkk@gmail.com', '12345678');

-- --------------------------------------------------------

--
-- Table structure for table `videos_tbl`
--

DROP TABLE IF EXISTS `videos_tbl`;
CREATE TABLE IF NOT EXISTS `videos_tbl` (
  `v_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` varchar(200) DEFAULT NULL,
  `v_title` varchar(500) DEFAULT NULL,
  `v_description` varchar(2000) DEFAULT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `thumb_img` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`v_id`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `videos_tbl`
--

INSERT INTO `videos_tbl` (`v_id`, `admin_id`, `v_title`, `v_description`, `video_url`, `thumb_img`) VALUES
(37, '2', 'fsd', 'sdfsd', 'http://192.168.100.3/SlitsApi/videos/VID-20191012-WA0004.mp4', 'http://192.168.100.3/SlitsApi/thumbnail/learning.jpg'),
(36, '2', 'fsd', 'sdfsd', 'http://192.168.100.3/SlitsApi/videos/VID-20191012-WA0004.mp4', 'http://192.168.100.3/SlitsApi/thumbnail/learning.jpg'),
(76, '2', 'yyy', 'bbb', 'http://192.168.100.3/SlitsApi/videos/videoplayback.mp4', 'http://192.168.100.3/SlitsApi/thumbnail/IMG_20220323_014844.jpg'),
(74, '121', 'new test title video', 'test description video uploading', 'http://192.168.100.3/SlitsApi/videos/videoplayback.mp4', 'http://192.168.100.3/SlitsApi/thumbnail/IMG_20220323_014844.jpg'),
(73, '121', 'new', 'test descri nnngg', 'http://192.168.100.3/SlitsApi/videos/VID-20191012-WA0004.mp4', 'http://192.168.100.3/SlitsApi/thumbnail/IMG_20220321_164208.jpg'),
(75, '2', 'sabida', 'bbddhh', 'http://192.168.100.3/SlitsApi/videos/videoplayback.mp4', 'http://192.168.100.3/SlitsApi/thumbnail/IMG_20220323_014844.jpg');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
