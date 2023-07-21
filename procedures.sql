USE hospital;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

select * from Staff;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE admit_patient(
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
//
DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# generate prescription
DELIMITER $$

CREATE PROCEDURE generate_prescription (
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
END $$

DELIMITER ;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE generate_bill(IN patient_id INT)
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
END //

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Add medicine and its cost to Inventory (stock)
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
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- insert hospital data

DELIMITER //
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
END //
DELIMITER ;



-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# insert Room

DELIMITER //
CREATE PROCEDURE InsertRoomData(
    IN p_room_type VARCHAR(255),
    IN p_cost_per_night DECIMAL(10, 2)
)
BEGIN
  INSERT INTO Room (room_type, cost_per_night)
  VALUES
  (p_room_type, p_cost_per_night);
END //
DELIMITER ;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# pay bill 

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
  ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The bill is covered by the insurance coverage';
  END IF;
END; //
DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- trigger to update the discharge status of the patient based on the amount of bill was paid
delimiter $$
create trigger update_discharge_status after update on Cashier
for each row
begin
	if new.final_bill_after_insurance = 0 then
		update Patient set is_discharged = 'yes' where patient_id = new.patient_id;
	end if;
end $$
delimiter ;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--







