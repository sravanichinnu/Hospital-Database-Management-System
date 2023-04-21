CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

CREATE TABLE Pharmacy (
    pharmacy_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    location VARCHAR(255)
    
);
alter table Pharmacy auto_increment = 10000;
CREATE TABLE Hospital (
    name VARCHAR(255) NOT NULL,
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    no_of_employees INT,
    address VARCHAR(255),
    visiting_hours VARCHAR(50) NOT NULL
);

alter table Hospital auto_increment = 16001;

create table Department (
    department_id int primary key auto_increment,
    name varchar(255) not null
);

CREATE TABLE Room (
	room_type VARCHAR(64) PRIMARY KEY,
    cost_per_night DECIMAL(10, 2)
);
CREATE TABLE Staff (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT NOT NULL,
    employee_first_name VARCHAR(255) NOT NULL,
    employee_last_name VARCHAR(255) NOT NULL,
    designation VARCHAR(255),
    email VARCHAR(255) NOT NULL,
    phone_no VARCHAR(20) NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES Hospital(branch_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	FOREIGN KEY (department_id) REFERENCES Department(department_id) ON UPDATE RESTRICT ON DELETE RESTRICT
);


alter table  Staff auto_increment = 17001;
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY ,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    address VARCHAR(255),
    surgery_done ENUM('Yes', 'No'),
    assigned_room VARCHAR(64) NOT NULL,
    no_of_nights INT,
    is_discharged ENUM('Yes', 'No'),
    employee_id INT,
    check_in_time DATETIME,
    appointment_end_time DATETIME,
    FOREIGN KEY (assigned_room) REFERENCES Room(room_type) ON UPDATE CASCADE ON DELETE RESTRICT,
    foreign key (employee_id) references Staff(employee_id) on update cascade on delete restrict
);

ALTER TABLE Patient AUTO_INCREMENT = 2000;




CREATE TABLE Insurance (
    insurance_id INT,
    provider VARCHAR(255),
    plan_type VARCHAR(255),
    coverage DECIMAL(10, 2),
    expiry_date DATE,
    patient_id INT,
    PRIMARY KEY(insurance_id, patient_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON UPDATE CASCADE ON DELETE RESTRICT
);



CREATE TABLE Inventory (
    medicine_name VARCHAR(225) PRIMARY KEY,
    cost DECIMAL(10, 2)
);
CREATE TABLE Medication (
    prescription_id INT PRIMARY KEY auto_increment,
    employee_id INT NOT NULL,
    patient_id INT,
    medicine_1 varchar(100),
    medicine_2 varchar(100),
    medicine_3 varchar(100),
    dosage1 VARCHAR(50),
    dosage2 varchar(50),
    dosage3 varchar(50),
    time_to_take_1 VARCHAR(50),
    time_to_take_2 VARCHAR(50),
    time_to_take_3 VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES Staff(employee_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Cashier (
    bill_id INT auto_increment,
    bill_amount DECIMAL(10, 2),
    patient_id INT,
    room_type VARCHAR(30) ,
    total_room_cost DECIMAL(10, 2),
    surgery_fee DECIMAL(10, 2),
    medicine_costs DECIMAL(10, 2),
    DateTime DATETIME,
    coverage DECIMAL(10, 2),
	final_bill_after_insurance DECIMAL(10, 2),
    PRIMARY KEY (bill_id,patient_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON UPDATE CASCADE ON DELETE CASCADE
   
);

CREATE TABLE MedicationCashier (
	prescription_id INT NOT NULL,
    bill_id INT NOT NULL,
    FOREIGN KEY (prescription_id) REFERENCES Medication(prescription_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (bill_id) REFERENCES Cashier(bill_id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (prescription_id,bill_id)
);

CREATE TABLE StaffWorkingHours (
    employee_id INT PRIMARY KEY NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    
    FOREIGN KEY (employee_id) REFERENCES Staff(employee_id) ON UPDATE CASCADE ON DELETE CASCADE
);

# insert statements 
INSERT INTO Pharmacy (pharmacy_id, branch_id, location) VALUES
(10001, 1, 'New York'),
(10002, 2, 'Los Angeles'),
(10003, 3, 'Chicago'),
(10004, 4, 'Houston'),
(10005, 5, 'Phoenix');

INSERT INTO Hospital (name, branch_id, no_of_employees, address, visiting_hours) VALUES
('SRK Hospitals', 16001, 15, 'Boston, MA', '11:00:00 - 18:00:00'),
('SRK Hospitals', 16002, 15, 'Virginia', '12:00:00 - 18:00:00');

insert into Department(department_id, name) values 
(101, 'Cardiology'),
(102, 'Gynecology'),
(103, 'Neurology'),
(104, 'Oncology'),
(105, 'Ophthamology'),
(106, 'Nursing'),
(107, 'Radiology'),
(108, 'Emergency');


INSERT INTO Room (room_type, cost_per_night)
VALUES ('General ward', 150.00),
       ('Private ward', 400.00),
       ('Premium Deluxe', 900.00);

INSERT INTO Inventory (medicine_name, cost)
VALUES
('Advil', 19.99),
('Avil', 14.99),
('Azithromycin',10.99),
('Atorvastatin', 15.67),
('Levothyroxine', 25.95),
('Metformin', 11.07),
('Lisinopril', 8.44),
('Amlodipine', 8.67),
('Metoprolol', 18.87),
('Albuterol', 54.06),
('Omeprazole', 16.18),
('Losartan', 14.38),
('Gabapentin', 50.89),
('Hydrochlorothiazide', 7.76),
('Sertraline', 13.68),
('Simvastatin', 11.91),
('Montelukast', 26.19),
('Escitalopram', 18.73),
('Acetaminophen', 23.14),
('Rosuvastatin', 60.3),
('Bupropion', 447.01),
('Furosemide', 7.34),
('Pantoprazole', 37.11),
('Trazodone', 12.57),
('Dextroamphetamine', 90.03);

INSERT INTO Insurance (insurance_id, provider, plan_type, coverage, expiry_date, patient_id) VALUES
(60001, 'Health Plus', 'Silver', 5000.00, '2024-12-31', 2007),
(60002, 'MediCare', 'Gold', 7500.00, '2024-12-31', 2005),
(60003, 'Wellness', 'Platinum', 10000.00, '2024-12-31', 2002),
(60004, 'HealFast', 'Silver', 5000.00, '2024-12-31', 2001),
(60005, 'SecureHealth', 'Gold', 7500.00, '2024-12-31', 2009),
(60006, 'SecureHealth', 'Gold', 7500.00, '2024-12-31', 2003),
(60007, 'SecureHealth', 'Gold', 7500.00, '2024-12-31', 2000);

INSERT INTO StaffWorkingHours (employee_id, start_time, end_time) VALUES
(17001, '08:00:00', '16:00:00'),
(17002, '09:00:00', '17:00:00'),
(17003, '10:00:00', '18:00:00'),
(17004, '11:00:00', '19:00:00'),
(17005, '12:00:00', '20:00:00'),
(17006, '13:00:00', '21:00:00'),
(17007, '14:00:00', '22:00:00'),
(17008, '15:00:00', '23:00:00'),
(17009, '16:00:00', '00:00:00'),
(17010, '17:00:00', '01:00:00'),
(17011, '08:00:00', '16:00:00'),
(17012, '09:00:00', '17:00:00'),
(17013, '10:00:00', '18:00:00'),
(17014, '11:00:00', '19:00:00'),
(17015, '12:00:00', '20:00:00'),
(17016, '13:00:00', '21:00:00'),
(17017, '14:00:00', '22:00:00'),
(17018, '15:00:00', '23:00:00'),
(17019, '16:00:00', '00:00:00'),
(17020, '17:00:00', '01:00:00'),
(17021, '08:00:00', '16:00:00'),
(17022, '09:00:00', '17:00:00'),
(17023, '10:00:00', '18:00:00'),
(17024, '11:00:00', '19:00:00'),
(17025, '12:00:00', '20:00:00'),
(17026, '13:00:00', '21:00:00'),
(17027, '14:00:00', '22:00:00'),
(17028, '15:00:00', '23:00:00'),
(17029, '16:00:00', '00:00:00'),
(17030, '17:00:00', '01:00:00'),
(17031, '08:00:00', '16:00:00');


