from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import keyword_extraction_modules as ke
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from socket import gaierror
from webdriver_manager.chrome import ChromeDriverManager
import json
import urllib.parse
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import requests

def get_job_description(resume_skills,all_skills, match_threshold, role, location, no_of_jobs_to_retrieve, data):
    options = Options()
    options.add_argument("--window-size-1920,1200")
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    driver = webdriver.Chrome(options=options, executable_path=ChromeDriverManager().install())
    url = "https://www.indeed.com/jobs?"
    #-------------------Job perferences(input from user)-------------------------------------#
    data={}
    data["q"] = role
    data["l"] = location
    data["jt"]="parttime"
    data["explvl"]="senior_level"
    #------------------------------------------------------------------------------------------#
    url_parts = list(urllib.parse.urlparse(url))
    query = dict(urllib.parse.parse_qsl(url_parts[4]))
    query.update(data)
    url_parts[4] = urllib.parse.urlencode(query,quote_via=urllib.parse.quote_plus)
    url = urllib.parse.urlunparse(url_parts)
    driver.get(url)
    job_urls = []
    c = 0
    jobcards = driver.find_element_by_id('mosaic-provider-jobcards')
    jobs = jobcards.find_elements_by_xpath("./*") 
    print(len(jobs))
    for text in jobs:
        if text.get_attribute('href'):  ### get all the job postings URL'sz
            job_urls.append(text.get_attribute('href'))
            c = c + 1
            if (c >= no_of_jobs_to_retrieve):
                break
    final_dict = {}
    # ========== Iterate through each url and get the job description =================================
    job_role = []
    for i in job_urls:
        time.sleep(5)
        jobs = []
        driver.get(i)
        job_description = driver.find_element_by_xpath('//*[@id="jobDescriptionText"]').text
        jobs.append(job_description)
        final_dict[i] = job_description
        job_title=driver.find_element_by_xpath("//*[@id='viewJobSSRRoot']/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div[1]/h1").text
        #company_details=driver.find_element_by_xpath("//div[@class='css-16nw49e e11nt52q1']").text
        job_role.append(job_title)
    
    final_result=ke.get_user_id_to_list_of_job_ids(resume_skills,final_dict,all_skills,match_threshold)

    return job_role,final_result
