import pytest
import sys
sys.path.append("../Code/Scrapper")
from keyword_extraction_modules import get_user_id_to_list_of_job_ids


resume_skills_dict = {"res1": [1, 2, 3, 4]}
links_description_dict = {"link1": "This description has java and python class."}
total_skills = {1: "Java", 2: "C"}
threshold = 50
db_connection = ""


def test_main_function():
  assert get_user_id_to_list_of_job_ids(resume_skills_dict, links_description_dict, db_connection, total_skills, threshold) == {'res1': ['link1']}
