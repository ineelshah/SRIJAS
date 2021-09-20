from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
username="atathav@ncsu.edu"
pwd="Goldeng@te2486"
options = Options()
options.headless = True
options.add_argument("--window-size=1920,1200")
browser = webdriver.Chrome(options=options, executable_path="D:\ChromeDriver\chromedriver.exe")
#browser.get('https://www.linkedin.com/jobs/jobs-in-raleigh-nc?trk=homepage-basic_intent-module-jobs&position=1&pageNum=0')

################################Sign IN#################################################
browser.get('https://www.linkedin.com/checkpoint/rm/sign-in-another-account?fromSignIn=true&trk=guest_homepage-basic_nav-header-signin')
username_ip=browser.find_element_by_id('username')
username_ip.send_keys(username)
pwd_ip=browser.find_element_by_id('password')
pwd_ip.send_keys(pwd)
sign_in_button=browser.find_element_by_xpath("//button[@data-litms-control-urn='login-submit']")
sign_in_button.click();
browser.get('https://www.linkedin.com/jobs/jobs-in-raleigh-nc?trk=homepage-basic_intent-module-jobs&position=1&pageNum=0')
time.sleep(4)
searchquery="Software Engineer"
no_of_jobs_to_retrieve=5
count=0
#setting job filter value
job_description=browser.find_element_by_id("jobs-search-box-keyword-id-ember40").send_keys(searchquery)
#inserting job filter value
search_button=browser.find_element_by_class_name("jobs-search-box__submit-button")
search_button.click()
time.sleep(3)#give time to load search query results
###################################################################################################################################

###############duration filter######################
#job_filter=browser.find_element_by_xpath("//input[@id='f_TPR-0']")
#submit_job_filter=browser.find_element_by_xpath("//button[@data-tracking-control-name='public_jobs_f_TPR']")
#submit_job_filter.send_keys(job_filter)
#submit_job_filter.click()

############################################scrape the description#############################################
#retrieve job links
job_cards=browser.find_elements_by_xpath("//a[@class='disabled ember-view job-card-container__link job-card-list__title']")
href_arr=[]
for i in job_cards:
    href_arr.append(i.get_attribute("href"))
print(len(href_arr))#=25
 #looping through every job listing to scrape relevant data
data=[]
for url in href_arr:
     browser.get(url)
     time.sleep(5)
     show_more_button=browser.find_element_by_xpath("//button[@id='ember48']")
     show_more_button.click()
     data.append(browser.find_element_by_tag_name("ul").text)
     time.sleep(5)
     count+=1
     if(count==no_of_jobs_to_retrieve):
         break
print(data)
#browser.close()

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
