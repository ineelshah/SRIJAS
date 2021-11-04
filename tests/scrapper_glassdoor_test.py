import pytest
import sys
import json
sys.path.append("../Code/Scrapper")
from scrapper_glassdoor import get_job_description

resume_skills_dict = {"res1": [1, 2, 3, 4]}
total_skills = {1: "Java", 2: "C"}
threshold = 50
role="Software Engineer"
location="Raleigh"
no_of_jobs = 5
data = ""

def test_get_job_description_1():
    job_title , jobs = get_job_description(resume_skills_dict,total_skills, threshold, role, location, no_of_jobs, data)
    assert jobs is not None

def test_get_job_description_2():
    job_title, jobs = get_job_description(resume_skills_dict,total_skills, threshold, role, location, no_of_jobs, data)
    for i in jobs:
        assert i == "res1"

def test_get_job_description_3():
    job_title, jobs = get_job_description(resume_skills_dict,total_skills, threshold, role, location, no_of_jobs, data)
    assert job_title is not None
