-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 02, 2021 at 07:29 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

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

CREATE TABLE `job_master` (
  `job_id` int(11) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `job_master`
--

INSERT INTO `job_master` (`job_id`, `job_title`, `is_active`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'Software Engineer', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(2, 'Software Developer', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(3, 'Software Engineer Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(4, 'Software Developer Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(5, 'Cloud Platform Engineer Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(6, 'Cloud Platform Engineer', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(7, 'DevOps Engineer Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(8, 'DevOps Engineer', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(9, 'Full Stack Engineer Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(10, 'Full Stack Engineer', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(11, 'Machine Learning Engineer Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(12, 'Machine Learning Engineer', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(13, 'Data Science Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(14, 'Data Scientist', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(15, 'Data Analytics Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(16, 'Data Analyst', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(17, 'Big Data Engineer Intern', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(18, 'Big Data Engineer', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31');

-- --------------------------------------------------------

--
-- Table structure for table `resume_master`
--

CREATE TABLE `resume_master` (
  `resume_id` int(11) NOT NULL,
  `resume_json` longtext NOT NULL,
  `resume_universities` varchar(1000) DEFAULT NULL,
  `resume_degrees` varchar(1000) NOT NULL,
  `resume_links` varchar(1000) NOT NULL,
  `resume_summary` varchar(1000) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `resume_skills`
--

CREATE TABLE `resume_skills` (
  `resume_skill_id` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `skill_master`
--

CREATE TABLE `skill_master` (
  `skill_id` int(11) NOT NULL,
  `skill_title` varchar(100) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `skill_master`
--

INSERT INTO `skill_master` (`skill_id`, `skill_title`, `is_active`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'C', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(2, 'Java', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(3, 'Python', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(4, 'C++', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(5, 'C#', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(6, 'Visual Basic', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(7, 'JavaScript', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(8, 'Assembly Language', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(9, 'PHP', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(10, 'SQL', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(11, 'Classic Visual Basic', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(12, 'Delphi/Object Pascal', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(13, 'Ruby', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(14, 'Go', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(15, 'Swift', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(16, 'R', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(17, 'Groovy', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(18, 'Perl', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(19, 'MATLAB', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(20, 'Fortran', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(21, 'AWS', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(22, 'Azure', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(23, 'GCP', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(24, 'MATLAB', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(25, 'Terraform', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(26, 'Ansible', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(27, 'node.js', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(28, 'React', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(29, 'Angular', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(30, 'Splunk', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(31, 'Jenkins', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(32, 'Git', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(33, 'Jira', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(34, 'Flask', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(35, 'Django', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(36, 'Angular', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(37, 'Splunk', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(38, 'OpenCV', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(39, 'Tensorflow', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(40, 'Scikit-learn', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(41, 'Keras', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(42, 'Linux', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(43, 'Ruby on Rails', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(44, 'SQL', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(45, 'MySQL', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(46, 'MSSQL', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(47, 'GraphSQL', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(48, 'MongoDB', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(49, 'PostGreSQL', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(50, 'Hadoop', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(51, 'Kafka', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(52, 'Cassandra', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31'),
(53, 'Elasticeearch', b'1', -1, '2021-11-01 04:44:31', 0, '2021-11-01 04:44:31');


-- --------------------------------------------------------

--
-- Table structure for table `user_master`
--

CREATE TABLE `user_master` (
  `user_id` int(11) NOT NULL,
  `user_fname` varchar(50) NOT NULL,
  `user_lname` varchar(50) DEFAULT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_password` varchar(20) NOT NULL,
  `user_location` varchar(20) DEFAULT NULL,
  `user_threshold` int(11) DEFAULT 100,
  `user_preferred_job_id` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_master`
--

-- --------------------------------------------------------

--
-- Table structure for table `user_resume`
--

CREATE TABLE `user_resume` (
  `user_resume_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `resume_id` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `job_master`
--
ALTER TABLE `job_master`
  ADD PRIMARY KEY (`job_id`);

--
-- Indexes for table `resume_master`
--
ALTER TABLE `resume_master`
  ADD PRIMARY KEY (`resume_id`);

--
-- Indexes for table `resume_skills`
--
ALTER TABLE `resume_skills`
  ADD PRIMARY KEY (`resume_skill_id`),
  ADD KEY `resume_skills_resume_fk` (`resume_id`),
  ADD KEY `resume_skills_skills_fk` (`skill_id`);

--
-- Indexes for table `skill_master`
--
ALTER TABLE `skill_master`
  ADD PRIMARY KEY (`skill_id`);

--
-- Indexes for table `user_master`
--
ALTER TABLE `user_master`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD KEY `user_job_fk` (`user_preferred_job_id`);

--
-- Indexes for table `user_resume`
--
ALTER TABLE `user_resume`
  ADD PRIMARY KEY (`user_resume_id`),
  ADD KEY `user_resume_user_fk` (`user_id`),
  ADD KEY `user_resume_resume_fk` (`resume_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `job_master`
--
ALTER TABLE `job_master`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `resume_master`
--
ALTER TABLE `resume_master`
  MODIFY `resume_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resume_skills`
--
ALTER TABLE `resume_skills`
  MODIFY `resume_skill_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `skill_master`
--
ALTER TABLE `skill_master`
  MODIFY `skill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `user_master`
--
ALTER TABLE `user_master`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_resume`
--
ALTER TABLE `user_resume`
  MODIFY `user_resume_id` int(11) NOT NULL AUTO_INCREMENT;

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
