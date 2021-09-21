from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from socket import gaierror

import smtplib
port = 587
smtp_server = "smtp.gmail.com"
login = "srijas.alerts@gmail.com"
password = ""
sender = "srijas.alerts@gmail.com"
receiver = "srijas.alerts@gmail.com"

msg = MIMEMultipart()
msg['From'] = sender
msg['To'] = receiver
msg['Subject'] = 'GABOIL Coupon Generated'
body = f'you has won a coupon of Rs.500'
msg.attach(MIMEText(body, 'plain'))
text = msg.as_string()

try:
    server = smtplib.SMTP(smtp_server, port)
    server.connect(smtp_server,port)
    server.ehlo()
    server.starttls()
    server.ehlo()
    server.login(login, password)
    server.sendmail(sender, receiver, text)
    server.quit()


                                                                            # tell the script to report if your message was sent or which errors need to be fixed
    print('Sent')
except (gaierror, ConnectionRefusedError):
    print('Failed to connect to the server. Bad connection settings?')
except smtplib.SMTPServerDisconnected as e:
    print('Failed to connect to the server. Wrong user/password?')
    print(str(e))
except smtplib.SMTPException as e:
    print('SMTP error occurred: ' + str(e))