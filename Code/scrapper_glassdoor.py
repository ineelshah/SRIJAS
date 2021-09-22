# -*- coding: utf-8 -*-
"""
Created on Tue Sep 21 23:14:03 2021

@author: Jay
"""


from selenium import webdriver
import time


#### get the glassdoor URL ######################################

def get_jobs(keyword,num_jobs,verbose):
     options = webdriver.ChromeOptions()
     options.add_argument('headless')
     driver  =  webdriver.Chrome ()
     url = "https://www.glassdoor.com/Job/jobs.htm?suggestCount=0&suggestChosen=false&clickSource=searchBtn&typedKeyword="+keyword+"&sc.keyword="+keyword+"&locT=&locId=&jobType="
     driver.get(url)
     job_urls = []
     c=0  
     job_buttons = driver.find_elements_by_xpath('.//a[@class = "jobLink job-search-key-1rd3saf eigr9kq1"]')  #jl for Job Listing. These are the buttons we're going to click.
     time.sleep(2)
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
             driver.get(i)
             button = driver.find_element_by_xpath('//*[@id="JobDescriptionContainer"]/div[2]')
             button.click()
             job_description = driver.find_element_by_xpath('//*[@id="JobDescriptionContainer"]/div[1]').text
             print(job_description)
             
             

df = get_jobs("Data Scientist",2,False)