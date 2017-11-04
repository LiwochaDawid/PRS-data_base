CREATE DATABASE PatientRegistrationSystem;
USE PatientRegistrationSystem;

CREATE TABLE `Accounts` (
	`accountID` int NOT NULL AUTO_INCREMENT,
	`login` varchar(20) NOT NULL UNIQUE,
	`password` varchar(255) NOT NULL,
	`salt` varchar(255) NOT NULL,
	PRIMARY KEY (`accountID`)
);

CREATE TABLE `Doctors` (
	`doctorID` int NOT NULL AUTO_INCREMENT,
	`name` varchar(20) NOT NULL,
	`surname` varchar(50) NOT NULL,
	`prefix` varchar(20) NOT NULL,
	`street` varchar(50) NOT NULL,
	`postCode` varchar(20) NOT NULL,
	`city` varchar(50) NOT NULL,
	`country` varchar(50) NOT NULL,
	`phoneNumber` varchar(20) NOT NULL,
	`email` varchar(50) NOT NULL UNIQUE,
	`accountID` int NOT NULL,
	PRIMARY KEY (`doctorID`)
);

CREATE TABLE `Patients` (
	`patientID` int NOT NULL AUTO_INCREMENT,
	`name` varchar(20) NOT NULL,
	`surname` varchar(50) NOT NULL,
	`street` varchar(50) NOT NULL,
	`postCode` varchar(20) NOT NULL,
	`city` varchar(50) NOT NULL,
	`country` varchar(50) NOT NULL,
	`phoneNumber` varchar(20) NOT NULL,
	`email` varchar(50),
	`accountID` int NOT NULL,
	PRIMARY KEY (`patientID`)
);

CREATE TABLE `Visits` (
	`visitID` int NOT NULL AUTO_INCREMENT,
	`patientID` int NOT NULL,
	`doctorID` int NOT NULL,
	`date` DATETIME NOT NULL,
	`purposeID` int NOT NULL,
	`comment` TEXT NOT NULL,
	PRIMARY KEY (`visitID`)
);

CREATE TABLE `Purposes` (
	`purposeID` int NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	`description` TEXT NOT NULL,
	`duration` TIME NOT NULL,
	`price` int NOT NULL,
	`doctorID` int NOT NULL,
	PRIMARY KEY (`purposeID`)
);

CREATE TABLE `RegistrationConfigurations` (
	`registrationConfigurationID` int NOT NULL AUTO_INCREMENT,
	`workStart` TIME NOT NULL,
	`workEnd` TIME NOT NULL,
	`registrationTerm` DATE NOT NULL,
	`maxVisitsNumber` int NOT NULL,
	`doctorID` int NOT NULL,
	PRIMARY KEY (`registrationConfigurationID`)
);

CREATE TABLE `PastVisits` (
	`visitID` int NOT NULL AUTO_INCREMENT,
	`patientID` int NOT NULL,
	`doctorID` int NOT NULL,
	`date` DATETIME NOT NULL,
	`purposeID` int NOT NULL,
	`patientAppearance` bool NOT NULL,
	PRIMARY KEY (`visitID`)
);

ALTER TABLE `Doctors` ADD CONSTRAINT `Doctors_fk0` FOREIGN KEY (`accountID`) REFERENCES `Accounts`(`accountID`);

ALTER TABLE `Patients` ADD CONSTRAINT `Patients_fk0` FOREIGN KEY (`accountID`) REFERENCES `Accounts`(`accountID`);

ALTER TABLE `Visits` ADD CONSTRAINT `Visits_fk0` FOREIGN KEY (`patientID`) REFERENCES `Patients`(`patientID`);

ALTER TABLE `Visits` ADD CONSTRAINT `Visits_fk1` FOREIGN KEY (`doctorID`) REFERENCES `Doctors`(`doctorID`);

ALTER TABLE `Visits` ADD CONSTRAINT `Visits_fk2` FOREIGN KEY (`purposeID`) REFERENCES `Purposes`(`purposeID`);

ALTER TABLE `Purposes` ADD CONSTRAINT `Purposes_fk0` FOREIGN KEY (`doctorID`) REFERENCES `Doctors`(`doctorID`);

ALTER TABLE `RegistrationConfigurations` ADD CONSTRAINT `RegistrationConfigurations_fk0` FOREIGN KEY (`doctorID`) REFERENCES `Doctors`(`doctorID`);

ALTER TABLE `PastVisits` ADD CONSTRAINT `PastVisits_fk0` FOREIGN KEY (`patientID`) REFERENCES `Patients`(`patientID`);

ALTER TABLE `PastVisits` ADD CONSTRAINT `PastVisits_fk1` FOREIGN KEY (`doctorID`) REFERENCES `Doctors`(`doctorID`);

ALTER TABLE `PastVisits` ADD CONSTRAINT `PastVisits_fk2` FOREIGN KEY (`purposeID`) REFERENCES `Purposes`(`purposeID`);
