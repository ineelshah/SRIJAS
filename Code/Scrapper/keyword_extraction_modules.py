def get_user_id_to_list_of_job_ids(resume_skills_dict, links_description_dict, db_connection, total_skills, threshold):
    result_dict = dict()
    job_desc_link_and_skills_dict = get_dict_with_list_of_skills_from_description(links_description_dict, total_skills)
    for curr_resume in resume_skills_dict:
        list_of_skills_in_resume = resume_skills_dict[curr_resume]
        for link in job_desc_link_and_skills_dict:
            list_of_skills_in_description = job_desc_link_and_skills_dict[link]
            if match_both_lists(list_of_skills_in_resume, list_of_skills_in_description, threshold, len(total_skills)):
                if curr_resume in result_dict:
                    curr_list = result_dict[curr_resume]
                else:
                    curr_list = []
                curr_list.append(link)
                result_dict[curr_resume] = curr_list
    return result_dict

def get_dict_with_list_of_skills_from_description(links_description_dict, total_skills):
    job_desc_link_and_skills_dict = dict()
    for link in links_description_dict:
        description = links_description_dict[link]
        skills_matched_in_curr_description = get_list_of_matched_skills(description, total_skills)
        job_desc_link_and_skills_dict[link] = skills_matched_in_curr_description
    return job_desc_link_and_skills_dict

def get_list_of_matched_skills(description, total_skills):
    list_of_skills_matched = []
    description = description.upper()
    desc_list = description.split(" ")
    for skill in total_skills:
        if (total_skills[skill].upper() in desc_list) or ((total_skills[skill].upper() + ".") in desc_list) or (total_skills[skill].upper().center(1) in desc_list):
            list_of_skills_matched.append(skill)
    #print(list_of_skills_matched)
    return list_of_skills_matched

def match_both_lists(list_of_skills_in_resume, list_of_skills_in_description, threshold, total_skill_count):
    count = 0
    for skill in list_of_skills_in_description:
        if skill in list_of_skills_in_resume:
            count += 1
    if ((count / total_skill_count) * 100 >= threshold): return True
    return False

if __name__ == '__main__':
    resume_skills_dict = {"res1": [1, 2, 3, 4]}
    links_description_dict = {"link1": "This description has java and python class."}
    total_skills = {1: "Java", 2: "C"}
    threshold = 50
    db_connection = ""
    print(get_user_id_to_list_of_job_ids(resume_skills_dict, links_description_dict, db_connection, total_skills, threshold))