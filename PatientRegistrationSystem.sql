-- DROP DATABASE prs_database;

CREATE DATABASE prs_database;
USE prs_database;

CREATE TABLE `accounts` (
	`account_id` int NOT NULL AUTO_INCREMENT,
	`email` varchar(50) NOT NULL UNIQUE,
	`login` varchar(20) NOT NULL UNIQUE,
	`password` varchar(255) NOT NULL,
	`salt` varchar(255) NOT NULL,
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

CREATE TABLE `registration_configurations` (
	`registration_configuration_id` int NOT NULL AUTO_INCREMENT,
	`work_start` TIME NOT NULL,
	`work_end` TIME NOT NULL,
	`registration_term` DATE NOT NULL,
	`max_visits` int NOT NULL,
	`doctor_id` int NOT NULL,
	PRIMARY KEY (`registration_configuration_id`)
);

CREATE TABLE `past_visits` (
	`visit_id` int NOT NULL AUTO_INCREMENT,
	`patient_id` int NOT NULL,
	`doctor_id` int NOT NULL,
	`date` DATETIME NOT NULL,
	`purpose_id` int NOT NULL,
	`patient_appearance` bool NOT NULL,
	PRIMARY KEY (`visit_id`)
);

ALTER TABLE `doctors` ADD CONSTRAINT `doctors_fk0` FOREIGN KEY (`account_id`) REFERENCES `accounts`(`account_id`);

ALTER TABLE `patients` ADD CONSTRAINT `patients_fk0` FOREIGN KEY (`account_id`) REFERENCES `accounts`(`account_id`);

ALTER TABLE `visits` ADD CONSTRAINT `visits_fk0` FOREIGN KEY (`patient_id`) REFERENCES `patients`(`patient_id`);

ALTER TABLE `visits` ADD CONSTRAINT `visits_fk1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`);

ALTER TABLE `visits` ADD CONSTRAINT `visits_fk2` FOREIGN KEY (`purpose_id`) REFERENCES `purposes`(`purpose_id`);

ALTER TABLE `purposes` ADD CONSTRAINT `purposes_fk0` FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`);

ALTER TABLE `registration_configurations` ADD CONSTRAINT `registration_configurations_fk0` FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`);

ALTER TABLE `past_visits` ADD CONSTRAINT `past_visits_fk0` FOREIGN KEY (`patient_id`) REFERENCES `patients`(`patient_id`);

ALTER TABLE `past_visits` ADD CONSTRAINT `past_visits_fk1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`doctor_id`);

ALTER TABLE `past_visits` ADD CONSTRAINT `past_visits_fk2` FOREIGN KEY (`purpose_id`) REFERENCES `purposes`(`purpose_id`);

-- test rescords
insert into accounts values (1, 'liwdaw@gmail.com', 'liwdaw', 'password', 'salt');
insert into accounts values (2, 'gormac@gmail.com', 'gormac', 'password', 'salt');
insert into doctors values (1, 'Dawid', 'Liwocha', 'lek. dent.', 'Mazowiecka 10', '97-400', 'Bełchatów', 'Polska', '663683233', 1);
insert into doctors values (2, 'Maciej', 'Gorczyca', 'lek. dent.', 'Warszawska 20', '97-400', 'Bełchatów', 'Polska', '604875332', 2);
