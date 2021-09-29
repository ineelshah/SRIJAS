# -*- coding: utf-8 -*-
"""
Created on Wed Sep 29 16:36:56 2021

@author: Jay
"""

import pytest
import scrapper_glassdoor as sg
properties = open('properties.json')
def get_db_name(properties):
    connection = sg.db_connect(properties)
    cursor = connection.cursor()
    cursor.execute("select database();")
    record = cursor.fetchone()
    return record
    #assert record == "('srijas',)"

    
def test_db():
    assert get_db_name(properties)== ('srijas',)
    

def len_total_skills():
    connection = sg.db_connect(properties)
    df={}
    df = sg.get_total_skills(connection)
    return len(df)

def len_resume_id_skills():
    connection = sg.db_connect(properties)
    df={}
    df = sg.get_resume_id_skills(connection)
    return len(df)    


def len_email_id_users():
    connection = sg.db_connect(properties)
    df={}
    df = sg.get_email_id_users(connection)
    return len(df)   

def len_get_job_description():
    connection = sg.db_connect(properties)
    df=[]
    df = sg.get_job_description(connection)
    return len(df)

def test_total_skills():
   # print(len(df))
    assert len_total_skills != 0   
    
def test_resume_id_skills():
    assert len_resume_id_skills !=0
 

def test_email_id_users():
   # print(len(df))
    assert len_email_id_users != 0 
    
def test_get_job_description():
   # print(len(df))
    assert len_get_job_description != 0     
