# MySQL
import mysql.connector

config = {
    "user": "admin",
    "password": "password123",
    "host": "127.0.0.1",
    "database": "test",
    "raise_on_warnings": True,
}
cnx = None
try:
    cnx = mysql.connector.connect(**config)
    print("-----")
    print("## OPEN CONNECTION TO DB ##")
    print("-----")
    try:
        print("## CONNECTION TO DB ESTABLISHED ##")
        cursor = cnx.cursor()
        query = "SELECT int_id, str_name, int_age FROM tb_python"
        cursor.execute(query)
        print("## QUERY EXECUTED! ##")
        print("-----")
    except Exception as e:
        print("## SOMETHING WENT WRONG:", e)
    else:
        for int_id, str_name, int_age in cursor:
            print(int_id, str_name, int_age)
    finally:
        cnx.close()
        print("-----")
        print("## CLOSED CONNECTION TO DB ##")
        print("-----")
except Exception as e:
    print("## SOMETHING WENT WRONG:", e)
    print("-----")
