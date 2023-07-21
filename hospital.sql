CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;


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
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(300),
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
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (medicine_1) REFERENCES Inventory(medicine_name) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (medicine_2) REFERENCES Inventory(medicine_name) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (medicine_3) REFERENCES Inventory(medicine_name) ON UPDATE CASCADE ON DELETE RESTRICT
    
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




