from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib
from socket import gaierror
import json

#Create function sendmail 
def sendmail(final_result,email_id_list, job_role):
    port = 587
    smtp_server = "smtp.gmail.com"
    login = "srijas.alerts@gmail.com"
    properties = open('parameters.json')
    data = json.load(properties)
    password = str(data['linked_in_pwd'])
    sender = "srijas.alerts@gmail.com"
    flag = 0
    for key in final_result:
        if key in email_id_list:
            receiver = email_id_list[key]
            print(receiver)
            msg = MIMEMultipart()
            msg['From'] = sender
            msg['To'] = receiver
            msg['Subject'] = 'Job Lisitngs'
            body = """Hi, \n PFA the attached list of jobs that match your resume \n"""
            temp_str = ""
            list_of_curr_links = final_result[key]
            counter = 1
            for link in list_of_curr_links:
                print(link)
                pre = """<a href='"""
                embedded_link = link
                post = """'>Click here</a>"""
                temp_str += (str(counter) + ".  " + job_role[counter-1] + ': ' + pre + embedded_link + post+ '\n')
                counter += 1
            body += temp_str
            msg.attach(MIMEText(body, 'html'))
            text = msg.as_string()
            flag=1
            try:
                server = smtplib.SMTP(smtp_server, port)
                server.connect(smtp_server,port)
                server.ehlo()
                server.starttls()
                server.ehlo()
                server.login(login, password)
                server.sendmail(sender, receiver, text)
                server.quit()                               # tell the script to report if your message was sent or which errors need to be fixed
                # print('Sent')
            except (gaierror, ConnectionRefusedError):
                # print('Failed to connect to the server. Bad connection settings?')
                flag=2
            except smtplib.SMTPServerDisconnected as e:
                # print('Failed to connect to the server. Wrong user/password?')
                # print(str(e))
                flag=3
            except smtplib.SMTPException as e:
                # print('SMTP error occurred: ' + str(e))
                flag=4
   # Depending upon the value of flag it shows whether skills are matched or not , email is sent or not amd doess it fail to connect to the server with wrong password or bad connection
    if flag == 0:
        return "Skill or Job Role not matched"
    elif flag==1:
        return "Sent"
    elif flag==2:
        return "Failed to connect to the server. Bad connection settings"
    elif flag==3:
        return "Failed to connect to the server. Wrong user/password"
    else:
        return "SMTP error occurred"
