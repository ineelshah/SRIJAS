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
import smtplib



def get_job_description(driver, connection,resume_skills,all_skills, match_threshold, role, location, no_of_jobs_to_retrieve, data):
    # data={}
    # data["keywords"] = role
    # data["location"] = location
    # data["f_JT"]="F,P"
    # data["f_E"]="1,3"
    role = role.replace(' ','')
    url = "https://www.linkedin.com/jobs/jobs-in-"+location+"?keywords="+role+"&f_JT=F%2CP&f_E=1%2C3"
    # url_parts = list(urllib.parse.urlparse(url))
    # query = dict(urllib.parse.parse_qsl(url_parts[4]))
    # query.update(data)
    # url_parts[4] = urllib.parse.urlencode(query,quote_via=urllib.parse.quote)
    # print(urllib.parse.urlunparse(url_parts))
    limit = no_of_jobs_to_retrieve
    print(url)
    # headers = {"user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
    driver.get(url)

    soup1 = BeautifulSoup(driver.page_source,'html.parser')
    # print(soup1)
    # print(soup1)
    # string1 = soup1.find("div",{"class":"flex-grow-1 artdeco-entity-lockup__content ember-view"})
    string1 = soup1.findAll("a",{"class":"base-card__full-link"})
    # print(string1)
    description_dict = {}
    for i in range(len(string1)):
        if role.lower() in string1[i].get_text().lower() and limit>0:
            dictionary = {}
            dictionary["Job Title"] = string1[i].get_text().replace('\n',' ').replace(' ','')
            dictionary["Job Link"] = string1[i]['href']
            limit-=1
            k = requests.get(string1[i]['href']).text
            soup=BeautifulSoup(k,'html.parser')
            str2 = soup.findAll("div", {"class" : "show-more-less-html__markup show-more-less-html__markup--clamp-after-5"})
            # print(str2)
            str3 = str2[0].get_text()
            # print(str3)
            description_dict[dictionary["Job Link"]]=str3

    final_result=ke.get_user_id_to_list_of_job_ids(resume_skills,description_dict,connection,all_skills,match_threshold)

    return final_result
