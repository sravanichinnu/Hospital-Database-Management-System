import pymysql.cursors

import traceback

# Connect to the database
username = input("Please enter your username: ")
password = input("Please enter your password: ")

try:
    connection = pymysql.connect(host='localhost',
                             user=username,
                             password=password,
                             database='hospital',
                             cursorclass=pymysql.cursors.DictCursor)
except:
    print("Error while connecting to MySQL")

with connection:

    print("welcome " + username + ", please enter a command")
    command = input("Please enter your cmd: ")

    while command != "quit":
        if command == "new_department":
            depId = input("Please enter the new department id number: ")
            depName = input("Please enter the new department name: ")

            with connection.cursor() as cursor:
                try:
                    args = (int(depId), depName, )
                    print(args)
                    # newdep = 'call new_department(%d,%s)' % ( int(depId),depName)
                    # print (newdep)
                    cursor.callproc('new_department', args)
                    connection.commit()
                    command = input("Please enter your cmd: ")

                # cursor.callproc()
                # Print the result of the executed stored procedure

                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))

                #finally:
                    #command = input("Please enter your cmd: ")
                    #break

        elif command == "new_employee":
            branch_id_int = input("Please enter the branch id ")
            first_name = input("Please enter the employee's first name ")
            last_name = input("Please enter the employee's last name ")
            designation = input("Please enter the job designation ")
            email = input("Please enter the employee's email ")
            phone = input("Please enter the employee's phone number ")
            department_id_int = input("Please enter the department id ")


            with connection.cursor() as cursor:
                try:
                    args = ( int(branch_id_int),first_name,last_name, designation, email, phone, int(department_id_int))
                    print(args)
                    cursor.callproc('new_employee', args)
                    connection.commit()
                    command = input("Please enter your cmd: ")


                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))

                #finally:
                    #command = input("Please enter your cmd: ")

        # checkout (three commands) insert_bill_into_cashier --> PayBill --> Discharge (Discharge is called from Paybill)
        elif command == "generate_bill":
            patient_id_int = input("Please enter the patient's id ")
            with connection.cursor() as cursor:
                try:
                    args = (int(patient_id_int), )
                    print(args)
                    cursor.callproc('generate_bill', args)
                    print("Bill is inserted")
                    #for debug, check if patient is discharged?
                    connection.commit()
                    command = input("Please enter your cmd: ")

                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))


        elif command == "pay_bill":
            patient_id_int = input("Please enter the patient's id ")
            with connection.cursor() as cursor:
                try:
                    args = (int(patient_id_int), )
                    print(args)
                    cursor.callproc('PayBill', args)
                    print("Bill is Paid")
                    connection.commit()
                    command = input("Please enter your cmd: ")

                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))

        elif command == "admit_patient":
            first_name = input("Please enter the patient's first name ")
            last_name = input("Please enter the patient's last name ")
            age_int = input("Please enter patient age: ")
            email = input("Please enter the patient's email ")
            phone = input("Please enter the patient's phone number ")
            address = input("Please enter the patient's address: ")
            surgeryDone_yn = input("If the patent needs surgery, please enter No. Otherwise, enter Yes: ")
            assigned_room = input("Please enter the patient's assigned room type: ")
            num_nights_int = input("Please enter the number of nights they will be staying: ")
            discharged_yn = "No"

            with connection.cursor() as cursor:
                try:
                    args = (first_name, last_name, int(age_int), email, phone, address, surgeryDone_yn, assigned_room, int(num_nights_int),discharged_yn)
                    print(args)
                    cursor.callproc('admit_patient', args)
                    connection.commit()
                    command = input("Please enter your cmd: ")


                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))

        elif command == "generate_prescription":
            print("reminder, split up the prescriptions with commas!")
            patient_id_int = input("Please enter the patient id: ")
            medicine_name= input("Please enter name of the medicine, with commas!: ")
            dosage = input("Please enter the proper dosage, with commas!: ")
            time_to_take = input("Please enter how the instructions on taking this medicine: ")

            with connection.cursor() as cursor:
                try:
                    args = (int(patient_id_int), medicine_name,dosage, time_to_take)
                    print(args)
                    cursor.callproc('generate_prescription', args)
                    connection.commit()
                    command = input("Please enter your cmd: ")

                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))


        elif command == "insert_update_medicine":
            #Make sure you change the name of this command to something less clunky

            medicine_name= input("Please enter name of the medicine: ")
            cost = input("Please enter the cost of the medicine: ")

            with connection.cursor() as cursor:
                try:
                    args = (medicine_name, float(cost))
                    print(args)
                    cursor.callproc('AddOrUpdateMedicineInInventory', args)
                    connection.commit()
                    command = input("Please enter your cmd: ")

                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))

        elif command == "insert_update_insurance":
            #Make sure you change the name of this command to something less clunky
            insurance_id_int = input("Please enter the insurance id: ")
            provider = input("Please enter the provider's name: ")
            plan_type = input("Please enter the patient's healthcare plan: ")
            coverage = input("Please enter the amount the health plan covers: ")
            expery_date = input("Please enter the expiration date in the format YYYY-MM-DD: ")
            patient_id_int = input("Please enter the patient id: ")

            with connection.cursor() as cursor:
                try:
                    args = (int(insurance_id_int), provider, plan_type, float(coverage), expery_date,int(patient_id_int) )
                    print(args)
                    cursor.callproc('InsertOrUpdateInsurance', args)
                    connection.commit()
                    command = input("Please enter your cmd: ")

                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))


        elif command == "insert_hospital_data":
            name = input("Please enter the Hospital's name: ")
            no_of_employees_int = input("Please enter the number of employees: ")
            address = input("Please enter the address of the hospital: ")
            visiting_hours = input("Please enter the visiting hours: ")

            with connection.cursor() as cursor:
                try:
                    args = (name, int(no_of_employees_int),address,visiting_hours )
                    print(args)
                    cursor.callproc('InsertHospitalData', args)
                    connection.commit()
                    command = input("Please enter your cmd: ")

                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))

        elif command == "insert_room_data":
            name = input("Please enter the room's type: ")
            cost_per_night = input("Please enter the price for each night: ")


            with connection.cursor() as cursor:
                try:
                    args = (name, float(no_of_employees_int) )
                    print(args)
                    cursor.callproc('InsertRoomData', args)
                    connection.commit()
                    command = input("Please enter your cmd: ")

                except Exception as e:
                    traceback.print_exc()
                    print("Exeception occured:{}".format(e))

        command = input("Something went wrong, please enter in your query again: ")


#make readme(python), document-, flowchart; meet at 4
