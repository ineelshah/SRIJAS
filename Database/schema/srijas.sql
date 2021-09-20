-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 20, 2021 at 05:28 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `srijas`
--
CREATE DATABASE IF NOT EXISTS `srijas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `srijas`;

-- --------------------------------------------------------

--
-- Table structure for table `job_master`
--

DROP TABLE IF EXISTS `job_master`;
CREATE TABLE IF NOT EXISTS `job_master` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_title` varchar(100) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `resume_master`
--

DROP TABLE IF EXISTS `resume_master`;
CREATE TABLE IF NOT EXISTS `resume_master` (
  `resume_id` int(11) NOT NULL AUTO_INCREMENT,
  `resume_json` longtext NOT NULL,
  `resume_universities` varchar(1000) DEFAULT NULL,
  `resume_degrees` varchar(1000) NOT NULL,
  `resume_links` varchar(1000) NOT NULL,
  `resume_summary` varchar(1000) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `resume_skills`
--

DROP TABLE IF EXISTS `resume_skills`;
CREATE TABLE IF NOT EXISTS `resume_skills` (
  `resume_skill_id` int(11) NOT NULL AUTO_INCREMENT,
  `resume_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`resume_skill_id`),
  KEY `resume_skills_resume_fk` (`resume_id`),
  KEY `resume_skills_skills_fk` (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `skill_master`
--

DROP TABLE IF EXISTS `skill_master`;
CREATE TABLE IF NOT EXISTS `skill_master` (
  `skill_id` int(11) NOT NULL AUTO_INCREMENT,
  `skill_title` varchar(100) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_master`
--

DROP TABLE IF EXISTS `user_master`;
CREATE TABLE IF NOT EXISTS `user_master` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_fname` varchar(50) NOT NULL,
  `user_lname` varchar(50) DEFAULT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_preferred_job_id` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  KEY `user_job_fk` (`user_preferred_job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_resume`
--

DROP TABLE IF EXISTS `user_resume`;
CREATE TABLE IF NOT EXISTS `user_resume` (
  `user_resume_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_resume_id`),
  KEY `user_resume_user_fk` (`user_id`),
  KEY `user_resume_resume_fk` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `resume_skills`
--
ALTER TABLE `resume_skills`
  ADD CONSTRAINT `resume_skills_resume_fk` FOREIGN KEY (`resume_id`) REFERENCES `resume_master` (`resume_id`),
  ADD CONSTRAINT `resume_skills_skills_fk` FOREIGN KEY (`skill_id`) REFERENCES `skill_master` (`skill_id`);

--
-- Constraints for table `user_master`
--
ALTER TABLE `user_master`
  ADD CONSTRAINT `user_job_fk` FOREIGN KEY (`user_preferred_job_id`) REFERENCES `job_master` (`job_id`);

--
-- Constraints for table `user_resume`
--
ALTER TABLE `user_resume`
  ADD CONSTRAINT `user_resume_resume_fk` FOREIGN KEY (`resume_id`) REFERENCES `resume_master` (`resume_id`),
  ADD CONSTRAINT `user_resume_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user_master` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
