-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2021 at 06:13 PM
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
-- Database: srijas
--
CREATE DATABASE IF NOT EXISTS srijas DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE srijas;

-- --------------------------------------------------------

--
-- Table structure for table job_master
--

CREATE TABLE job_master (
  job_id int(11) NOT NULL,
  job_title varchar(100) NOT NULL,
  is_active bit(1) NOT NULL,
  created_by int(11) NOT NULL,
  created_at datetime NOT NULL DEFAULT current_timestamp(),
  updated_by int(11) NOT NULL,
  updated_at datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table job_master
--


-- --------------------------------------------------------

--
-- Table structure for table resume_master
--

CREATE TABLE resume_master (
  resume_id int(11) NOT NULL,
  resume_json longtext NOT NULL,
  resume_universities varchar(1000) DEFAULT NULL,
  resume_degrees varchar(1000) NOT NULL,
  resume_links varchar(1000) NOT NULL,
  resume_summary varchar(1000) NOT NULL,
  is_active bit(1) NOT NULL,
  created_by int(11) NOT NULL,
  created_at datetime NOT NULL DEFAULT current_timestamp(),
  updated_by int(11) NOT NULL,
  updated_at datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table resume_skills
--

CREATE TABLE resume_skills (
  resume_skill_id int(11) NOT NULL,
  resume_id int(11) NOT NULL,
  skill_id int(11) NOT NULL,
  is_active bit(1) NOT NULL,
  created_by int(11) NOT NULL,
  created_at datetime NOT NULL DEFAULT current_timestamp(),
  updated_by int(11) NOT NULL,
  updated_at datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table skill_master
--

CREATE TABLE skill_master (
  skill_id int(11) NOT NULL,
  skill_title varchar(100) NOT NULL,
  is_active bit(1) NOT NULL,
  created_by int(11) NOT NULL,
  created_at datetime NOT NULL DEFAULT current_timestamp(),
  updated_by int(11) NOT NULL,
  updated_at datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Table structure for table user_master
--

CREATE TABLE user_master (
  user_id int(11) NOT NULL,
  user_fname varchar(50) NOT NULL,
  user_lname varchar(50) DEFAULT NULL,
  user_email varchar(50) NOT NULL,
  user_preferred_job_id int(11) NOT NULL,
  is_active bit(1) NOT NULL,
  created_by int(11) NOT NULL,
  created_at datetime NOT NULL DEFAULT current_timestamp(),
  updated_by int(11) DEFAULT NULL,
  updated_at datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table user_resume
--

CREATE TABLE user_resume (
  user_resume_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  resume_id int(11) NOT NULL,
  is_active bit(1) NOT NULL,
  created_by int(11) NOT NULL,
  created_at datetime NOT NULL DEFAULT current_timestamp(),
  updated_by int(11) NOT NULL,
  updated_at datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table job_master
--
ALTER TABLE job_master
  ADD PRIMARY KEY (job_id);

--
-- Indexes for table resume_master
--
ALTER TABLE resume_master
  ADD PRIMARY KEY (resume_id);

--
-- Indexes for table resume_skills
--
ALTER TABLE resume_skills
  ADD PRIMARY KEY (resume_skill_id),
  ADD KEY resume_skills_resume_fk (resume_id),
  ADD KEY resume_skills_skills_fk (skill_id);

--
-- Indexes for table skill_master
--
ALTER TABLE skill_master
  ADD PRIMARY KEY (skill_id);

--
-- Indexes for table user_master
--
ALTER TABLE user_master
  ADD PRIMARY KEY (user_id),
  ADD KEY user_job_fk (user_preferred_job_id);

--
-- Indexes for table user_resume
--
ALTER TABLE user_resume
  ADD PRIMARY KEY (user_resume_id),
  ADD KEY user_resume_user_fk (user_id),
  ADD KEY user_resume_resume_fk (resume_id);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table job_master
--
ALTER TABLE job_master
  MODIFY job_id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table resume_master
--
ALTER TABLE resume_master
  MODIFY resume_id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table resume_skills
--
ALTER TABLE resume_skills
  MODIFY resume_skill_id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table skill_master
--
ALTER TABLE skill_master
  MODIFY skill_id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table user_master
--
ALTER TABLE user_master
  MODIFY user_id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table user_resume
--
ALTER TABLE user_resume
  MODIFY user_resume_id int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table resume_skills
--
ALTER TABLE resume_skills
  ADD CONSTRAINT resume_skills_resume_fk FOREIGN KEY (resume_id) REFERENCES resume_master (resume_id),
  ADD CONSTRAINT resume_skills_skills_fk FOREIGN KEY (skill_id) REFERENCES skill_master (skill_id);

--
-- Constraints for table user_master
--
ALTER TABLE user_master
  ADD CONSTRAINT user_job_fk FOREIGN KEY (user_preferred_job_id) REFERENCES job_master (job_id);

--
-- Constraints for table user_resume
--
ALTER TABLE user_resume
  ADD CONSTRAINT user_resume_resume_fk FOREIGN KEY (resume_id) REFERENCES resume_master (resume_id),
  ADD CONSTRAINT user_resume_user_fk FOREIGN KEY (user_id) REFERENCES user_master (user_id);
COMMIT;

INSERT INTO job_master (job_title, is_active, created_by) VALUES
('Software Engineer', 1, -1),
('Software Developer', 1, -1),
('Software Engineer Intern', 1, -1),
('Software Developer Intern', 1, -1);

INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("C", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Java", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Python", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("C++", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("C#", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Visual Basic", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("JavaScript", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Assembly Language", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("PHP", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("SQL", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Classic Visual Basic", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Delphi/Object Pascal", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Ruby", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Go", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Swift", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("R", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Groovy", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Perl", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("MATLAB", 1, -1);
INSERT INTO skill_master(skill_title, is_active, created_by) VALUES ("Fortran", 1, -1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
