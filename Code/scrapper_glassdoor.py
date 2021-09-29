# -*- coding: utf-8 -*-
"""
Created on Mon Sep 20 12:45:04 2021

@author: Jay
"""

from selenium import webdriver
import time
import keyword_extraction_modules as ke
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from socket import gaierror
import smtplib

# ===============Connector Script ==============================================================
import mysql.connector
from mysql.connector import Error

try:
    connection = mysql.connector.connect(host='localhost',
                                          database='srijas',
                                          user='root',
                                          password='')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

except Error as e:
    print("Error while connecting to MySQL", e)
    

# ================= fetch total skills database ==========================================================

query = "select skill_id,skill_title from skill_master"

cursor.execute(query)
table = cursor.fetchall()
final_skills = {}
for row in table:
    final_skills[row[0]]=row[1]
    #print(row[2], end=" ")
    #print(row[3], end="\n")
print(final_skills)

#========================= fetch resume id and corresponding skills ==============================================

query1 = "select r.resume_id,r.skill_id from resume_skills r where is_active='1'"
cursor.execute(query1)
records = cursor.fetchall()
mapping_dict = {}
for row in records:
    if row[0] in mapping_dict:
        mapping_dict[row[0]].append(row[1])
    else:
        mapping_dict[row[0]] = [row[1]]
print(mapping_dict)    

#======================= fetch user email ids ==================================

query2 = "select r.resume_id,u.user_email from user_resume r join user_master u on r.user_id=u.user_id"
cursor.execute(query2)
details = cursor.fetchall()
email_dict = {}
for row in details:
    if row[0] in email_dict:
        email_dict[row[0]].append(row[1])
    else:
        email_dict[row[0]] = [row[1]]
print(email_dict)      

#============================================================================================




final_dict = {}
threshold = 1
def get_jobs(keyword,num_jobs,verbose):
     options = webdriver.ChromeOptions()
     options.add_argument('headless')
     driver  =  webdriver.Chrome ()
     url = "https://www.glassdoor.com/Job/jobs.htm?suggestCount=0&suggestChosen=false&clickSource=searchBtn&typedKeyword="+keyword+"&sc.keyword="+keyword+"&locT=&locId=&jobType="
     driver.get(url)
     #jobs = []
     job_urls = []
     c=0  
     job_buttons = driver.find_elements_by_xpath('.//a[@class = "jobLink job-search-key-1rd3saf eigr9kq1"]')  #jl for Job Listing. These are the buttons we're going to click.
     time.sleep(2)
     print(len(job_buttons))
     for text in job_buttons:
         if text.get_attribute('href'):                       ### get all the job postings URL's
            job_urls.append(text.get_attribute('href'))
            c=c+1
            if(c>=num_jobs):
               break;
               
 ### Iterate through each url and get the job description
     for i in job_urls: 
             time.sleep(5)
             #print(i)
             jobs = []
             driver.get(i)
             button = driver.find_element_by_xpath('//*[@id="JobDescriptionContainer"]/div[2]')
             button.click()
             job_description = driver.find_element_by_xpath('//*[@id="JobDescriptionContainer"]/div[1]').text
             print(job_description)
             jobs.append(job_description)
             #result = ''.join(job_description)
             #print(result)
             final_dict[i] = job_description
             #print(jobs)
     #print(final_dict)
     total = {}
     email_list=[]
     total = ke.get_user_id_to_list_of_job_ids(mapping_dict,final_dict,connection,final_skills,threshold)
     print(total)
     for key in total:
         index = key
         print(index)
         email_list.append(email_dict[index])
     print(email_list)



     return jobs


df = get_jobs("Software Engineer",2,False)

     
     