# -*- coding: utf-8 -*-
import query as q
import mail
from datetime import datetime

member_data = q.select_all_member()
today = datetime.today().strftime('%m/%d/%Y')
print("<<"+today+">>")
# test용 특정 날짜 08/28/2019
d = datetime(2019, 8, 28).strftime('%m/%d/%Y')
#print(d)
for m_data in member_data:
    user_id = m_data[0]
    user_pwd = m_data[1]
    user_name = m_data[2]
    user_phone = m_data[3]
    user_email = m_data[4]

    #print(user_id, user_pwd, user_name, user_phone, user_email)
    print(user_id, user_name, user_email)
    bookmark_data = q.select_source_bookmark_where_u_id(user_id)
    #print(bookmark_data)
    msg_data = []
    for b_data in bookmark_data:
        product_id = b_data[1]
        p_data = q.select_product(product_id)
        if len(p_data) == 0:
            continue
        product_name = p_data[0][1]
        #print(product_id)

        details_data = q.select_details_where_date(product_id, today)
        #msg_data = OrderedDict()
        
        for d_data in details_data:
            cve_id = d_data[1]
            num_score = d_data[5].split(' ')[0]
            str_score = d_data[5].split(' ')[1]
            vul_type = d_data[3] # 취약점 종류
            msg_data.append((product_name, cve_id, float(num_score), str_score, vul_type))
    if len(msg_data) > 0:
        # score 값으로 내림차순 
        msg_data = list(reversed(sorted(msg_data, key = lambda x : x[2])))
    print("발생 개수 : " + str(len(msg_data)))
    print(msg_data)
    if len(msg_data) > 0:
        mail.send_mail(user_name, user_email, msg_data)
