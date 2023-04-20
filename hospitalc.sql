CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

CREATE TABLE Hospital (
    name VARCHAR(255) NOT NULL,
    branch_id INT PRIMARY KEY,
    no_of_employees INT,
    address VARCHAR(255),
    visiting_hours VARCHAR(50) NOT NULL
);

drop table Department;
drop table Staff;
drop table Appointment;
drop table Medication;
drop table Cashier;
drop table MedicationCashier;

create table Department (
    department_id int primary key auto_increment,
    name varchar(255) not null
);

CREATE TABLE department_heads (
    department_id INT not null,
    branch_id INT NOT NULL,
    employee_id int not null,
    foreign key (department_id) references Department(department_id) on update cascade on delete cascade,
    foreign key (branch_id) references Hospital(branch_id) on update cascade on delete cascade
    -- foreign key (employee_id) references Staff(employee_id) on update cascade on delete cascade
);

CREATE TABLE Staff (
    employee_id INT PRIMARY KEY auto_increment,
    branch_id INT NOT NULL,
    employee_first_name VARCHAR(255) NOT NULL,
    employee_last_name VARCHAR(255) NOT NULL,
    designation VARCHAR(255),
    email VARCHAR(255) NOT NULL,
    phone_no VARCHAR(20) NOT NULL,
    department_id int NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES Hospital(branch_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id) ON UPDATE RESTRICT ON DELETE RESTRICT
);

Alter table Staff add start_hour time;
alter table Staff add end_hour time;
alter table Staff add available varchar(3) default 'Yes';
select * from Staff;
CREATE TABLE Room (
	room_type varchar(25) primary key,
    cost_per_night DECIMAL(10, 2)
);

drop table Appointment;
drop table Insurance;
drop table MedicationCashier;
drop table Medication;
drop table Cashier;
drop table Patient;
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    branch_id int not null,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    address VARCHAR(255),
    issue varchar(25) not null,
    surgery_done enum('Yes','No'),
    assigned_room varchar(25),
    no_of_nights INT,
    is_discharged ENUM('Yes', 'No') not null,
    FOREIGN KEY (assigned_room) REFERENCES Room(room_type) ON UPDATE CASCADE ON DELETE RESTRICT,
    foreign key (branch_id) references Hospital(branch_id) on update cascade on delete restrict
);
drop table Patient;
drop table Appointment;
drop table Insurance;
drop table Medication;
drop table Cashier;
drop table MedicationCashier;


select * from Patient;
CREATE TABLE Appointment (
  appointment_id INT PRIMARY KEY auto_increment,
  patient_id INT,
  branch_id INT,
  staff_id INT,
  appointment_date DATE,
  appointment_time TIME,
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (branch_id) REFERENCES Hospital(branch_id),
  FOREIGN KEY (staff_id) REFERENCES Staff(employee_id)
);

CREATE TABLE Pharmacy (
    pharmacy_id INT PRIMARY KEY,
    branch_id INT,
    location VARCHAR(255)
);

CREATE TABLE Insurance (
    insurance_id int PRIMARY KEY,
    patient_id INT,
    provider VARCHAR(255),
    plan_type VARCHAR(255),
    coverage DECIMAL(10, 2),
    expiry_date DATE,
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

drop table Medication;
drop table Cashier;
drop table MedicationCashier;
CREATE TABLE Cashier (
    bill_id INT PRIMARY KEY,
    bill_amount DECIMAL(10, 2),
    patient_id INT,
    prescription_id INT,
    medicine_name VARCHAR(255),
    DateTime DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (prescription_id) REFERENCES Medication(prescription_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (medicine_name) REFERENCES Inventory(medicine_name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MedicationCashier (
	prescription_id INT NOT NULL,
    bill_id INT NOT NULL,
    FOREIGN KEY (prescription_id) REFERENCES Medication(prescription_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (bill_id) REFERENCES Cashier(bill_id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (prescription_id,bill_id)
);

# insert statements 
INSERT INTO Pharmacy (pharmacy_id, branch_id, location) VALUES
(10001, 1, 'New York'),
(10002, 2, 'Los Angeles'),
(10003, 3, 'Chicago'),
(10004, 4, 'Houston'),
(10005, 5, 'Phoenix');

INSERT INTO Hospital (name, branch_id, no_of_employees, address, visiting_hours) VALUES
('SRK Hospitals', 16001, 15, 'Bennington Street, Boston, MA', '11:00:00 - 18:00:00'),
('SRK Hospitals', 16002, 15, 'Alverton St, Virginia', '12:00:00 - 18:00:00');

insert into Department(department_id, name) values 
(101, 'Cardiology'),
(102, 'Gynecology'),
(103, 'Neurology'),
(104, 'Oncology'),
(105, 'Ophthamology'),
(106, 'Nursing'),
(107, 'Radiology'),
(108, 'Emergency');

insert into department_heads(department_id, branch_id, employee_id) values
(101, 16001, 17001),
(102, 16001, 17002),
(103, 16001, 17003),
(104, 16001, 17004),
(105, 16001, 17005),
(106, 16001, 17007),
(107, 16001, 17014),
(108, 16001, 17032),
(101, 16002, 17008),
(102, 16002, 17009),
(103, 16002, 17010),
(104, 16002, 17011),
(105, 16002, 17012),
(106, 16002, 17013),
(107, 16002, 17015),
(108, 16002, 17033);

INSERT INTO Room (room_type, cost_per_night)
VALUES ('General ward', 150.00),
       ('Private ward', 400.00),
       ('Premium Deluxe', 900.00);
       
INSERT INTO Patient (patient_id, branch_id, first_name, last_name, age, email, phone, address, issue, surgery_done, assigned_room, no_of_nights, is_discharged) VALUES
(2000, 16001, 'Johnny', 'Ling', 25, 'johnnylang@gmail.com', '(234)347-8970', '123 Main St, Boston, MA', 'heart','yes', 'General ward', 3, 'Yes'),
(2001, 16001, 'Simphon', 'Everest', 64, 'simphon78@gmail.com', '(617)346-9349', '456 Oak St, Virginia', 'heart', 'No', 'Private ward', 7, 'No'),
(2002, 16002, 'Erik', 'Douglas', 45, 'erik33@gmai.com', '(857)546-4568', '789 Park Ave, Boston, MA','eyes', 'Yes', 'Premium Deluxe', 5, 'Yes'),
(2003, 16002, 'James', 'Thompson', 18, 'jamesthom@yahoo.com', '(647)648-0948', '1201 Elm St, Virginia','brain','No', 'General ward', 4, 'No'),
(2004, 16002, 'Charles', 'Simon', 34, 'simonc@yahoo.com', '(857)469-0980', '333 Pine St, Boston, MA','eyes', 'Yes', 'Private ward', 9, 'Yes'),
(2005, 16002, 'James', 'Mitchel', 22, 'jamesmitchell@gmail.com', '(857)846-0987', '812 Willow St, Virginia','eyes', 'No', 'Premium Deluxe', 2, 'No'),
(2006, 16002, 'Ye', 'Lee', 32, 'yelee@yahoo.com', '(617)235-6748', '1234 Birch St, Boston, MA', 'female','Yes', 'General ward', 10, 'Yes'),
(2007, 16001, 'Ji', 'Chang', 25, 'changji@gmail.com', '(754)947-9370', '1501 Maple St, Virginia','brain', 'No', 'Private ward', 8, 'No'),
(2008, 16001, 'Jace', 'Green', 57, 'greenjace@yahoo.com', '(857)548-0490', '1701 Cedar St, Boston, MA','heart', 'Yes', 'Premium Deluxe', 6, 'Yes'),
(2009, 16002, 'Robert', 'Patricks', 34, 'robert34@gmail.com', '(723)947-9947', '1950 Oak St, Virginia', 'bones','No', 'General ward', 1, 'No'),
(2010, 16002, 'Oliver', 'James', 23, 'oliver@gmail.com', '(857)455-3954', '2101 Elm St, Boston, MA', 'cancer', 'Yes', 'Private ward', 5, 'Yes');


INSERT INTO Staff (employee_id, branch_id, employee_first_name, employee_last_name, designation, email, phone_no, department_id)
VALUES (17001, 16001, 'Markus', 'Brown', 'Doctor', 'markus.br@srk.org', '(857)324-6758', 101),
       (17002, 16001, 'Ella', 'Grey', 'Doctor', 'ella.gr@srk.org', '(857)234-3554', 102),
       (17003, 16001, 'Kalyan', 'Chakri', 'Doctor', 'kalyan.ch@srk.org', '(617)342-2342', 103),
       (17004, 16001, 'James', 'Smith', 'Doctor', 'james.sm@srk.org', '(857)212-1233', 104),
       (17005, 16001, 'Kathy', 'Brook', 'Doctor', 'kathy.br.@srk.org', '(617)231-2340', 105),
       (17006, 16001, 'Nick', 'Hamilton', 'Nurse', 'nick.ha@srk.org', '(617)678-9067', 106),
       (17007, 16001, 'Emma', 'Laurens', 'Nurse', 'emma.la@srk.org', '(617)905-9009', 106),
       (17008, 16002, 'Marie', 'Jen', 'Doctor', 'marie.je@srk.org', '(857)689-6009', 101),
       (17009, 16002, 'Anthony', 'Williams', 'Doctor', 'anthony.wi@srk.org', '(617)234-3432', 102),
       (17010, 16002, 'Annie', 'Jones', 'Doctor', 'annie.jo@srk.org', '(617)546-8880', 103),
       (17011, 16002, 'Parth', 'Setty', 'Doctor', 'parth.se@srk.org', '(857)345-4565', 104),
       (17012, 16002, 'Bai', 'Chang', 'Doctor', 'bai.ch@srk.org', '(857)003-2003', 105),
       (17013, 16002, 'Benjamin', 'Miller', 'Nurse', 'benjamin.mi@srk.org', '(857)345-6738', 106),
       (17014, 16002, 'Andrew', 'Wong', 'Doctor', 'andrew.wo@srk.org', '(617)809-9001', 107),
       (17015, 16001, 'Tom', 'Harris', 'Doctor', 'tom.ha@srk.org', '(617)386-5637', 107),
       (17016, 16001, 'Jim', 'Brake', 'Doctor', 'jim.br@srk.org', '(857)560-5600', 107),
       (17017, 16002, 'Elis', 'Watt', 'Doctor', 'elis.wa@srk.org', '(617)745-6786', 107),
       (17018, 16001, 'Tommy', 'Callous', 'Doctor', 'tommy.ca@srk.org', '(857)567-3453', 101),
       (17019, 16002, 'Amy', 'White', 'Doctor', 'amy.wh@srk.org', '(617)984-9450', 101),
       (17020, 16001, 'David', 'Scott', 'Doctor', 'david.sc@srk.org', '(857)345-5676', 102),
       (17021, 16002, 'Adam', 'Wright', 'Doctor', 'adam.wr@srk.org', '(617)376-5644', 102),
       (17022, 16001, 'Angela', 'Carter', 'Doctor', 'angela.ca@srk.org', '(345)234-2341', 103),
       (17023, 16002, 'Peter', 'Hall', 'Doctor', 'peter.ha@srk.org', '(458)764-9475', 103),
       (17024, 16001, 'Sammy', 'Yang', 'Doctor', 'sammy.ya@srk.org', '(657)456-6867', 104),
       (17025, 16002, 'Grace', 'Hill', 'Doctor', 'grace.hi@srk.org', '(345)986-8754', 104),
       (17026, 16001, 'Jill', 'Rivera', 'Doctor', 'jill.ri@srk.org', '(345)546-5465', 105),
       (17027, 16002, 'Abraham', 'Sunny', 'Doctor', 'abraham.su@srk.org', '(678)234-3456', 105),
       (17028, 16001, 'Ram', 'Tagore', 'Doctor', 'ram.ta@srk.org', '(857)546-9379', 106),
       (17029, 16002, 'Sunil', 'Chaitya', 'Doctor', 'sunil.ch@srk.org', '(617)368-3947', 106),
       (17030, 16001, 'Hae', 'Soo', 'Doctor', 'hae.so@srk.org', '(857)239-9083', 107),
       (17031, 16002, 'Li', 'Chang', 'Doctor', 'li.ch@srk.org', '(617)247-0909', 107),
       (17032, 16001, 'Star', 'Angie', 'Doctor', 'star.an@srk.org','(734)479-9734',108),
       (17033, 16002, 'Vijay', 'Varma', 'Doctor','vijay.va@srk.org', '(873)863-9847', 108);
       
       
INSERT INTO Appointment (appointment_id, patient_id, branch_id, staff_id, appointment_date, appointment_time)
VALUES
  (1, 2000, 16001, 17001, '2023-04-02', '11:15:00'),
  (2, 2001, 16001, 17002, '2023-04-02', '12:00:00'),
  (3, 2002, 16001, 17003, '2023-04-03', '12:30:00'),
  (4, 2003, 16002, 17011, '2023-04-03', '13:00:00'),
  (5, 2004, 16001, 17004, '2023-04-04', '10:00:00'),
  (6, 2005, 16002, 17012, '2023-04-04', '10:30:00'),
  (7, 2006, 16002, 17013, '2023-04-04', '13:00:00'),
  (8, 2007, 16002, 17014, '2023-04-05', '11:30:00'),
  (9, 2008, 16002, 17027, '2023-04-10', '10:15:00'),
  (10, 2009, 16002, 17024, '2023-04-10', '10:45:00'),
  (11, 2010, 16002, 17028, '2023-04-10', '11:00:00');
  
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

INSERT INTO Medication (prescription_id, employee_id, patient_id, medicine_1, medicine_2, medicine_3, dosage1,
            dosage2, dosage3, time_to_take_1, time_to_take_2, time_to_take_3)
VALUES 
(1, 17001, 2000, 'Atorvastatin', 'Avil','Trazodone','20 mg','5 mg','10 mg','once daily', 'once daily', 'once daily'),
(2, 17002, 2001, 'Levothyroxine', 'Furosemide','Bupropion', '20 mg', '30 mg', '100 mcg', 'once daily', 'once daily', 'once daily'),
(3, 17003, 2002, 'Metformin', 'Avil', 'Azithromycin','40 mg', '5 mg','500 mg', 'twice daily', 'once daily','twice daily'),
(4, 17004, 2003, 'Lisinopril', 'Metformin', 'Sertraline', '10 mg', '20 mg','5 mg', 'once daily', 'twice daily', 'twice daily'),
(5, 17005, 2004, 'Amlodipine', 'Gabapentin', 'Albuterol', '30 mg', '10 mg', '5 mg', 'once daily',' thrice daily','thrice daily'),
(6, 17006, 2005, 'Metoprolol', 'Escitalopram','Rosuvastatin', '25 mg', '50 mcg', '100 mg', 'twice daily', 'twice daily', 'twice daily'),
(7, 17014, 2002, 'Montelukast','Pantoprazole','Omeprazole','15 mg', '20 mg', '10 mg', 'once daily', 'twice daily', 'thrice daily');

INSERT INTO Insurance (insurance_id, provider, plan_type, coverage, expiry_date, patient_id) VALUES
(60001, 'Health Plus', 'Silver', 5000.00, '2024-12-31', 2001),
(60002, 'MediCare', 'Gold', 7500.00, '2024-12-31', 2005),
(60003, 'Wellness', 'Platinum', 10000.00, '2024-12-31', 2002),
(60004, 'HealFast', 'Silver', 5000.00, '2024-12-31', 2001),
(60005, 'SecureHealth', 'Gold', 7500.00, '2024-12-31', 2009);


INSERT INTO Cashier (bill_id, patient_id, prescription_id, DateTime) VALUES
(80001, 2001, 1, '2023-04-15 10:30:00'),
(80002, 2002, 3, '2023-04-16 12:00:00'),
(80003, 2003, 2, '2023-04-17 15:30:00'),
(80004, 2004, 2, '2023-04-18 09:30:00'),
(80005, 2005, 4, '2023-04-19 14:30:00');

delimiter $$
create procedure generate_prescription(in patient_id_p int, in staff_id_p int, in medicine_name_p varchar(255), in dosage_p varchar(50), 
                 in time_to_take_p varchar(50))
begin
     insert into Medication(medicine_1, employee_id, patient_id, dosage1, time_to_take_1) 
     values(medicine_name_p, staff_id_p, patient_id_p, dosage_p, time_to_take_p);
end$$
delimiter ;

call generate_prescription(2010, 17004, 'Advil', '20 mg', 'once a day');
-- checked
select * from Medication;

-- to add any new department to the hospital
delimiter $$

create procedure new_department(in department_id_p int, department_name_p varchar(50))
begin
	insert into Department(department_id, name) values (department_id_p, department_name_p);
end$$
delimiter ;

call new_department(109, 'Pulmonology');

select * from Department;

