import pymysql.cursors

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
#do you need port22? figure out.


#Menu function
def menu():
    while True:
        print("1. Create a new branch for the hospital")
        print("2. Create a new department")
        print("3. Add new employee record")
        print("4. Admit a new patient")
        print("5. Generate a new prescription")
        print("6. Calculate the bill for a patient")
        print("7. Add new pharmacy")
        print("8. Add new medicine to our stock of medicines")
        choice = input("Enter your desired choice: ")
        if choice == '1':
            hospital_name = input("Please enter the name of the hospital")
            n_employees = input("Enter the number of employees in hospital")
            address = input("Enter address of the hospital")
            visiting_hours = input("Enter visiting hours of the hospital")
            result = add_branch(hospital_name, n_employees, address, visiting_hours)
            print(result)
        elif choice == '2':
            department_name = input("Enter the department name")
            result = add_department(department_name)
            print(result)
        elif choice == '3':
            branch_id = input("Enter the hospital branch id into which employee is to be added")
            first_name = input("Enter the first name")
            last_name = input("Enter the last name")
            designation = input("Enter the designation")
            if designation == 'Nurse':
                department_id = 106
            else:
                department_id = input("Enter the department id")
            email = input("Enter the email address")
            phone = input("Enter the contact number")
            result = add_employee(branch_id, first_name, last_name, designation, email, phone, department_id)
        else:
            print("Nothing else")

def add_branch(hospital_name, n_employees, address, visiting_hours):
    cursor = connection.cursor()
    params = (hospital_name, n_employees, address, visiting_hours)
    cursor.callproc('InsertHospitalData', params)
    result = cursor.fetchone()[0]
    cursor.close()
    return result

def add_department(department_name):
    cursor = connection.cursor()
    params = (department_name)
    cursor.callproc('new_department', params)
    result = cursor.fetchone()[0]
    cursor.close()
    return result

def add_employee(branch_id, first_name, last_name, designation, email, phone, department_id):
    cursor = connection.cursor()
    params = (branch_id, first_name, last_name, designation, email, phone, department_id)
    cursor.callproc('new_employee', params)
    result = cursor.fetchone()[0]
    cursor.close()
    return result


menu()

