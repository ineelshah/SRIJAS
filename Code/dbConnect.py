import pymysql

host = 'srijas.cgdwdytucgi0.us-east-1.rds.amazonaws.com'
user = 'root'
password = ''
database = 'srijas'

connection = pymysql.connect(host = host, user = user, password = password, database = database)
with connection:
    cur = connection.cursor()
    cur.execute("SELECT VERSION()")
    version = cur.fetchone()
    print("Database version: {} ".format(version[0]))