from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select
import pandas as pd
import re
options = Options()
options.headless = True
options.add_argument("--window-size=1920,1200")
browser = webdriver.Chrome(options=options, executable_path="D:\ChromeDriver\chromedriver.exe")
browser.get('https://www.linkedin.com/jobs/jobs-in-raleigh-nc?trk=homepage-basic_intent-module-jobs&position=1&pageNum=0')
searchquery="Software Engineer"

#setting job filter value
job_description=browser.find_element_by_name("keywords").send_keys(searchquery)
#inserting job filter value
search_button=browser.find_element_by_class_name("base-search-bar__submit-btn")
#finding the search icon
searchIcon=browser.find_element_by_xpath("//button[@data-tracking-control-name='public_jobs_jobs-search-bar_base-search-bar-search-submit']")
#search
searchIcon.click()


