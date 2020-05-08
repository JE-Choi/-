import pymysql

def connectDB():
    # Server Dababase
    db = pymysql.connect(host='15.165.78.149', port=3306, user='user', passwd='opensource24680', db='opensourcesecurity', charset='utf8')
    # local Dababase
    #db = pymysql.connect(host='localhost', port=3306, user='root', passwd='gomdoll', db='opensourcesecurity', charset='utf8')
    return db

## member 테이블
def insert_member(user_id, user_password, user_name, user_phonenumber, user_email):
    db = connectDB()
    result = select_member(user_id)
    if len(result) == 0:
        try:
            cursor = db.cursor()
            sql = "INSERT INTO member VALUES(%s, %s, %s, %s, %s)"
            cursor.execute(sql, (user_id, user_password, user_name, user_phonenumber, user_email))
        
            db.commit()
            print(cursor.lastrowid)
        finally:
            db.close()

def select_member (user_id):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM member WHERE user_id = %s"
        cursor.execute(sql, (user_id))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

def select_all_member ():
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM member"
        cursor.execute(sql)
        result = cursor.fetchall()
    finally:
        db.close()
    return result 

def update_member(user_id, user_password, user_name, user_phonenumber, user_email):
    db = connectDB() 
    try:
        cursor = db.cursor()
        sql = "UPDATE member SET user_id = %s, user_password = %s, user_name = %s , user_phonenumber = %s, user_email = %s where user_id = %s"
        cursor.execute(sql, (user_id, user_password, user_name, user_phonenumber, user_email, user_id))
        
        db.commit()
        print("member 데이터 업데이트")
        print(cursor.lastrowid)
    finally:
        db.close()

def delete_member (user_id):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "delete FROM member WHERE user_id = %s"
        cursor.execute(sql, (user_id))
        db.commit()
        print(cursor.lastrowid)
    finally:
        db.close()
        
## source_bookmark 테이블
def insert_source_bookmark (user_id, product_id, product_version):
    db = connectDB()
    result = select_source_bookmark(user_id, product_id, product_version)
    if len(result) == 0:
        try:
            cursor = db.cursor()
            sql = "INSERT INTO source_bookmark VALUES(%s, %s, %s)"
            cursor.execute(sql, (user_id, product_id, product_version))
        
            db.commit()
            print(cursor.lastrowid)
        finally:
            db.close()
            
def select_source_bookmark (user_id, product_id, product_version):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM source_bookmark WHERE user_id = %s AND product_id = %s AND product_version = %s"
        cursor.execute(sql, (user_id, product_id, product_version))
        result = cursor.fetchall()
    finally:
        db.close()
    return result


def select_source_bookmark_where_u_id (user_id):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM source_bookmark WHERE user_id = %s"
        cursor.execute(sql, (user_id))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

def update_source_bookmark (user_id, product_id, product_version):
    db = connectDB() 
    try:
        cursor = db.cursor()
        sql = "UPDATE source_bookmark SET user_id = %s, product_id = %s, product_version = %s where user_id = %s and product_id = %s"
        cursor.execute(sql, (user_id, product_id, product_version, user_id, product_id))
        
        db.commit()
        print("source_bookmark 데이터 업데이트")
        print(cursor.lastrowid)
    finally:
        db.close()
        
def delete_source_bookmark (user_id, product_id, product_version):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "delete FROM source_bookmark WHERE user_id = %s and product_id = %s"
        cursor.execute(sql, (user_id, product_id))
        db.commit()
        print(cursor.lastrowid)
    finally:
        db.close()
## cve_version 테이블
def insert_cve_version (product_id, cve_id , cve_version_from, cve_version_to):
    db = connectDB()
    print(product_id, cve_id, cve_version_to)
    result = select_cve_version(product_id, cve_id , cve_version_to)
    print(len(result))
    
    if len(result) == 0:
        try:
            cursor = db.cursor()
            sql = "INSERT INTO cve_version VALUES(%s, %s, %s, %s)"
            cursor.execute(sql, (product_id, cve_id , cve_version_from, cve_version_to))
        
            db.commit()
            print(cursor.lastrowid)
        finally:
            db.close()
    else :
        update_cve_version (product_id, cve_id , cve_version_from, cve_version_to)
    
    
        
def select_cve_version (product_id, cve_id , cve_version_to):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM cve_version WHERE product_id = %s AND cve_id = %s AND cve_version_to = %s"
        cursor.execute(sql, (product_id, cve_id , cve_version_to))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

def update_cve_version (product_id, cve_id , cve_version_from, cve_version_to):
    db = connectDB() 
    try:
        cursor = db.cursor()
        sql = ("UPDATE cve_version SET product_id = %s, cve_id = %s, cve_version_from = %s, "
        "cve_version_to = %s where product_id = %s and cve_id = %s and cve_version_to = %s")
        cursor.execute(sql, (product_id, cve_id , cve_version_from, cve_version_to, product_id, cve_id, cve_version_to))
        db.commit()
        print("cve_version 데이터 업데이트")
        print(cursor.lastrowid)
    finally:
        db.close()
        

## product 테이블
def insert_product (product_id, product_name ,vulnerability_number):
    db = connectDB() 
    result = select_product(product_id)
    if(len(result) == 0):
        try:
            cursor = db.cursor()
            sql = "INSERT INTO product VALUES(%s, %s, %s)"
            cursor.execute(sql, (product_id, product_name ,vulnerability_number))
        
            db.commit()
            print(cursor.lastrowid)
        finally:
            db.close()
    else :
        update_product (product_id, product_name ,vulnerability_number)
            
def select_product (product_id):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM product where product_id = %s"
        cursor.execute(sql, (product_id))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

def update_product (product_id, product_name ,vulnerability_number):
    db = connectDB() 
    try:
        cursor = db.cursor()
        sql = "UPDATE product SET product_id = %s, product_name = %s, vulnerability_number = %s where product_id = %s"
        cursor.execute(sql, (product_id, product_name ,vulnerability_number, product_id))
    
        db.commit()
        print("product 데이터 업데이트")
    finally:
        db.close()
        
## details테이블
def insert_details (product_id , cve_id, vulnerability_type, publish_date, update_date, vulnerability_score, vulnerability_description, cve_vector):
    db = connectDB()
    #print(product_id , cve_id, vulnerability_type, publish_date, update_date, vulnerability_score, vulnerability_description, cve_vector)
    result = select_details(product_id, cve_id)
    if len(result) == 0:
        
        try:
            cursor = db.cursor()
            sql = "INSERT INTO details VALUES(%s, %s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (product_id , cve_id, vulnerability_type, publish_date, update_date, vulnerability_score, vulnerability_description, cve_vector))
        
            db.commit()
            print(cursor.lastrowid)
        finally:
            db.close()
    else :
        update_details (product_id , cve_id, vulnerability_type, publish_date, update_date, vulnerability_score, vulnerability_description, cve_vector)  
        
def select_details (product_id , cve_id):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM details where product_id = %s AND cve_id = %s"
        cursor.execute(sql, (product_id, cve_id))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

def select_details_where_date (product_id, date):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM details where product_id = %s AND (publish_date = %s OR update_date = %s)"
        cursor.execute(sql, (product_id, date, date))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

def update_details (product_id , cve_id, vulnerability_type, publish_date, update_date, vulnerability_score, vulnerability_description, cve_vector):
    db = connectDB() 
    try:
        cursor = db.cursor()
        sql = ("UPDATE details SET product_id = %s, cve_id = %s, vulnerability_type = %s, publish_date = %s, update_date = %s, "
               "vulnerability_score = %s, vulnerability_description = %s, cve_vector = %s where product_id = %s and cve_id = %s")
        cursor.execute(sql, (product_id , cve_id, vulnerability_type, publish_date, update_date, vulnerability_score, vulnerability_description, cve_vector, product_id , cve_id))
        
        db.commit()
        print("details 데이터 업데이트")
        print(cursor.lastrowid)
    finally:
        db.close()
        
## reference 테이블
def insert_reference (product_id, cve_id, cve_link, cve_resource):
    db = connectDB()
    print(product_id, cve_id, cve_link, cve_resource)
    result = select_reference(product_id, cve_id, cve_link, cve_resource)
    print(result)
    
    if(len(result) == 0):
        try:
            cursor = db.cursor()
            sql = "INSERT INTO reference VALUES(%s, %s, %s, %s)"
            cursor.execute(sql, (product_id, cve_id, cve_link, cve_resource))
        
            db.commit()
            print(cursor.lastrowid)
        except:
            print('에러발생')
        finally:
            db.close()
    
        
def select_reference (product_id, cve_id, cve_link, cve_resource):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM reference where product_id = %s AND cve_id = %s AND cve_link = %s AND cve_resource = %s"
        cursor.execute(sql, (product_id, cve_id, cve_link, cve_resource))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

## source_type 테이블
def insert_source_type (product_id, product_name, sourcetype_summary):
    db = connectDB()
    result = select_source_type(product_id)
    if(len(result) == 0):
        try:
            cursor = db.cursor()
            sql = "INSERT INTO source_type (product_id, product_name, sourcetype_summary) VALUES(%s, %s, %s)"
            cursor.execute(sql, (product_id, product_name, sourcetype_summary))
        
            db.commit()
            print(cursor.lastrowid)
        finally:
            db.close()
    
def select_source_type (product_id):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM source_type where product_id = %s"
        cursor.execute(sql, (product_id))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

def select_source_type_where_name (product_name):
    db = connectDB()
    try:
        cursor = db.cursor()
        sql = "SELECT * FROM source_type where product_name = %s"
        cursor.execute(sql, (product_name))
        result = cursor.fetchall()
    finally:
        db.close()
    return result

# member_insert example
"""
insert_member('user1', '1234', 'name1', '010-1234-5678', 'abc@email.com')
insert_member('user2', '1234', 'name2', '010-1234-5678', 'abc@email.com')
insert_member('user3', '1234', 'name3', '010-1234-5678', 'abc@email.com')

update_member('user1', '5678', 'name1', '010-1234-5678', 'abc@email.com')
"""
# source_bookmark_insert example
# userid는 login정보 가져올 예정
# product id과 product_version는 북마크 화면에 있는 리스트와 버전 입력값에서 가져올 예정
"""
insert_source_bookmark('user1', '1', '1.0')
update_source_bookmark('user1', '1', '2.0')
"""



