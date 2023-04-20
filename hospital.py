
import pymysql.cursors

# Connect to the database
connection = pymysql.connect(host='172.16.96.126',
                             user='admin1',
                             password='root',
                             database='hospital',
                             cursorclass=pymysql.cursors.DictCursor)

with connection:
    with connection.cursor() as cursor:
        # Create a new record
        sql = "INSERT INTO `Inventory` (`medicine_name`, `cost`) VALUES (%s, %s)"
        cursor.execute(sql, ('AaTest', '100.00'))

    # connection is not autocommit by default. So you must commit to save
    # your changes.
    connection.commit()

    with connection.cursor() as cursor:
        # Read a single record
        sql = "SELECT `medicine_name`, `cost` FROM `Inventory` WHERE `medicine_name`=%s"
        cursor.execute(sql, ('AaTest',))
    result = cursor.fetchone()
    print(result)