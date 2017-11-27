-- DROP DATABASE prs_database;

CREATE DATABASE prs_database;
USE prs_database;

CREATE TABLE `accounts` (
	`account_id` int NOT NULL AUTO_INCREMENT,
	`username` varchar(50) NOT NULL UNIQUE,
	`password` varchar(255) NOT NULL,
	`role` varchar(20) NOT NULL,
	`enabled` boolean NOT NULL,
	PRIMARY KEY (`account_id`)
);

CREATE TABLE `doctors` (
	`doctor_id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(20) NOT NULL,
	`surname` varchar(50) NOT NULL,
	`prefix` varchar(20) NOT NULL,
	`street` varchar(50) NOT NULL,
	`postcode` varchar(20) NOT NULL,
	`city` varchar(50) NOT NULL,
	`country` varchar(50) NOT NULL,
	`phone_number` varchar(20) NOT NULL,
	`account_id` int NOT NULL,
	PRIMARY KEY (`doctor_id`)
);

CREATE TABLE `patients` (
	`patient_id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(20) NOT NULL,
	`surname` varchar(50) NOT NULL,
	`street` varchar(50) NOT NULL,
	`postcode` varchar(20) NOT NULL,
	`city` varchar(50) NOT NULL,
	`country` varchar(50) NOT NULL,
	`phone_number` varchar(20) NOT NULL,
	`account_id` int NULL,
	PRIMARY KEY (`patient_id`)
);

CREATE TABLE `visits` (
	`visit_id` int NOT NULL AUTO_INCREMENT,
	`patient_id` int NOT NULL,
	`doctor_id` int NOT NULL,
	`date` DATETIME NOT NULL,
	`purpose_id` int NOT NULL,
	`comment` TEXT NULL,
	PRIMARY KEY (`visit_id`)
);

CREATE TABLE `purposes` (
	`purpose_id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	`description` TEXT NULL,
	`duration` TIME NOT NULL,
	`price` int NULL,
	`doctor_id` int NOT NULL,
	PRIMARY KEY (`purpose_id`)
);

CREATE TABLE `configurations` (
	`configuration_id` int NOT NULL AUTO_INCREMENT,
	`mo_work_start` TIME NOT NULL,
	`mo_work_end` TIME NOT NULL,
	`tu_work_start` TIME NOT NULL,
	`tu_work_end` TIME NOT NULL,
	`we_work_start` TIME NOT NULL,
	`we_work_end` TIME NOT NULL,
	`th_work_start` TIME NOT NULL,
	`th_work_end` TIME NOT NULL,
	`fr_work_start` TIME NOT NULL,
	`fr_work_end` TIME NOT NULL,
	`sa_work_start` TIME NOT NULL,
	`sa_work_end` TIME NOT NULL,
	`su_work_start` TIME NOT NULL,
	`su_work_end` TIME NOT NULL,
	`registration_term` DATE NOT NULL,
	`max_visits` int NOT NULL,
	`doctor_id` int NOT NULL,
	PRIMARY KEY (`configuration_id`)
);

ALTER TABLE `doctors` ADD CONSTRAINT `doctors_fk0` FOREIGN KEY (`account_id`) REFERENCES `accounts`(`account_id`);

ALTER TABLE `patients` ADD CONSTRAINT `patients_fk0` FOREIGN KEY (`account_id`) REFERENCES `accounts`(`account_id`);

ALTER TABLE `visits` ADD CONSTRAINT `visits_fk0` FOREIGN KEY (`patient_id`) REFERENCES `patients`(`patient_id`);

ALTER TABLE `visits` ADD CONSTRAINT `visits_fk1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`);

ALTER TABLE `visits` ADD CONSTRAINT `visits_fk2` FOREIGN KEY (`purpose_id`) REFERENCES `purposes`(`purpose_id`);

ALTER TABLE `purposes` ADD CONSTRAINT `purposes_fk0` FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`);

ALTER TABLE `configurations` ADD CONSTRAINT `configurations_fk0` FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`);
