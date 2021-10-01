import pytest
import sys
sys.path.append("../Code/Scrapper")
from keyword_extraction_modules import get_user_id_to_list_of_job_ids
import keyword_extraction_modules as kem


resume_skills_dict = {"res1": [1, 2, 3, 4]}
links_description_dict = {"link1": "This description has java and python class."}
total_skills = {1: "Java", 2: "C"}
threshold = 50
db_connection = ""


def test_main_function():
  assert get_user_id_to_list_of_job_ids(resume_skills_dict, links_description_dict, db_connection, total_skills, threshold) == {'res1': ['link1']}


def test_match_both_lists_empty():
    list1 = []
    list2 = []
    assert kem.match_both_lists(list1, list2, 50, 10) == False

def test_match_both_lists_equal():
    list1 = [1,2,3,4,5,6,7,8,9]
    list2 = [1,2,3,4,5,6,7,8,9]
    assert kem.match_both_lists(list1, list2, 50, 10) == True

def test_match_both_lists_half_1():
    list1 = [1,2,3,4]
    list2 = [1,2,3,4,5,6,7,8,9]
    assert kem.match_both_lists(list1, list2, 50, 10) == False

def test_match_both_lists_half_2():
    list1 = [1,2,3,4,5]
    list2 = [1,2,3,4,5,6,7,8,9]
    assert kem.match_both_lists(list1, list2, 50, 10) == True

def test_match_both_lists_half_2():
    list1 = [1]
    list2 = ['a']
    error_flag = False
    try:
        kem.match_both_lists(list1, list2, 50, 10)
    except:
        error_flag = True
    assert error_flag == False


def test_get_list_of_matched_skills_just_1():
    total_skills = {1: "Java", 2: "C"}
    assert kem.get_list_of_matched_skills("This description has java and python class.", total_skills) == [1]

def test_get_list_of_matched_skills_both():
    total_skills = {1: "Java", 2: "Python"}
    assert kem.get_list_of_matched_skills("This description has java and python class.", total_skills) == [1, 2]


def test_get_list_of_matched_skills_none():
    total_skills = {1: "C++", 2: "C"}
    assert kem.get_list_of_matched_skills("This description has java and python class.", total_skills) == []

def test_get_list_of_matched_skills_one_different_sentences():
    total_skills = {1: "Java", 2: "C"}
    assert kem.get_list_of_matched_skills("This description has java. Also has python class.", total_skills) == [1]


def test_get_list_of_matched_skills_two_with_spaces():
    total_skills = {1: "SQL", 2: "JAVA"}
    assert kem.get_list_of_matched_skills("This description has java and python class. SQL with spaces.", total_skills) == [1, 2]

def test_get_dict_with_list_of_skills_from_description_one_link():
    links_description_dict = {"link1": "This description has java and python class."}
    total_skills = {1: "Java", 2: "C"}
    assert kem.get_dict_with_list_of_skills_from_description(links_description_dict, total_skills) == {"link1" : [1]}

def test_get_dict_with_list_of_skills_from_description_two_links():
    links_description_dict = {"link1": "This description has java and python class.", "link2": "This description has SQL."}
    total_skills = {1: "Java", 2: "C", 3: "SQL", 4:"C++"}
    assert kem.get_dict_with_list_of_skills_from_description(links_description_dict, total_skills) == {"link1" : [1], "link2" : [3]}

def test_get_dict_with_list_of_skills_from_description_none():
    links_description_dict = {"link1": "This description has none of them."}
    total_skills = {1: "Java", 2: "C"}
    assert kem.get_dict_with_list_of_skills_from_description(links_description_dict, total_skills) == {"link1" : []}

def test_get_dict_with_list_of_skills_from_description_both_empty_lists():
    links_description_dict = {"link1": "This description has nothing.", "link2": "This description has nothing either."}
    total_skills = {1: "Java", 2: "C"}
    assert kem.get_dict_with_list_of_skills_from_description(links_description_dict, total_skills) == {"link1" : [], "link2" : []}

def test_get_user_id_to_list_of_job_ids():
    assert kem.get_user_id_to_list_of_job_ids(resume_skills_dict, links_description_dict, db_connection, total_skills, threshold) == {'res1': ['link1']}
