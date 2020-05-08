# -*- coding:utf-8 -*-

import smtplib
from email.mime.text import MIMEText
from email.header import Header

def send_mail(user_name,user_email, msg_data):
    sender_user = 'opensource_cve@naver.com' 
    sender_pwd = 'kjpacii_13780' 
    msg_contents = user_name+"님, 당일 발생한 취약점 목록입니다.\n"
    for data in msg_data:
        msg_content = ( "\n제품명 : " + data[0]
                        +"\ncve id : " + data[1]
                        +"\n취약점 점수 : " + str(data[2]) + " " + data[3]
                        +"\n취약점 종류 : " + data[4])
        msg_contents += msg_content + "\n"
   
    msg = MIMEText(msg_contents)  # 메일 본문 
    msg['Subject'] = Header('[취약점 알림] 당일 발생 취약점', 'utf-8') # 메일 제목 
    msg['From'] = sender_user       # 송신 메일
    msg['To'] = user_email       # 수신 메일
    smtp = smtplib.SMTP("smtp.naver.com", 587)
    
    try:
        smtp.ehlo()
        smtp.starttls()
        smtp.ehlo()
        smtp.login(sender_user,sender_pwd)         
        smtp.send_message(msg)
        smtp.close()
        print('\nsuccessfully sent the mail')
    except smtplib.SMTPException:
        print('\nfailed to send mail')
   