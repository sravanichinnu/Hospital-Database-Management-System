CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

CREATE TABLE Hospital (
    name VARCHAR(255) NOT NULL,
    branch_id INT PRIMARY KEY auto_increment,
    no_of_employees INT,
    address VARCHAR(255),
    visiting_hours VARCHAR(50) NOT NULL
);
alter table Hospital auto_increment = 16001;

create table Department (
    department_id int primary key auto_increment,
    name varchar(255) not null
);
alter table Department auto_increment = 101;

CREATE TABLE Staff (
    employee_id INT PRIMARY KEY auto_increment,
    branch_id INT NOT NULL,
    employee_first_name VARCHAR(255) NOT NULL,
    employee_last_name VARCHAR(255) NOT NULL,
    designation VARCHAR(255),
    email VARCHAR(255) NOT NULL,
    phone_no VARCHAR(20) NOT NULL,
    department_id int NOT NULL,
    is_head bit(1),
    FOREIGN KEY (branch_id) REFERENCES Hospital(branch_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id) ON UPDATE RESTRICT ON DELETE RESTRICT
);
alter table  Staff auto_increment = 17001;

create table StaffWorkingHours (
    employee_id int primary key not null,
    start_time time not null,
    end_time time not null,
    foreign key (employee_id) references Staff (employee_id) on update cascade on delete cascade
);

CREATE TABLE Room (
	room_type varchar(25) primary key,
    cost_per_night DECIMAL(10, 2)
);

CREATE TABLE Patient (
    patient_id INT PRIMARY KEY auto_increment,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    address VARCHAR(255),
    -- issue varchar(25) not null,
    surgery_done enum('Yes','No'),
    assigned_room varchar(25) not null,
    no_of_nights INT,
    is_discharged ENUM('Yes', 'No') not null,
    employee_id int,
    check_in_time DateTime,
    appointment_end_time datetime,
    FOREIGN KEY (assigned_room) REFERENCES Room(room_type) ON UPDATE CASCADE ON DELETE RESTRICT,
    foreign key (employee_id) references Staff(employee_id) on update cascade on delete restrict
);
alter table Patient auto_increment = 2000;

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
    pharmacy_id INT PRIMARY KEY auto_increment,
    branch_id INT,
    location_p VARCHAR(255)
);
alter table Pharmacy auto_increment = 10000;

CREATE TABLE Insurance (
    insurance_id int,
    provider VARCHAR(255),
    plan_type VARCHAR(255),
    coverage DECIMAL(10, 2),
    expiry_date DATE,
    patient_id int,
    primary key (insurance_id, patient_id),
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
    room_type varchar(30),
    total_room_cost decimal(10, 2),
    surgery_fee decimal(10, 2),
    medicine_costs decimal(10, 2),
    DateTime DATETIME,
    coverage decimal(10, 2),
    final_bill_after_insurance decimal(10, 2),
    primary key (bill_id, patient_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON UPDATE CASCADE ON DELETE cascade
);


CREATE TABLE MedicationCashier (
	prescription_id INT NOT NULL,
    bill_id INT NOT NULL,
    FOREIGN KEY (prescription_id) REFERENCES Medication(prescription_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (bill_id) REFERENCES Cashier(bill_id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (prescription_id,bill_id)
);

# insert statements 
INSERT INTO Pharmacy (pharmacy_id, branch_id, location_p) VALUES
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

INSERT INTO Room (room_type, cost_per_night)
VALUES ('General ward', 150.00),
       ('Private ward', 400.00),
       ('Premium Deluxe', 900.00);
       
INSERT INTO Patient (patient_id,first_name, last_name, age, email, phone, address, surgery_done, assigned_room, no_of_nights, is_discharged) VALUES
(2000, 'Johnny', 'Ling', 25, 'johnnylang@gmail.com', '(234)347-8970', '123 Main St, Boston, MA','yes', 'General ward', 3, 'Yes'),
(2001, 'Simphon', 'Everest', 64, 'simphon78@gmail.com', '(617)346-9349', '456 Oak St, Virginia','No', 'Private ward', 7, 'No'),
(2002, 'Erik', 'Douglas', 45, 'erik33@gmai.com', '(857)546-4568', '789 Park Ave, Boston, MA', 'Yes', 'Premium Deluxe', 5, 'Yes'),
(2003, 'James', 'Thompson', 18, 'jamesthom@yahoo.com', '(647)648-0948', '1201 Elm St, Virginia','No', 'General ward', 4, 'No'),
(2004, 'Charles', 'Simon', 34, 'simonc@yahoo.com', '(857)469-0980', '333 Pine St, Boston, MA', 'Yes', 'Private ward', 9, 'Yes'),
(2005, 'James', 'Mitchel', 22, 'jamesmitchell@gmail.com', '(857)846-0987', '812 Willow St, Virginia', 'No', 'Premium Deluxe', 2, 'No'),
(2006, 'Ye', 'Lee', 32, 'yelee@yahoo.com', '(617)235-6748', '1234 Birch St, Boston, MA', 'Yes', 'General ward', 10, 'Yes'),
(2007, 'Ji', 'Chang', 25, 'changji@gmail.com', '(754)947-9370', '1501 Maple St, Virginia', 'No', 'Private ward', 8, 'No'),
(2008, 'Jace', 'Green', 57, 'greenjace@yahoo.com', '(857)548-0490', '1701 Cedar St, Boston, MA', 'Yes', 'Premium Deluxe', 6, 'Yes'),
(2009, 'Robert', 'Patricks', 34, 'robert34@gmail.com', '(723)947-9947', '1950 Oak St, Virginia', 'No', 'General ward', 1, 'No'),
(2010, 'Oliver', 'James', 23, 'oliver@gmail.com', '(857)455-3954', '2101 Elm St, Boston, MA', 'Yes', 'Private ward', 5, 'Yes');


INSERT INTO Staff (employee_id, branch_id, employee_first_name, employee_last_name, designation, email, phone_no, department_id, is_head)
VALUES (17001, 16001, 'Markus', 'Brown', 'Doctor', 'markus.br@srk.org', '(857)324-6758', 101, 1),
       (17002, 16001, 'Ella', 'Grey', 'Doctor', 'ella.gr@srk.org', '(857)234-3554', 102,1),
       (17003, 16001, 'Kalyan', 'Chakri', 'Doctor', 'kalyan.ch@srk.org', '(617)342-2342', 103,1),
       (17004, 16001, 'James', 'Smith', 'Doctor', 'james.sm@srk.org', '(857)212-1233', 104,1),
       (17005, 16001, 'Kathy', 'Brook', 'Doctor', 'kathy.br.@srk.org', '(617)231-2340', 105,1),
       (17006, 16001, 'Nick', 'Hamilton', 'Nurse', 'nick.ha@srk.org', '(617)678-9067', 106, 0),
       (17007, 16001, 'Emma', 'Laurens', 'Nurse', 'emma.la@srk.org', '(617)905-9009', 106, 1),
       (17008, 16002, 'Marie', 'Jen', 'Doctor', 'marie.je@srk.org', '(857)689-6009', 101, 1),
       (17009, 16002, 'Anthony', 'Williams', 'Doctor', 'anthony.wi@srk.org', '(617)234-3432', 102,1),
       (17010, 16002, 'Annie', 'Jones', 'Doctor', 'annie.jo@srk.org', '(617)546-8880', 103, 1),
       (17011, 16002, 'Parth', 'Setty', 'Doctor', 'parth.se@srk.org', '(857)345-4565', 104, 1),
       (17012, 16002, 'Bai', 'Chang', 'Doctor', 'bai.ch@srk.org', '(857)003-2003', 105, 1),
       (17013, 16002, 'Benjamin', 'Miller', 'Nurse', 'benjamin.mi@srk.org', '(857)345-6738', 106, 1),
       (17014, 16002, 'Andrew', 'Wong', 'Doctor', 'andrew.wo@srk.org', '(617)809-9001', 107, 1),
       (17015, 16001, 'Tom', 'Harris', 'Doctor', 'tom.ha@srk.org', '(617)386-5637', 107, 1),
       (17016, 16001, 'Jim', 'Brake', 'Doctor', 'jim.br@srk.org', '(857)560-5600', 107,0),
       (17017, 16002, 'Elis', 'Watt', 'Doctor', 'elis.wa@srk.org', '(617)745-6786', 107,0),
       (17018, 16001, 'Tommy', 'Callous', 'Doctor', 'tommy.ca@srk.org', '(857)567-3453', 101,0),
       (17019, 16002, 'Amy', 'White', 'Doctor', 'amy.wh@srk.org', '(617)984-9450', 101,0),
       (17020, 16001, 'David', 'Scott', 'Doctor', 'david.sc@srk.org', '(857)345-5676', 102,0),
       (17021, 16002, 'Adam', 'Wright', 'Doctor', 'adam.wr@srk.org', '(617)376-5644', 102,0),
       (17022, 16001, 'Angela', 'Carter', 'Doctor', 'angela.ca@srk.org', '(345)234-2341', 103,0),
       (17023, 16002, 'Peter', 'Hall', 'Doctor', 'peter.ha@srk.org', '(458)764-9475', 103,0),
       (17024, 16001, 'Sammy', 'Yang', 'Doctor', 'sammy.ya@srk.org', '(657)456-6867', 104,0),
       (17025, 16002, 'Grace', 'Hill', 'Doctor', 'grace.hi@srk.org', '(345)986-8754', 104,0),
       (17026, 16001, 'Jill', 'Rivera', 'Doctor', 'jill.ri@srk.org', '(345)546-5465', 105,0),
       (17027, 16002, 'Abraham', 'Sunny', 'Doctor', 'abraham.su@srk.org', '(678)234-3456', 105,0),
       (17028, 16001, 'Ram', 'Tagore', 'Doctor', 'ram.ta@srk.org', '(857)546-9379', 106,0),
       (17029, 16002, 'Sunil', 'Chaitya', 'Doctor', 'sunil.ch@srk.org', '(617)368-3947', 106,0),
       (17030, 16001, 'Hae', 'Soo', 'Doctor', 'hae.so@srk.org', '(857)239-9083', 107,0),
       (17031, 16002, 'Li', 'Chang', 'Doctor', 'li.ch@srk.org', '(617)247-0909', 107,0),
       (17032, 16001, 'Star', 'Angie', 'Doctor', 'star.an@srk.org','(734)479-9734',108, 1),
       (17033, 16002, 'Vijay', 'Varma', 'Doctor','vijay.va@srk.org', '(873)863-9847', 108, 1);
       

INSERT INTO StaffWorkingHours (employee_id,start_time, end_time) VALUES
(17001,'08:00:00', '16:00:00'),
(17002,'09:00:00', '17:00:00'),
(17003,'10:00:00', '18:00:00'),
(17004,'11:00:00', '19:00:00'),
(17005,'12:00:00', '20:00:00'),
(17006,'13:00:00', '21:00:00'),
(17007,'14:00:00', '22:00:00'),
(17008,'15:00:00', '23:00:00'),
(17009,'16:00:00', '00:00:00'),
(17010,'17:00:00', '01:00:00');

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

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to admit a patient by updating the Appointment table
delimiter $$
CREATE PROCEDURE AdmitPatient(
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
END;
$$
DELIMITER ;

CALL AdmitPatient(
    'John',
    'Doe',
    35,
    'john.doe@example.com',
    '+1-555-123-4567',
    '123 Main St, Anytown, USA',
    'No',
    'General ward',
    3,
    'No'
);
CALL AdmitPatient(
    'Rex',
    'Carlos',
    65,
    'rex.carlos@yahoo.com',
    '+1-555-133-4567',
    '133 Main St, Anytown, USA',
    'No',
    'General ward',
    3,
    'No'
);
-- UPDATE StaffWorkingHours SET end_time = "17:00:00" WHERE employee_id = '17001';
SELECT * FROM Patient;

------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to calculate the bill
delimiter $$
CREATE PROCEDURE insert_bill_into_cashier(IN patient_id INT)
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
END $$

DELIMITER ;

call insert_bill_into_cashier(2001);
------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to add a new department to the hospital
delimiter $$

create procedure new_department(
    in department_name_p varchar(50)
)
begin
	insert into Department(name) values (department_name_p);
end$$
delimiter ;

call new_department(
    'Anesthesiology'
);

select * from Department;

------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to add new employee to the Staff table
delimiter $$
create procedure new_employee(
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
end$$
delimiter ;

call new_employee(
    16001, 
    'Robert', 
    'Pattinson', 
    'Nurse', 
    'robert.pa@srk.org', 
    '(342)435-0183', 
    106
);
select * from Staff;

------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to insert or update the insurance

DELIMITER $$
CREATE PROCEDURE `InsertOrUpdateInsurance` (
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
END $$

DELIMITER ;

CALL InsertOrUpdateInsurance(60007, 'Provider Name', 'Plan Type', 8000.00, '2024-04-18', 2000);

SELECT * FROM insurance;

------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to add medicine and its cost to Inventory table
DELIMITER $$

CREATE PROCEDURE `AddOrUpdateMedicineInInventory` (
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
END $$

DELIMITER ;

CALL AddOrUpdateMedicineInInventory('Advil', 20.99);
SELECT * FROM Inventory;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- procedure to generate prescription
DELIMITER $$

CREATE PROCEDURE InsertMedication (
    IN p_employee_id INT,
    IN p_patient_id INT,
    IN p_medicines TEXT,
    IN p_dosages TEXT,
    IN p_times_to_take TEXT
)
BEGIN
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
        p_employee_id, p_patient_id,
        v_medicine_1,v_medicine_2, v_medicine_3,
        v_dosage1, v_dosage2, v_dosage3,
        v_time_to_take_1, v_time_to_take_2, v_time_to_take_3
    );
END $$

DELIMITER ;
select * from Patient;
CALL InsertMedication(17001, 2018, 'Lisinopril,Furosemide,Metformin', '500 mg,25 mg,20 mg', 'once daily,twice daily,once daily');
-- delete from Medication where prescription_id = 7;
SELECT * FROM Medication;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- procedure to insert a new branch of the hosptial
DELIMITER $$
CREATE PROCEDURE InsertHospitalData(
    IN p_name VARCHAR(255),
    IN p_no_of_employees INT,
    IN p_address VARCHAR(255),
    IN p_visiting_hours VARCHAR(255)
)
BEGIN
  INSERT INTO Hospital (name, no_of_employees, address, visiting_hours)
  VALUES
  (p_name, p_no_of_employees, p_address, p_visiting_hours);
END $$
DELIMITER ;

-- CALL InsertHospitalData('SRK Hospitals', 16001, 15, 'Bennington Street, Boston, MA', '11:00:00 - 18:00:00');
-- CALL InsertHospitalData('SRK Hospitals', 16002, 15, 'Alverton St, Virginia', '12:00:00 - 18:00:00');
CALL InsertHospitalData('SRK Hospitals', 20, 'Valian St, Georgia', '10:00:00 - 18:00:00');
select * from Hospital;
------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to isnert new pharmacies
DELIMITER $$
CREATE PROCEDURE InsertPharmacyData(
    IN p_branch_id INT,
    IN p_location VARCHAR(255)
)
BEGIN
  INSERT INTO Pharmacy (branch_id, location_p)
  VALUES
  (p_branch_id, p_location);
END $$
DELIMITER ;
select * from Hospital;
-- CALL InsertPharmacyData(10001, 1, 'New York');
-- CALL InsertPharmacyData(10002, 2, 'Los Angeles');
-- CALL InsertPharmacyData(10003, 3, 'Chicago');
call InsertPharmacyData(16003, 'Virginia');
select * from Pharmacy;
------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to insert into the type of room
DELIMITER $$
CREATE PROCEDURE InsertRoomData(
    IN p_room_type VARCHAR(255),
    IN p_cost_per_night DECIMAL(10, 2)
)
BEGIN
  INSERT INTO Room (room_type, cost_per_night)
  VALUES
  (p_room_type, p_cost_per_night);
END $$
DELIMITER ;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- procedure to discharge the patient
DELIMITER $$
CREATE PROCEDURE DischargePatient(IN p_patient_id INT)
BEGIN
  DECLARE v_final_bill_after_insurance DECIMAL(10, 2);

  SELECT final_bill_after_insurance
  INTO v_final_bill_after_insurance
  FROM Cashier
  WHERE patient_id = p_patient_id;

  IF v_final_bill_after_insurance = 0 THEN
    UPDATE Patient
    SET is_discharged = 'Yes'
    WHERE patient_id = p_patient_id;
  ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The patient has not paid the bill yet.';
  END IF;
END; $$
DELIMITER ;

CALL DischargePatient(2018);
SELECT * from Patient;
SELECT * FROM Cashier;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- procedure to pay bill
DELIMITER //
CREATE PROCEDURE PayBill(IN p_patient_id INT)
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

    CALL DischargePatient(p_patient_id);
  ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The bill has already been paid.';
  END IF;
END; //
DELIMITER ;

CALL PayBill(2001);

------------------------------------------------------------------------------------------------------------------------------------------------------
-- trigger to increase the count for number of employees present in a hospital after a new employee is inserted 
delimiter $$
create trigger increase_employee_count after insert on Staff
for each row
begin
	declare hospital_count int;
    select no_of_employees into hospital_count from Hospital
    where branch_id = new.branch_id for update;
    -- for update is used to lock the selected row until the end of the transaction
    
    if hospital_count is null then
		signal sqlstate '45000' set message_text = 'Branch id does nto exist';
	end if;
    
    update Hospital set no_of_employees = no_of_employees + 1 
    where branch_id = new.branch_id;
    
end$$
delimiter ;
-- checking for the trigger, trying to insert an employee
call new_employee(17036, 16002, 'Thor', 'Williams', 'Doctor', 'thor.wi@srk.org', '(645)335-0483', 104);
select * from Staff;
select * from Hospital;



