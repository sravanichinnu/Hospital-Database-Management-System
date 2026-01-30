# Hospital-Database-Management-System
### INTRODUCTION:

In today’s world, hospitals generate a vast amount of data every day. Efficient management and organization of this data is crucial to the success of the hospital. In this project, we have developed a Hospital Database Management System using MySQL and Python to provide an easy-to-use and efficient solution for managing hospital data. We have implemented a command line interface that offers a menu-driven output, making it simpler for users to interact with the system. Our primary focus is on designing a system that is scalable and can be extended in the future to accommodate new features and functionality. The project follows an iterative development process, starting with requirements gathering, database design, implementation, and testing. This report provides a detailed description of the database’s architecture, the design choices made, and an evaluation of the system’s performance. The report also includes a user manual and instructions for installation of the required software.

### Hardware requirements:

· Intel Core i5 or higher or OS X 10.9 or higher · RAM: 4GB or higher · Storage: 100GB or higher

### Software requirements:

· Operating System: Windows 10 or Mac OS X or higher · Database Management System: MySQL 8.0 or other · Programming Language: Python 3.8 or higher · Python libraries: pymysql to connect with the database.

### Installation Instructions:

To install and set up the Hospital Database Management System, please follow these steps:

Download the software required from the official website.
Install MySQL 8.0 or higher on your computer.
Create a new database and import the database schema.
Install Python 3.8 or higher on your computer.
Install the required Python packages.
Run the application using the command “python hospital.py”.
Commands Available: The available commands once running the application are: · new_department · new_employee · generate_bill · pay_bill · admit_patient · generate_prescription · insert_update_medicine · insert_update_insurance · insert_hospital_data · insert_room_data · quit

### Database Schema: 
##### The Hospital Database Management System uses the following database schema: · Hospital table (name, branch_id, no_of_employees, address, visiting_hours)

· Department table (department_id, name)

· Staff table (employee_id, branch_id, employee_first_name, employee_last_name, designation, email, phone_no, department_id)

· StaffWorkingHours table (employee_id, start_time, end_time)

· Room (room_type, cost_per_night)

· Patient (patient_id, first_name, last_name, age, email, phone, address, surgery_done, assigned_room, no_of_nights, is_discharged, employee_id, check_in_time, appointment_end_time)

· Insurance (insurance_id, provider, plan_type, coverage, expiry_date, patient_id)

· Inventory (medicine_name, cost)

· Medication (prescription_id, employee_id, patient_id, medicin_1, medicine_2, medicine_3, dosage1, dosage2, dosage3, time_to_take_1, time_to_take_2, time_to_take_3)

· Cashier (bill_id, bill_amount, patient_id, room_type, total_room_cost, surgery_fee, medicine_costs, DateTime, coverage, final_bill_after_insurance)

· MedicationCashier (prescription_id, bill_id)
