DROP DATABASE IF EXISTS `learning_management_system`;
CREATE DATABASE `learning_management_system`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE `learning_management_system`;

-- Stores the instructors responsible for teaching courses.
CREATE TABLE `instructors` (
  `instructor_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`instructor_id`)
) ENGINE=InnoDB;

-- Stores the courses offered by the school.
CREATE TABLE `courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `instructor_id` SMALLINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`course_id`),
  KEY `idx_courses_instructor_id` (`instructor_id`),
  CONSTRAINT `fk_courses_instructors`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `instructors` (`instructor_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Stores descriptive tags that can be assigned to courses.
CREATE TABLE `tags` (
  `tag_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `uq_tags_name` (`name`)
) ENGINE=InnoDB;

-- Resolves the many-to-many relationship between courses and tags.
CREATE TABLE `course_tags` (
  `course_id` INT NOT NULL,
  `tag_id` TINYINT NOT NULL,
  PRIMARY KEY (`course_id`, `tag_id`),
  KEY `idx_course_tags_tag_id` (`tag_id`),
  CONSTRAINT `fk_course_tags_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `courses` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_course_tags_tags`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tags` (`tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Stores student registration information.
CREATE TABLE `students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `date_registered` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `uq_students_email` (`email`)
) ENGINE=InnoDB;

-- Records which students enroll in which courses.
CREATE TABLE `enrollments` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `enrollment_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price` DECIMAL(7,2) NOT NULL,
  `coupon` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`student_id`, `course_id`),
  KEY `idx_enrollments_course_id` (`course_id`),
  CONSTRAINT `fk_enrollments_students`
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollments_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `courses` (`course_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Sample records
-- -----------------------------------------------------

INSERT INTO `instructors` (`instructor_id`, `name`) VALUES
  (1, 'Amelia Carter'),
  (2, 'Benjamin Ortiz'),
  (3, 'Chloe Williams'),
  (4, 'Daniel Kim'),
  (5, 'Elena Rodriguez'),
  (6, 'Marcus Thompson'),
  (7, 'Nadia Patel'),
  (8, 'Owen Brooks');

INSERT INTO `courses` (`course_id`, `instructor_id`, `title`, `price`) VALUES
  (1, 1, 'Introduction to Database Design', 149.00),
  (2, 1, 'Advanced SQL and Query Optimization', 229.00),
  (3, 2, 'Python Fundamentals', 179.00),
  (4, 2, 'Python for Data Analysis', 249.00),
  (5, 3, 'Data Governance Foundations', 199.00),
  (6, 3, 'Regulatory Compliance Essentials', 219.00),
  (7, 4, 'Business Intelligence with Power BI', 239.00),
  (8, 4, 'Data Visualization with Tableau', 229.00),
  (9, 5, 'Lean Six Sigma Fundamentals', 189.00),
  (10, 5, 'Process Mapping and Improvement', 169.00),
  (11, 6, 'Project Management Essentials', 199.00),
  (12, 6, 'Agile Project Delivery', 189.00),
  (13, 7, 'Enterprise Risk Management', 259.00),
  (14, 7, 'Privacy and Third Party Risk', 249.00),
  (15, 8, 'Supply Chain Traceability with EPCIS 2.0', 279.00);

INSERT INTO `tags` (`tag_id`, `name`) VALUES
  (1, 'Database'),
  (2, 'SQL'),
  (3, 'Python'),
  (4, 'Analytics'),
  (5, 'Governance'),
  (6, 'Compliance'),
  (7, 'Process Improvement'),
  (8, 'Project Management'),
  (9, 'Enterprise Risk'),
  (10, 'Supply Chain');

INSERT INTO `course_tags` (`course_id`, `tag_id`) VALUES
  (1, 1),
  (1, 2),
  (2, 1),
  (2, 2),
  (3, 3),
  (4, 3),
  (4, 4),
  (5, 5),
  (6, 5),
  (6, 6),
  (7, 4),
  (8, 4),
  (9, 7),
  (10, 7),
  (11, 8),
  (12, 8),
  (13, 9),
  (13, 6),
  (14, 6),
  (14, 9),
  (15, 5),
  (15, 10);

INSERT INTO `students` (
  `student_id`,
  `first_name`,
  `last_name`,
  `email`,
  `date_registered`
) VALUES
  (1, 'Ava', 'Mitchell', 'ava.mitchell@example.com', '2026-01-08 09:15:00'),
  (2, 'Liam', 'Turner', 'liam.turner@example.com', '2026-01-12 14:30:00'),
  (3, 'Sophia', 'Nguyen', 'sophia.nguyen@example.com', '2026-01-19 11:05:00'),
  (4, 'Noah', 'Ramirez', 'noah.ramirez@example.com', '2026-02-03 16:20:00'),
  (5, 'Isabella', 'Foster', 'isabella.foster@example.com', '2026-02-10 10:45:00'),
  (6, 'Ethan', 'Collins', 'ethan.collins@example.com', '2026-02-18 13:10:00'),
  (7, 'Mia', 'Stewart', 'mia.stewart@example.com', '2026-03-02 08:55:00'),
  (8, 'Lucas', 'Reed', 'lucas.reed@example.com', '2026-03-14 15:40:00'),
  (9, 'Camila', 'Parker', 'camila.parker@example.com', '2026-04-06 09:35:00'),
  (10, 'Mateo', 'Sullivan', 'mateo.sullivan@example.com', '2026-04-21 12:25:00'),
  (11, 'Harper', 'Bennett', 'harper.bennett@example.com', '2026-05-07 14:05:00'),
  (12, 'Elijah', 'Morris', 'elijah.morris@example.com', '2026-05-19 10:15:00'),
  (13, 'Luna', 'Price', 'luna.price@example.com', '2026-06-04 16:50:00'),
  (14, 'James', 'Richardson', 'james.richardson@example.com', '2026-06-22 11:30:00'),
  (15, 'Sofia', 'Campbell', 'sofia.campbell@example.com', '2026-07-09 13:45:00'),
  (16, 'Henry', 'Evans', 'henry.evans@example.com', '2026-07-18 09:20:00'),
  (17, 'Victoria', 'Torres', 'victoria.torres@example.com', '2026-08-01 14:10:00'),
  (18, 'Alexander', 'Murphy', 'alexander.murphy@example.com', '2026-08-11 10:40:00'),
  (19, 'Grace', 'Rivera', 'grace.rivera@example.com', '2026-08-17 12:05:00'),
  (20, 'Sebastian', 'Cooper', 'sebastian.cooper@example.com', '2026-08-24 15:25:00');

INSERT INTO `enrollments` (
  `student_id`,
  `course_id`,
  `enrollment_date`,
  `price`,
  `coupon`
) VALUES
  (1, 1, '2026-01-09 10:00:00', 149.00, NULL),
  (1, 5, '2026-01-10 11:30:00', 169.15, 'WELCOME15'),
  (1, 15, '2026-02-01 09:45:00', 251.10, 'TRACE10'),
  (2, 3, '2026-01-13 15:15:00', 152.15, 'WELCOME15'),
  (2, 11, '2026-02-05 13:00:00', 199.00, NULL),
  (3, 2, '2026-01-20 12:20:00', 229.00, NULL),
  (3, 7, '2026-02-11 10:30:00', 215.10, 'ANALYTICS10'),
  (4, 6, '2026-02-04 17:00:00', 186.15, 'WELCOME15'),
  (4, 13, '2026-03-08 09:10:00', 259.00, NULL),
  (5, 4, '2026-02-11 11:20:00', 249.00, NULL),
  (5, 8, '2026-03-01 14:40:00', 206.10, 'ANALYTICS10'),
  (6, 9, '2026-02-19 14:00:00', 160.65, 'WELCOME15'),
  (6, 10, '2026-03-12 16:30:00', 169.00, NULL),
  (7, 5, '2026-03-03 09:25:00', 199.00, NULL),
  (7, 14, '2026-04-07 11:45:00', 224.10, 'RISK10'),
  (8, 1, '2026-03-15 16:10:00', 126.65, 'WELCOME15'),
  (8, 2, '2026-04-02 10:50:00', 229.00, NULL),
  (9, 7, '2026-04-07 10:15:00', 239.00, NULL),
  (9, 8, '2026-04-09 13:25:00', 206.10, 'ANALYTICS10'),
  (10, 11, '2026-04-22 13:10:00', 169.15, 'WELCOME15'),
  (10, 12, '2026-05-05 15:35:00', 189.00, NULL),
  (11, 6, '2026-05-08 15:00:00', 219.00, NULL),
  (11, 13, '2026-05-10 09:30:00', 233.10, 'RISK10'),
  (12, 3, '2026-05-20 11:00:00', 152.15, 'WELCOME15'),
  (12, 4, '2026-06-02 14:20:00', 249.00, NULL),
  (13, 9, '2026-06-05 17:15:00', 189.00, NULL),
  (13, 15, '2026-06-09 10:10:00', 251.10, 'TRACE10'),
  (14, 10, '2026-06-23 12:20:00', 143.65, 'WELCOME15'),
  (14, 12, '2026-07-02 09:50:00', 189.00, NULL),
  (15, 5, '2026-07-10 14:35:00', 169.15, 'WELCOME15'),
  (15, 14, '2026-07-15 11:05:00', 224.10, 'RISK10'),
  (16, 1, '2026-07-19 10:45:00', 149.00, NULL),
  (16, 7, '2026-07-22 13:15:00', 215.10, 'ANALYTICS10'),
  (17, 2, '2026-08-02 15:20:00', 194.65, 'WELCOME15'),
  (17, 6, '2026-08-05 09:40:00', 219.00, NULL),
  (18, 4, '2026-08-12 11:55:00', 211.65, 'WELCOME15'),
  (18, 15, '2026-08-14 14:25:00', 251.10, 'TRACE10'),
  (19, 8, '2026-08-18 13:30:00', 194.65, 'WELCOME15'),
  (19, 9, '2026-08-20 10:05:00', 189.00, NULL),
  (20, 11, '2026-08-25 16:00:00', 169.15, 'WELCOME15'),
  (20, 13, '2026-08-27 09:15:00', 233.10, 'RISK10');
