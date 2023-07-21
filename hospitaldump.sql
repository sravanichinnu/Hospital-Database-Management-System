CREATE DATABASE  IF NOT EXISTS `hospital` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hospital`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: hospital
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Cashier`
--

DROP TABLE IF EXISTS `Cashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cashier` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `bill_amount` decimal(10,2) DEFAULT NULL,
  `patient_id` int NOT NULL,
  `room_type` varchar(30) DEFAULT NULL,
  `total_room_cost` decimal(10,2) DEFAULT NULL,
  `surgery_fee` decimal(10,2) DEFAULT NULL,
  `medicine_costs` decimal(10,2) DEFAULT NULL,
  `DateTime` datetime DEFAULT NULL,
  `coverage` decimal(10,2) DEFAULT NULL,
  `final_bill_after_insurance` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`bill_id`,`patient_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `cashier_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `Patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cashier`
--

LOCK TABLES `Cashier` WRITE;
/*!40000 ALTER TABLE `Cashier` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cashier` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_discharge_status` AFTER UPDATE ON `cashier` FOR EACH ROW begin
	if new.final_bill_after_insurance = 0 then
		update Patient set is_discharged = 'yes' where patient_id = new.patient_id;
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (101,'Cardiology'),(102,'Gynecology'),(103,'Neurology'),(104,'Oncology'),(105,'Ophthamology'),(106,'Nursing'),(107,'Radiology'),(108,'Emergency');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hospital`
--

DROP TABLE IF EXISTS `Hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Hospital` (
  `name` varchar(255) NOT NULL,
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `no_of_employees` int DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `visiting_hours` varchar(50) NOT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16003 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hospital`
--

LOCK TABLES `Hospital` WRITE;
/*!40000 ALTER TABLE `Hospital` DISABLE KEYS */;
INSERT INTO `Hospital` VALUES ('SRK Hospitals',16001,15,'Boston, MA','11:00:00 - 18:00:00'),('SRK Hospitals',16002,15,'Virginia','12:00:00 - 18:00:00');
/*!40000 ALTER TABLE `Hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Insurance`
--

DROP TABLE IF EXISTS `Insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Insurance` (
  `insurance_id` int NOT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `plan_type` varchar(255) DEFAULT NULL,
  `coverage` decimal(10,2) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `patient_id` int NOT NULL,
  PRIMARY KEY (`insurance_id`,`patient_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `insurance_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `Patient` (`patient_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Insurance`
--

LOCK TABLES `Insurance` WRITE;
/*!40000 ALTER TABLE `Insurance` DISABLE KEYS */;
INSERT INTO `Insurance` VALUES (60001,'Health Plus','Silver',5000.00,'2024-12-31',2001),(60002,'MediCare','Gold',7500.00,'2024-12-31',2005),(60003,'Wellness','Platinum',10000.00,'2024-12-31',2002),(60004,'HealFast','Silver',5000.00,'2024-12-31',2001),(60005,'SecureHealth','Gold',7500.00,'2024-12-31',2009);
/*!40000 ALTER TABLE `Insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inventory`
--

DROP TABLE IF EXISTS `Inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inventory` (
  `medicine_name` varchar(225) NOT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`medicine_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inventory`
--

LOCK TABLES `Inventory` WRITE;
/*!40000 ALTER TABLE `Inventory` DISABLE KEYS */;
INSERT INTO `Inventory` VALUES ('Acetaminophen',23.14),('Advil',19.99),('Albuterol',54.06),('Amlodipine',8.67),('Atorvastatin',15.67),('Avil',14.99),('Azithromycin',10.99),('Bupropion',447.01),('Dextroamphetamine',90.03),('Escitalopram',18.73),('Furosemide',7.34),('Gabapentin',50.89),('Hydrochlorothiazide',7.76),('Levothyroxine',25.95),('Lisinopril',8.44),('Losartan',14.38),('Metformin',11.07),('Metoprolol',18.87),('Montelukast',26.19),('Omeprazole',16.18),('Pantoprazole',37.11),('Rosuvastatin',60.30),('Sertraline',13.68),('Simvastatin',11.91),('Trazodone',12.57);
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medication`
--

DROP TABLE IF EXISTS `Medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Medication` (
  `prescription_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `patient_id` int DEFAULT NULL,
  `medicine_1` varchar(100) DEFAULT NULL,
  `medicine_2` varchar(100) DEFAULT NULL,
  `medicine_3` varchar(100) DEFAULT NULL,
  `dosage1` varchar(50) DEFAULT NULL,
  `dosage2` varchar(50) DEFAULT NULL,
  `dosage3` varchar(50) DEFAULT NULL,
  `time_to_take_1` varchar(50) DEFAULT NULL,
  `time_to_take_2` varchar(50) DEFAULT NULL,
  `time_to_take_3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`prescription_id`),
  KEY `employee_id` (`employee_id`),
  KEY `patient_id` (`patient_id`),
  KEY `medicine_1` (`medicine_1`),
  KEY `medicine_2` (`medicine_2`),
  KEY `medicine_3` (`medicine_3`),
  CONSTRAINT `medication_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Staff` (`employee_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `medication_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `Patient` (`patient_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `medication_ibfk_3` FOREIGN KEY (`medicine_1`) REFERENCES `Inventory` (`medicine_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `medication_ibfk_4` FOREIGN KEY (`medicine_2`) REFERENCES `Inventory` (`medicine_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `medication_ibfk_5` FOREIGN KEY (`medicine_3`) REFERENCES `Inventory` (`medicine_name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medication`
--

LOCK TABLES `Medication` WRITE;
/*!40000 ALTER TABLE `Medication` DISABLE KEYS */;
INSERT INTO `Medication` VALUES (1,17001,2000,'Atorvastatin','Avil','Trazodone','20 mg','5 mg','10 mg','once daily','once daily','once daily'),(2,17002,2001,'Levothyroxine','Furosemide','Bupropion','20 mg','30 mg','100 mcg','once daily','once daily','once daily'),(3,17003,2002,'Metformin','Avil','Azithromycin','40 mg','5 mg','500 mg','twice daily','once daily','twice daily'),(4,17004,2003,'Lisinopril','Metformin','Sertraline','10 mg','20 mg','5 mg','once daily','twice daily','twice daily'),(5,17011,2004,'Amlodipine','Gabapentin','Albuterol','30 mg','10 mg','5 mg','once daily','thrice daily','thrice daily'),(6,17012,2005,'Metoprolol','Escitalopram','Rosuvastatin','25 mg','50 mcg','100 mg','twice daily','twice daily','twice daily'),(7,17014,2006,'Acetaminophen','Amlodipine','Dextroamphetamine','500 mg','5 mg','10 mg','as needed','once daily','twice daily'),(8,17021,2007,'Advil','Atorvastatin','Escitalopram','200 mg','10 mg','10 mg','as needed','once daily','once daily'),(9,17022,2008,'Hydrochlorothiazide','Losartan','Pantoprazole','25 mg','50 mg','40 mg','once daily','once daily','once daily'),(10,17023,2009,'Simvastatin','Omeprazole','Gabapentin','20 mg','20 mg','300 mg','once daily','once daily','thrice daily'),(11,17024,2010,'Montelukast','Furosemide','Bupropion','10 mg','20 mg','150 mg','once daily','once daily','twice daily'),(12,17031,2011,'Metformin','Avil','Azithromycin','40 mg','5 mg','500 mg','twice daily','once daily','twice daily'),(13,17032,2012,'Lisinopril','Metformin','Sertraline','10 mg','20 mg','5 mg','once daily','twice daily','twice daily'),(14,17033,2013,'Amlodipine','Gabapentin','Albuterol','30 mg','10 mg','5 mg','once daily','thrice daily','thrice daily'),(15,17034,2014,'Metoprolol','Escitalopram','Rosuvastatin','25 mg','50 mcg','100 mg','twice daily','twice daily','twice daily'),(16,17041,2015,'Levothyroxine','Furosemide','Bupropion','20 mg','30 mg','100 mcg','once daily','once daily','once daily'),(17,17042,2016,'Atorvastatin','Avil','Trazodone','20 mg','5 mg','10 mg','once daily','once daily','once daily'),(18,17043,2017,'Lisinopril','Metoprolol','Trazodone','10 mg','50 mg','50 mg','once daily','twice daily','as needed'),(19,17001,2018,'Lisinopril','Avil','Trazodone','10 mg','50 mg','50 mg','once daily','twice daily','as needed'),(20,17002,2019,'Metformin','Losartan','Omeprazole','500 mg','25 mg','20 mg','twice daily','once daily','once daily'),(21,17003,2020,'Amlodipine','Gabapentin','Montelukast','5 mg','100 mg','10 mg','once daily','twice daily','once daily'),(22,17054,2021,'Hydrochlorothiazide','Sertraline','Dextroamphetamine','25 mg','50 mg','15 mg','once daily','once daily','twice daily'),(23,17002,2022,'Lisinopril','Metoprolol','Trazodone','10 mg','50 mg','50 mg','once daily','twice daily','as needed'),(24,17018,2023,'Levothyroxine','Rosuvastatin','Albuterol','100 mcg','10 mg','90 mcg','once daily','once daily','as needed');
/*!40000 ALTER TABLE `Medication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MedicationCashier`
--

DROP TABLE IF EXISTS `MedicationCashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MedicationCashier` (
  `prescription_id` int NOT NULL,
  `bill_id` int NOT NULL,
  PRIMARY KEY (`prescription_id`,`bill_id`),
  KEY `bill_id` (`bill_id`),
  CONSTRAINT `medicationcashier_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `Medication` (`prescription_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `medicationcashier_ibfk_2` FOREIGN KEY (`bill_id`) REFERENCES `Cashier` (`bill_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MedicationCashier`
--

LOCK TABLES `MedicationCashier` WRITE;
/*!40000 ALTER TABLE `MedicationCashier` DISABLE KEYS */;
/*!40000 ALTER TABLE `MedicationCashier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `age` int DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `address` varchar(300) DEFAULT NULL,
  `surgery_done` enum('Yes','No') DEFAULT NULL,
  `assigned_room` varchar(64) NOT NULL,
  `no_of_nights` int DEFAULT NULL,
  `is_discharged` enum('Yes','No') DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `check_in_time` datetime DEFAULT NULL,
  `appointment_end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `assigned_room` (`assigned_room`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`assigned_room`) REFERENCES `Room` (`room_type`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `Staff` (`employee_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2024 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
INSERT INTO `Patient` VALUES (2000,'Johnny','Ling',25,'johnnylang@gmail.com','(234)347-8970','123 Main St Boston MA','Yes','General ward',3,'Yes',17001,'2023-01-20 10:26:12','2023-01-20 11:26:12'),(2001,'Simphon','Everest',64,'simphon78@gmail.com','(617)346-9349','456 Oak St Virginia','No','Private ward',7,'No',17002,'2023-01-21 13:59:53','2023-01-21 14:29:53'),(2002,'Erik','Douglas',45,'erik33@gmai.com','(857)546-4568','789 Park Ave Boston MA','Yes','Premium Deluxe',5,'Yes',17003,'2023-01-20 03:05:49','2023-01-20 03:35:49'),(2003,'Charles','Simon',34,'simonc@yahoo.com','(857)469-0980','333 Pine St Boston MA','Yes','Private ward',9,'Yes',17004,'2023-01-20 08:46:08','2023-01-20 09:16:08'),(2004,'James','Mitchel',22,'jamesmitchell@gmail.com','(857)846-0987','812 Willow St Virginia','No','Premium Deluxe',2,'No',17011,'2023-01-21 04:15:39','2023-01-21 04:45:39'),(2005,'Ye','Lee',32,'yelee@yahoo.com','(617)235-6748','1234 Birch S Boston MA','Yes','General ward',10,'Yes',17012,'2023-01-20 10:14:53','2023-01-20 10:44:53'),(2006,'Ji','Chang',25,'changji@gmail.com','(754)947-9370','1501 Maple St Virginia','No','Private ward',8,'No',17014,'2023-01-21 11:49:44','2023-01-21 12:19:44'),(2007,'Jace','Green',57,'greenjace@yahoo.com','(857)548-0490','1701 Cedar St Boston MA','Yes','Premium Deluxe',6,'Yes',17021,'2023-01-21 05:52:15','2023-01-21 06:22:15'),(2008,'Robert','Patricks',34,'robert34@gmail.com','(723)947-9947','1950 Oak St Virginia','No','General ward',1,'No',17022,'2023-01-20 09:17:11','2023-01-20 09:47:11'),(2009,'Alice','Johnson',42,'alice.johnson@gmail.com','(617)123-4567','1001 Apple St Boston MA','Yes','Private ward',2,'Yes',17023,'2023-01-21 11:21:22','2023-01-21 11:51:22'),(2010,'Michael','Smith',30,'michael.smith@gmail.com','(617)234-5678','1002 Banana St Virginia','No','General ward',3,'No',17024,'2023-01-21 07:54:39','2023-01-21 08:24:39'),(2011,'Olivia','Williams',29,'olivia.williams@gmail.com','(617)345-6789','1003 Cherry St Boston MA','Yes','Premium Deluxe',4,'Yes',17031,'2023-01-20 02:06:48','2023-01-20 02:56:48'),(2012,'Daniel','Brown',65,'daniel.brown@gmail.com','(617)456-7890','1004 Date St Virginia','No','Private ward',5,'No',17032,'2023-01-20 01:23:13','2023-01-20 02:13:13'),(2013,'Sophia','Jones',40,'sophia.jones@gmail.com','(617)567-8901','1005 Elderberry St Boston MA','Yes','General ward',6,'Yes',17033,'2023-01-21 09:22:03','2023-01-21 09:52:03'),(2014,'David','Garcia',36,'david.garcia@gmail.com','(617)678-9012','1006 Fig St Virginia','No','Premium Deluxe',7,'No',17034,'2023-01-21 01:32:08','2023-01-21 02:02:08'),(2015,'Emily','Rodriguez',50,'emily.rodriguez@gmail.com','(617)789-0123','1007 Grape St Boston MA','Yes','Private ward',8,'Yes',17041,'2023-01-20 04:33:17','2023-01-20 05:03:17'),(2016,'Joseph','Martinez',58,'joseph.martinez@gmail.com','(617)890-1234','1008 Hazelnut St Virginia','No','General ward',9,'No',17042,'2023-01-20 06:41:05','2023-01-20 07:11:05'),(2017,'Ella','Hernandez',27,'ella.hernandez@gmail.com','(617)901-2345','1009 Ivy St Boston MA','Yes','Premium Deluxe',10,'Yes',17043,'2023-01-21 02:58:12','2023-01-21 03:28:12'),(2018,'Anthony','Moore',33,'anthony.moore@gmail.com','(617)012-3456','1010 Jasmine St Virginia','No','Private ward',1,'No',17001,'2023-01-21 10:42:20','2023-01-21 11:12:20'),(2019,'Victoria','Jackson',47,'victoria.jackson@gmail.com','(617)098-7654','1011 Kiwi St Boston MA','Yes','General ward',2,'Yes',17002,'2023-01-20 05:47:29','2023-01-20 06:17:29'),(2020,'Andrew','Taylor',63,'andrew.taylor@gmail.com','(617)987-6543','1012 Lemon St Virginia','No','Premium Deluxe',3,'No',17003,'2023-01-20 05:47:29','2023-01-20 06:17:29'),(2021,'Mia','Lee',38,'mia.lee@gmail.com','(617)876-5432','1013 Mango St Boston MA','Yes','Private ward',4,'Yes',17054,'2023-01-20 05:47:29','2023-01-21 06:17:29'),(2022,'William','Baker',52,'william.baker@gmail.com','(617)765-4321','1014 Nectarine St Virginia','No','General ward',5,'No',17002,'2023-01-21 03:12:18','2023-01-21 03:42:18'),(2023,'Samantha','Garcia',23,'samantha.garcia@gmail.com','(617)654-3210','1015 Orange St Boston MA','Yes','Premium Deluxe',6,'Yes',17018,'2023-01-20 12:47:11','2023-01-20 13:17:11');
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room`
--

DROP TABLE IF EXISTS `Room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Room` (
  `room_type` varchar(64) NOT NULL,
  `cost_per_night` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`room_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room`
--

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
INSERT INTO `Room` VALUES ('General ward',150.00),('Premium Deluxe',900.00),('Private ward',400.00);
/*!40000 ALTER TABLE `Room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Staff` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `employee_first_name` varchar(255) NOT NULL,
  `employee_last_name` varchar(255) NOT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `branch_id` (`branch_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `Hospital` (`branch_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `Department` (`department_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=17062 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (17001,16001,'Markus','Brown','Doctor','markus.br@srk.org','(857)324-6758',101),(17002,16001,'Ella','Grey','Doctor','ella.gr@srk.org','(857)234-3554',102),(17003,16001,'Kalyan','Chakri','Doctor','kalyan.ch@srk.org','(617)342-2342',103),(17004,16001,'James','Smith','Doctor','james.sm@srk.org','(857)212-1233',104),(17005,16001,'Kathy','Brook','Doctor','kathy.br.@srk.org','(617)231-2340',105),(17006,16001,'Nick','Hamilton','Nurse','nick.ha@srk.org','(617)678-9067',106),(17007,16001,'Emma','Laurens','Nurse','emma.la@srk.org','(617)905-9009',106),(17008,16002,'Marie','Jen','Doctor','marie.je@srk.org','(857)689-6009',101),(17009,16002,'Anthony','Williams','Doctor','anthony.wi@srk.org','(617)234-3432',102),(17010,16002,'Annie','Jones','Doctor','annie.jo@srk.org','(617)546-8880',103),(17011,16002,'Parth','Setty','Doctor','parth.se@srk.org','(857)345-4565',104),(17012,16002,'Bai','Chang','Doctor','bai.ch@srk.org','(857)003-2003',105),(17013,16002,'Benjamin','Miller','Nurse','benjamin.mi@srk.org','(857)345-6738',106),(17014,16002,'Andrew','Wong','Doctor','andrew.wo@srk.org','(617)809-9001',107),(17015,16001,'Tom','Harris','Doctor','tom.ha@srk.org','(617)386-5637',107),(17016,16001,'Jim','Brake','Doctor','jim.br@srk.org','(857)560-5600',107),(17017,16002,'Elis','Watt','Doctor','elis.wa@srk.org','(617)745-6786',107),(17018,16001,'Tommy','Callous','Doctor','tommy.ca@srk.org','(857)567-3453',101),(17019,16002,'Amy','White','Doctor','amy.wh@srk.org','(617)984-9450',101),(17020,16001,'David','Scott','Doctor','david.sc@srk.org','(857)345-5676',102),(17021,16002,'Adam','Wright','Doctor','adam.wr@srk.org','(617)376-5644',102),(17022,16001,'Angela','Carter','Doctor','angela.ca@srk.org','(345)234-2341',103),(17023,16002,'Peter','Hall','Doctor','peter.ha@srk.org','(458)764-9475',103),(17024,16001,'Sammy','Yang','Doctor','sammy.ya@srk.org','(657)456-6867',104),(17025,16002,'Grace','Hill','Doctor','grace.hi@srk.org','(345)986-8754',104),(17026,16001,'Jill','Rivera','Doctor','jill.ri@srk.org','(345)546-5465',105),(17027,16002,'Abraham','Sunny','Doctor','abraham.su@srk.org','(678)234-3456',105),(17028,16001,'Ram','Tagore','Doctor','ram.ta@srk.org','(857)546-9379',106),(17029,16002,'Sunil','Chaitya','Doctor','sunil.ch@srk.org','(617)368-3947',106),(17030,16001,'Hae','Soo','Doctor','hae.so@srk.org','(857)239-9083',107),(17031,16002,'Li','Chang','Doctor','li.ch@srk.org','(617)247-0909',107),(17032,16001,'Lucas','Wells','Doctor','lucas.we@srk.org','(857)123-9876',101),(17033,16002,'Hannah','Baker','Doctor','hannah.ba@srk.org','(617)234-8798',102),(17034,16001,'Sophia','Cole','Doctor','sophia.co@srk.org','(857)876-5642',103),(17035,16002,'Oliver','King','Doctor','oliver.ki@srk.org','(617)567-3456',104),(17036,16001,'Mason','Ward','Doctor','mason.wa@srk.org','(857)908-2364',105),(17037,16002,'Evelyn','Gomez','Nurse','evelyn.go@srk.org','(617)278-3956',106),(17038,16001,'Scarlett','Nixon','Nurse','scarlett.ni@srk.org','(857)472-1298',106),(17039,16002,'Ava','Griffin','Doctor','ava.gr@srk.org','(617)904-9823',101),(17040,16001,'Mia','Harvey','Doctor','mia.ha@srk.org','(857)375-4376',102),(17041,16002,'Liam','Butler','Doctor','liam.bu@srk.org','(617)628-9950',103),(17042,16001,'Noah','Holmes','Doctor','noah.ho@srk.org','(857)497-8732',104),(17043,16002,'Avery','Woods','Doctor','avery.wo@srk.org','(617)111-2223',105),(17044,16001,'Olivia','Bennett','Nurse','olivia.be@srk.org','(857)234-0987',106),(17045,16002,'Isabella','Knight','Doctor','isabella.kn@srk.org','(617)987-6543',107),(17046,16001,'Charlotte','Mills','Doctor','charlotte.mi@srk.org','(857)854-3214',107),(17047,16002,'Amelia','Simpson','Doctor','amelia.si@srk.org','(617)444-5555',107),(17048,16001,'Harper','Palmer','Doctor','harper.pa@srk.org','(857)666-7777',101),(17049,16002,'Luna','Hayes','Doctor','luna.ha@srk.org','(617)888-9999',101),(17050,16001,'Ella','Ellis','Doctor','ella.el@srk.org','(857)123-4567',102),(17051,16002,'Emily','Wheeler','Doctor','emily.wh@srk.org','(617)234-5678',102),(17052,16001,'Zoe','Hart','Doctor','zoe.ha@srk.org','(857)345-6789',103),(17053,16002,'Nora','Dawson','Doctor','nora.da@srk.org','(617)456-7890',103),(17054,16001,'Leah','Fisher','Doctor','leah.fi@srk.org','(857)567-8901',104),(17055,16002,'Lily','Gardner','Doctor','lily.ga@srk.org','(617)678-9012',104),(17056,16001,'Stella','Booth','Doctor','stella.bo@srk.org','(857)789-0123',105),(17057,16002,'Hazel','Greene','Doctor','hazel.gr@srk.org','(617)890-1234',105),(17058,16001,'Violet','Harper','Doctor','violet.ha@srk.org','(857)901-2345',106),(17059,16002,'Aurora','Ingram','Doctor','aurora.in@srk.org','(617)012-3456',106),(17060,16001,'Sadie','Jacobs','Doctor','sadie.ja@srk.org','(857)321-6543',107),(17061,16002,'Penelope','Klein','Doctor','penelope.kl@srk.org','(617)987-6543',107);
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `increase_employee_count` AFTER INSERT ON `staff` FOR EACH ROW begin
	declare hospital_count int;
    select no_of_employees into hospital_count from Hospital
    where branch_id = new.branch_id for update;
    -- for update is used to lock the selected row until the end of the transaction
    
    if hospital_count is null then
		signal sqlstate '45000' set message_text = 'Branch id does nto exist';
	end if;
    
    update Hospital set no_of_employees = no_of_employees + 1 
    where branch_id = new.branch_id;
    
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `StaffWorkingHours`
--

DROP TABLE IF EXISTS `StaffWorkingHours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StaffWorkingHours` (
  `employee_id` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `staffworkinghours_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Staff` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StaffWorkingHours`
--

LOCK TABLES `StaffWorkingHours` WRITE;
/*!40000 ALTER TABLE `StaffWorkingHours` DISABLE KEYS */;
INSERT INTO `StaffWorkingHours` VALUES (17001,'08:00:00','16:00:00'),(17002,'09:00:00','17:00:00'),(17003,'10:00:00','18:00:00'),(17004,'11:00:00','23:59:00'),(17005,'12:00:00','20:00:00'),(17006,'13:00:00','21:00:00'),(17007,'14:00:00','22:00:00'),(17008,'15:00:00','23:00:00'),(17009,'16:00:00','00:00:00'),(17010,'17:00:00','01:00:00'),(17011,'08:00:00','16:00:00'),(17012,'09:00:00','17:00:00'),(17013,'10:00:00','18:00:00'),(17014,'11:00:00','19:00:00'),(17015,'12:00:00','20:00:00'),(17016,'13:00:00','21:00:00'),(17017,'14:00:00','22:00:00'),(17018,'15:00:00','23:00:00'),(17019,'16:00:00','00:00:00'),(17020,'17:00:00','01:00:00'),(17021,'08:00:00','16:00:00'),(17022,'09:00:00','17:00:00'),(17023,'10:00:00','18:00:00'),(17024,'11:00:00','19:00:00'),(17025,'12:00:00','20:00:00'),(17026,'13:00:00','21:00:00'),(17027,'14:00:00','22:00:00'),(17028,'15:00:00','23:00:00'),(17029,'16:00:00','00:00:00'),(17030,'17:00:00','01:00:00'),(17031,'08:00:00','16:00:00'),(17032,'09:00:00','17:00:00'),(17033,'10:00:00','18:00:00'),(17034,'11:00:00','19:00:00'),(17035,'12:00:00','20:00:00'),(17036,'13:00:00','21:00:00'),(17037,'14:00:00','22:00:00'),(17038,'15:00:00','23:00:00'),(17039,'16:00:00','00:00:00'),(17040,'17:00:00','01:00:00'),(17041,'08:00:00','16:00:00'),(17042,'09:00:00','17:00:00'),(17043,'10:00:00','18:00:00'),(17044,'11:00:00','19:00:00'),(17045,'12:00:00','20:00:00'),(17046,'13:00:00','21:00:00'),(17047,'14:00:00','22:00:00'),(17048,'15:00:00','23:00:00'),(17049,'16:00:00','00:00:00'),(17050,'17:00:00','01:00:00'),(17051,'08:00:00','16:00:00'),(17052,'09:00:00','17:00:00'),(17053,'10:00:00','18:00:00'),(17054,'11:00:00','19:00:00'),(17055,'12:00:00','20:00:00'),(17056,'13:00:00','21:00:00'),(17057,'14:00:00','22:00:00'),(17058,'15:00:00','23:00:00'),(17059,'16:00:00','00:00:00'),(17060,'17:00:00','01:00:00'),(17061,'17:00:00','01:00:00');
/*!40000 ALTER TABLE `StaffWorkingHours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hospital'
--

--
-- Dumping routines for database 'hospital'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddOrUpdateMedicineInInventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddOrUpdateMedicineInInventory`(
    IN p_medicine_name VARCHAR(255),
    IN p_cost DECIMAL(10, 2)
)
BEGIN
    DECLARE medicine_exists INT;

    -- Check if the medicine is already in the Inventory table
    SELECT COUNT(*) INTO medicine_exists
    FROM Inventory
    WHERE medicine_name = p_medicine_name;

    IF medicine_exists > 0 THEN
        -- Update existing record
        UPDATE Inventory
        SET cost = p_cost
        WHERE medicine_name = p_medicine_name;
    ELSE
        -- Insert new record
        INSERT INTO Inventory (medicine_name, cost)
        VALUES (p_medicine_name, p_cost);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admit_patient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admit_patient`(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_age INT,
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(20),
    IN p_address VARCHAR(255),
    IN p_surgery_done ENUM('Yes', 'No'),
    IN p_assigned_room VARCHAR(64),
    IN p_no_of_nights INT,
    IN p_is_discharged ENUM('Yes', 'No')
)
BEGIN
    DECLARE available_doctor_id INT;
    DECLARE appointment_end_time DATETIME;

    -- Find an available doctor within their working hours
    SELECT sw.employee_id, p.check_in_time + INTERVAL 30 MINUTE INTO available_doctor_id, appointment_end_time
    FROM StaffWorkingHours sw
    INNER JOIN Staff s ON sw.employee_id = s.employee_id
    LEFT JOIN Patient p ON sw.employee_id = p.employee_id AND NOW() BETWEEN p.check_in_time AND p.appointment_end_time
    WHERE
        s.designation = 'Doctor' AND
        NOW() BETWEEN sw.start_time AND sw.end_time AND
        p.patient_id IS NULL
    LIMIT 1;

    IF available_doctor_id IS NOT NULL THEN
        -- Insert the patient record and assign the available doctor
        INSERT INTO Patient (
            first_name,
            last_name,
            age,
            email,
            phone,
            address,
            surgery_done,
            assigned_room,
            no_of_nights,
            is_discharged,
            employee_id,
            check_in_time,
            appointment_end_time
        )
        VALUES (
            p_first_name,
            p_last_name,
            p_age,
            p_email,
            p_phone,
            p_address,
            p_surgery_done,
            p_assigned_room,
            p_no_of_nights,
            p_is_discharged,
            available_doctor_id,
            NOW(),
            NOW() + INTERVAL 30 MINUTE
        );
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No doctors are available at the moment. Please try again later.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_bill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_bill`(IN patient_id INT)
BEGIN
  DECLARE v_room_type VARCHAR(255);
  DECLARE v_total_room_cost DECIMAL(10, 2);
  DECLARE v_surgery_fee DECIMAL(10, 2);
  DECLARE v_medicine_costs DECIMAL(10, 2);
  DECLARE v_bill_amount DECIMAL(10, 2);
  DECLARE v_coverage DECIMAL(10, 2);
  DECLARE v_final_bill_after_insurance DECIMAL(10, 2);

  SELECT
    room_type,
    total_room_cost,
    surgery_fee,
    medicine_costs,
    bill_amount,
    coverage
  INTO
    v_room_type,
    v_total_room_cost,
    v_surgery_fee,
    v_medicine_costs,
    v_bill_amount,
    v_coverage
  FROM
    (
      WITH CostDetails AS (
        SELECT 
          Patient.patient_id,
          Room.room_type,
          Room.cost_per_night * no_of_nights AS total_room_cost,
          CASE
            WHEN Patient.surgery_done = 'Yes' THEN 1000
            ELSE 0
          END AS surgery_fee
        FROM 
          Patient
          INNER JOIN Room ON Patient.assigned_room = Room.room_type
        WHERE
          Patient.patient_id = patient_id
      ),


      MedicineCosts AS (
        SELECT
          Medication.patient_id,
          SUM(CASE WHEN Inventory.medicine_name = Medication.medicine_1 THEN Inventory.cost ELSE 0 END) 
          + SUM(CASE WHEN Inventory.medicine_name =Medication.medicine_2 THEN Inventory.cost ELSE 0 END)
          + SUM(CASE WHEN Inventory.medicine_name =Medication.medicine_3 THEN Inventory.cost ELSE 0 END) AS medicine_costs
        FROM
          Medication
          INNER JOIN Inventory ON Inventory.medicine_name IN (Medication.medicine_1, Medication.medicine_2,Medication.medicine_3)
        WHERE
          Medication.patient_id = patient_id
        GROUP BY
          Medication.patient_id
      )

      SELECT
        Patient.patient_id,
        room_type,
        total_room_cost,
        surgery_fee,
        medicine_costs,
        total_room_cost + surgery_fee + medicine_costs AS bill_amount,
        Insurance.coverage
      FROM
        CostDetails
        INNER JOIN MedicineCosts ON CostDetails.patient_id = MedicineCosts.patient_id
        INNER JOIN Patient ON CostDetails.patient_id = Patient.patient_id
        LEFT JOIN Insurance ON Patient.patient_id = Insurance.patient_id
      WHERE
        CostDetails.patient_id = patient_id
    ) AS Bill;
IF NOT EXISTS (
    SELECT *
    FROM Patient
    WHERE Patient.patient_id = patient_id
  ) THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Patient not found in Patient table';
  END IF;

  -- Check if the Medication query returned any rows
  IF NOT EXISTS (
    SELECT *
    FROM Medication
    WHERE Medication.patient_id = patient_id
  ) THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Patient not found in Medication table';
  END IF;
    
	 IF v_coverage IS NULL THEN
	  SET v_final_bill_after_insurance = v_bill_amount;
      SET v_coverage = 0;
      
	ELSE
	  SET v_final_bill_after_insurance = v_bill_amount - v_coverage;
      IF v_final_bill_after_insurance < 0 THEN
		SET  v_final_bill_after_insurance = 0;
	  END IF;
	END IF;
    
     -- Update the coverage in the Insurance table after deduction
  UPDATE Insurance
  SET coverage = coverage - v_bill_amount
  WHERE Insurance.patient_id = patient_id;


  INSERT INTO Cashier (patient_id, room_type, bill_amount, DateTime, surgery_fee, total_room_cost, medicine_costs, coverage, final_bill_after_insurance)
  VALUES (patient_id, v_room_type, v_bill_amount, NOW(), v_surgery_fee, v_total_room_cost, v_medicine_costs, v_coverage, v_final_bill_after_insurance);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_prescription` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_prescription`(
    IN p_patient_id INT,
    IN p_medicines TEXT,
    IN p_dosages TEXT,
    IN p_times_to_take TEXT
)
BEGIN
	DECLARE v_employee_id INT;
    DECLARE v_patient_id INT;
    DECLARE v_medicine_1 VARCHAR(255) DEFAULT NULL;
    DECLARE v_medicine_2 VARCHAR(255) DEFAULT NULL;
    DECLARE v_medicine_3 VARCHAR(255) DEFAULT NULL;
    DECLARE v_dosage1 VARCHAR(255) DEFAULT NULL;
    DECLARE v_dosage2 VARCHAR(255) DEFAULT NULL;
    DECLARE v_dosage3 VARCHAR(255) DEFAULT NULL;
    DECLARE v_time_to_take_1 VARCHAR(255) DEFAULT NULL;
    DECLARE v_time_to_take_2 VARCHAR(255) DEFAULT NULL;
    DECLARE v_time_to_take_3 VARCHAR(255) DEFAULT NULL;

    SET v_medicine_1 = SUBSTRING_INDEX(p_medicines, ',', 1);
    SET v_medicine_2 = NULL;
    SET v_medicine_3 = NULL;

    SET v_dosage1 = SUBSTRING_INDEX(p_dosages, ',', 1);
    SET v_dosage2 = NULL;
    SET v_dosage3 = NULL;

    SET v_time_to_take_1 = SUBSTRING_INDEX(p_times_to_take, ',', 1);
    SET v_time_to_take_2 = NULL;
    SET v_time_to_take_3 = NULL;
    
	# employee_id (doctor) that has been assigned to the cuurent medication holder
    SELECT employee_id INTO v_employee_id
    FROM Patient
    WHERE patient_id= p_patient_id;
    
    SELECT patient_id INTO v_patient_id
    FROM Patient
    WHERE patient_id = p_patient_id;
    
	IF v_patient_id IS NULL THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: Can''t generate prescription without patient admission.';
	END IF;

	IF LENGTH(p_medicines) > 0 THEN
		SET v_medicine_2 = SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT(p_medicines, ','), ',', 2), ',', -1);
		IF LENGTH(v_medicine_2) = 0 THEN
			SET v_medicine_2 = NULL;
		END IF;
		IF LENGTH(p_medicines) > LENGTH(CONCAT(v_medicine_1, ',', v_medicine_2)) THEN
			SET v_medicine_3 = SUBSTRING_INDEX(SUBSTRING_INDEX(p_medicines, ',', 3), ',', -1);
		END IF;
	END IF;

	IF LENGTH(p_dosages) > 0 THEN
		SET v_dosage2 = SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT(p_dosages, ','), ',', 2), ',', -1);
		IF LENGTH(v_dosage2) = 0 THEN
			SET v_dosage2 = NULL;
		END IF;
		IF LENGTH(p_dosages) > LENGTH(CONCAT(v_dosage1, ',', v_dosage2)) THEN
			SET v_dosage3 = SUBSTRING_INDEX(SUBSTRING_INDEX(p_dosages, ',', 3), ',', -1);
		END IF;
	END IF;

	IF LENGTH(p_times_to_take) > 0 THEN
		SET v_time_to_take_2 = SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT(p_times_to_take, ','), ',', 2), ',', -1);
		IF LENGTH(v_time_to_take_2) = 0 THEN
			SET v_time_to_take_2 = NULL;
		END IF;
		IF LENGTH(p_times_to_take) > LENGTH(CONCAT(v_time_to_take_1, ',', v_time_to_take_2)) THEN
			SET v_time_to_take_3 = SUBSTRING_INDEX(SUBSTRING_INDEX(p_times_to_take, ',', 3), ',', -1);
		END IF;
	END IF;



    INSERT INTO Medication (
        employee_id, patient_id, medicine_1, medicine_2, medicine_3,
        dosage1, dosage2, dosage3, time_to_take_1, time_to_take_2, time_to_take_3
    )
    VALUES (
        v_employee_id, p_patient_id,
        v_medicine_1,v_medicine_2, v_medicine_3,
        v_dosage1, v_dosage2, v_dosage3,
        v_time_to_take_1, v_time_to_take_2, v_time_to_take_3
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertHospitalData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertHospitalData`(
    IN p_name VARCHAR(255),
    IN p_no_of_employees INT,
    IN p_address VARCHAR(255),
    IN p_visiting_hours VARCHAR(255)
)
BEGIN
  INSERT INTO Hospital (name, no_of_employees, address, visiting_hours)
  VALUES
  (p_name, p_no_of_employees, p_address, p_visiting_hours);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertOrUpdateInsurance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertOrUpdateInsurance`(
    IN p_insurance_id INT,
    IN p_provider VARCHAR(255),
    IN p_plan_type VARCHAR(255),
    IN p_coverage DECIMAL(10, 2),
    IN p_expiry_date DATE,
    IN p_patient_id INT
)
BEGIN
    DECLARE v_existing_coverage DECIMAL(10, 2);
    DECLARE v_patient_exists INT;

    -- Check if the insurance_id and patient_id combination already exists in the Insurance table and get existing coverage
    SELECT coverage INTO v_existing_coverage
    FROM Insurance
    WHERE insurance_id = p_insurance_id AND patient_id = p_patient_id;

    IF v_existing_coverage IS NOT NULL THEN
        -- Update existing record
        UPDATE Insurance
        SET 
            provider = p_provider,
            plan_type = p_plan_type,
            coverage = GREATEST(v_existing_coverage, p_coverage),
            expiry_date = p_expiry_date
        WHERE insurance_id = p_insurance_id AND patient_id = p_patient_id;
    ELSE
        -- Check if the patient_id already exists with a different insurance_id
        SELECT COUNT(*) INTO v_patient_exists
        FROM Insurance
        WHERE patient_id = p_patient_id;

        IF v_patient_exists > 0 THEN
            -- Throw an error if the patient_id already exists with a different insurance_id
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'The patient_id already exists with a different insurance_id in the Insurance table';
        ELSE
            -- Insert new record
            INSERT INTO Insurance (insurance_id, provider, plan_type, coverage, expiry_date, patient_id)
            VALUES (p_insurance_id, p_provider, p_plan_type, p_coverage, p_expiry_date, p_patient_id);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertRoomData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertRoomData`(
    IN p_room_type VARCHAR(255),
    IN p_cost_per_night DECIMAL(10, 2)
)
BEGIN
  INSERT INTO Room (room_type, cost_per_night)
  VALUES
  (p_room_type, p_cost_per_night);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_employee`(
    in branch_id_p int, 
    in first_name_p varchar(50), 
    in last_name_p varchar(50), 
    in designation_p varchar(10), 
    in email_p varchar(100), 
    in phone_p varchar(15),
    in department_id_p int
)
begin
	insert into Staff(branch_id, employee_first_name, employee_last_name, designation, email, phone_no, department_id) 
    values(branch_id_p, first_name_p, last_name_p, designation_p, email_p, phone_p, department_id_p);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PayBill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PayBill`(IN p_patient_id INT)
BEGIN
  DECLARE v_final_bill_after_insurance DECIMAL(10, 2);

  SELECT final_bill_after_insurance
  INTO v_final_bill_after_insurance
  FROM Cashier
  WHERE patient_id = p_patient_id;

  IF v_final_bill_after_insurance > 0 THEN
    UPDATE Cashier
    SET final_bill_after_insurance = 0
    WHERE patient_id = p_patient_id;
  ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The bill is covered by the insurance coverage';
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-21 20:52:51
