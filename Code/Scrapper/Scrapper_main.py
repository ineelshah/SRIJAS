import json
import mysql.connector
from mysql.connector import Error
import scrapper_glassdoor as sg
import scrapper_indeed as si
import scrapper_linkedIn as sl
import email_alert as ea

#######################################################DATABASE OPERATIONS########################################################################################


############################################creating connection for database#################################
def db_connect(properties):
    properties = open('parameters.json')
    data = json.load(properties)
    server_name = data['server_name']
    user_name = data['user_name']
    password = data['password']
    db_name = data['db_name']
    connection = mysql.connector.connect(host=server_name,
                                              database=db_name,
                                              user=user_name,
                                              password=password)
    return connection

def get_all_skills(connection):
    sql_select_Query = "select DISTINCT skill_id,skill_title from skill_master"
    cursor=connection.cursor()
    cursor.execute(sql_select_Query)
    records=cursor.fetchall()
    all_skills={}
    for row in records:
        all_skills[row[0]]=row[1]
    print("All skills",all_skills)
    return all_skills


def get_resume_skills(connection):
    sql_select_Query2="select  resume_id,skill_id from resume_skills where is_active=1"
    cursor=connection.cursor()
    cursor.execute(sql_select_Query2)
    records2=cursor.fetchall()
    resume_skills={}
    for row in records2:
        if(row[0]) in resume_skills:
            resume_skills[row[0]].append(row[1])
        else:
            resume_skills[row[0]]=[row[1]]
    return resume_skills
        

def get_emailing_list(connection):
    email_id_list={}
    sql_select_Query3="SELECT resume_id,user_email from user_master um join user_resume ur on um.user_id=ur.user_id"
    cursor=connection.cursor()
    cursor.execute(sql_select_Query3)
    records_email=cursor.fetchall()
    for row in records_email:
        email_id_list[row[0]]=row[1]
    print("Resume id and email id",email_id_list)
    return email_id_list



if __name__ =='__main__':
    properties = open('parameters.json')
    data = json.load(properties)
    connection = db_connect(properties)
    all_skills = get_all_skills(connection)
    #print(all_skills)
    resume_skills = get_resume_skills(connection)
    #print(resume_skills)
    email_id_list = get_emailing_list(connection)
    # print(email_list)
    location = "california"
    role = "Software Engineer"
    no_of_jobs_to_retrieve = 5
    match_threshold = 1
    final_result_linkedIn = sl.get_job_description(connection,resume_skills,all_skills, match_threshold, role, location, no_of_jobs_to_retrieve, data)
    # final_result_glassdoor = sg.get_job_description(connection,resume_skills,all_skills, match_threshold, role, location, no_of_jobs_to_retrieve, data)
    # final_result_indeed = si.get_job_description(connection,resume_skills,all_skills, match_threshold, role, location, no_of_jobs_to_retrieve, data)
    
    # final_results = final_result_linkedIn + final_result_glassdoor + final_result_indeed
    ea.sendmail(final_result_linkedIn,email_id_list)


