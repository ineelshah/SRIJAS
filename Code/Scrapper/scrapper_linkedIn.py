from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import keyword_extraction_modules as ke
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import requests


# Form a function get_job_description fetching details of location, resume skills, match_threshold,Job roles

def get_job_description(connection,resume_skills,all_skills, match_threshold, role, location, no_of_jobs_to_retrieve, data):
    # role = role.replace(' ', '%20')
    #Form a dynamic URL to fetch the details using Beautiful soup for the given filters
    url = "https://www.linkedin.com/jobs/jobs-in-"+location+"?keywords="+role+"&f_JT=F%2CP&f_E=1%2C3&position=1&pageNum=0"
    
    # Add number of jobs to retrieve to limit
    limit = no_of_jobs_to_retrieve
    
    k1 = requests.get(url)
    # Run the beautiful soup 
    soup1 = BeautifulSoup(k1.content, 'html.parser')
    
    string1 = soup1.find_all("a",{"class":"base-card__full-link"})
    print(string1)
    description_dict = {}
    for i in range(len(string1)):
        if role.lower() in string1[i].get_text().lower() and limit>0:
            dictionary = {}
            #Get the data for job title and job link and store it in dictionary
            dictionary["Job Title"] = string1[i].get_text().replace('\n',' ').replace(' ','')
            #Replace the next line parameter with the blank space
            #Iterate the different job suggestions according to the given filters and fetch description for the jobs matching the search criteria of the user given.
            dictionary["Job Link"] = string1[i]['href']
            limit-=1
            k = requests.get(string1[i]['href']).text
            soup=BeautifulSoup(k,'html.parser')
            str2 = soup.findAll("div", {"class" : "show-more-less-html__markup show-more-less-html__markup--clamp-after-5"})

            str3 = str2[0].get_text()
   
            description_dict[dictionary["Job Link"]]=str3

    final_result=ke.get_user_id_to_list_of_job_ids(resume_skills,description_dict,connection,all_skills,match_threshold)

    return final_result
