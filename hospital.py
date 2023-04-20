
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
#do you need port22? figure out.
with connection:

    with connection.cursor() as cursor:
    # Create a new record
        sql = "INSERT INTO `Inventory` (`medicine_name`, `cost`) VALUES (%s, %s)"
        cursor.execute(sql, ('AaTest', '100.00'))
    # connection is not autocommit by default. So you must commit to save your changes.
    connection.commit()

    with connection.cursor() as cursor:
        # Read a single record
        sql = "SELECT `medicine_name`, `cost` FROM `Inventory` WHERE `medicine_name`=%s"
        cursor.execute(sql, ('AaTest',))
    result = cursor.fetchone()
    connection.commit()
    print(result)

    with connection.cursor() as cursor:
        # Read a single record
        sql = "DELETE FROM `hospital`.`Inventory` WHERE `medicine_name` =%s"
        cursor.execute(sql, ('AaTest',))
    result = cursor.fetchone()
    connection.commit()
    print("deleted")


    print("welcome " + username + ", please enter a command")
    command = input("Please enter your cmd: ")

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
                # call new_department(109,'Pulmonology');
                # newdep = 'call new_department(%d,%s)' % ( int(depId),depName)
                # sql = "call new_department(%d,%s)"
                # sql = "call new_department(%d,'test')"
                # cursor.execute(sql, (int(depId)))

                #sql = "SELECT `department_id`, `name` FROM `Department` WHERE `department_id`=%d"
                #cursor.execute(sql, (110,))

                #result = cursor.fetchone()
                # connection.commit()
                #print(result)
                connection.commit()

                # cursor.callproc()
            # Print the result of the executed stored procedure

            except Exception as e:
                traceback.print_exc()
                print("Exeception occured:{}".format(e))

            finally:
                cursor.close()


