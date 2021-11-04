import pymysql

#Connect to the database 'srijas'
host = 'srijas.cgdwdytucgi0.us-east-1.rds.amazonaws.com'
user = 'root'
password = ''
database = 'srijas'
#Run the connection command and execute the verion of the database
connection = pymysql.connect(host = host, user = user, password = password, database = database)
with connection:
    cur = connection.cursor()
    cur.execute("SELECT VERSION()")
    version = cur.fetchone()
    print("Database version: {} ".format(version[0]))
