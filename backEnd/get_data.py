#!/usr/bin/env python
# coding: utf-8

# In[58]:


from urllib.request import Request, urlopen
from urllib.parse import quote
from bs4 import BeautifulSoup
import requests
import numpy as np
import re
import os
import sys
import json
from collections import OrderedDict
from datetime import datetime
#from database import query as q
import query as q
import papago_API

def papago_translation(msg) :
    client_id = "gVQ2JfMK_e_2xJJfCXl7" # 개발자센터에서 발급받은 Client ID 값
    client_secret = "SHgMZJMfs_" # 개발자센터에서 발급받은 Client Secret 값

    encText = quote(msg)
    data = "source=en&target=ko&honorific=true&text=" + encText
    url = "https://openapi.naver.com/v1/papago/n2mt"
    
    req = Request(url)
    req.add_header("X-Naver-Client-Id",client_id)
    req.add_header("X-Naver-Client-Secret",client_secret)
    
    resp = urlopen(req, data=data.encode("utf-8"))
    rescode = resp.getcode()
    
    if(rescode==200):
        resp_body = resp.read()
        resp_json = json.loads(resp_body.decode('utf-8'))
        return resp_json['message']['result']['translatedText']
    else:
        return "Error Code:" + rescode

## URL 요청 함수 ##
def request_url(url) :
    req = Request(url)
    resp = urlopen(req)
    soup = BeautifulSoup(resp, 'html.parser')
    return soup

## 취약점 개수 크롤링 ##
def get_VulCount(soup) :
    tag_VulCount = soup.find("strong", {"data-testid":"vuln-matching-records-count"})
    VulCount = str(tag_VulCount.string)
    VulCount = int(VulCount.replace(',', ''))

    # Product Table
#     print("Product Name :", product)
#     print("Number of Vulnerabilities :", VulCount)
    
    return VulCount

## 제품의 CVE ID 가져오는 함수 ##
def get_cveID(cve_list, soup) :
    for i in range(20) :
        tag_cveID = soup.find("tr", {"data-testid":"vuln-row-" + str(i)})
        if tag_cveID == None :
            break
        cve_id = tag_cveID.find("a", {"data-testid":"vuln-detail-link-" + str(i)})
        cve_list.append(cve_id.string)
    
    return cve_list

def check_update(soup, product_id, cve_id) :
    tag_update_date = soup.find("span", {"data-testid":"vuln-last-modified-on"})
    update_date = tag_update_date.string
    result = q.select_details(product_id, cve_id)
    ## DB에서 업데이트 날짜를 가져오는 코드로 대체 ##
    if len(result) > 0:
        db_update_date = result[0][4]
    # 업데이트가 된 경우(1) / 업데이트가 되지 않은 경우(0)
    if db_update_date == update_date :
        return 0
    else :
        return 1
    
    ## 출력하는 코드를 DB(dashboard table)에 저장하는 코드로 대체
    #print("db_update_date: ", db_update_date," update_date :", update_date)


## 각 CVE ID에 해당하는 정보(순서대로 게시일, 수정일, 점수, 설명, 취약점 종류) 가져오는 함수 ##
def get_dashboard_data(soup, cve_id, product_id) :    
    tag_public_date = soup.find("span", {"data-testid":"vuln-published-on"})
    public_date = tag_public_date.string
    
    ##*# DB 삽입을 위해 다시 추가
    tag_update_date = soup.find("span", {"data-testid":"vuln-last-modified-on"})
    update_date = tag_update_date.string
    
    tag_score = soup.find("a", {"data-testid":"vuln-cvss3-panel-score"})
    if tag_score == None :
        tag_score = soup.find("a", {"data-testid":"vuln-cvss3-cna-panel-score"})
    
    if tag_score != None :
        score = tag_score.string
    else :
        tag_score = soup.find_all("span", {"class":"severityDetail"})
        score = tag_score[1].string
    
    tag_description = soup.find("p", {"data-testid":"vuln-description"})
    description = tag_description.string
    
    tag_cwe = soup.find_all("td", {"data-testid":"vuln-CWEs-link-0"})
    cwe = tag_cwe[1].string
    
    #tag_version = soup.find("div", {"data-testid":"vuln-configurations-container"})
    #version = tag_version.string
    
    cve_vector = get_cvss_vector(soup)
    
    ## db(details) 데이터 출력
    """
    print("[" + cve_id + "]")
    print("public_date :", public_date)
    print("score :", score)
    print("description :", description)
    print("Weakness Enumeration :", cwe)
    """
    # db(details) 데이터 삽입
    q.insert_details (product_id , cve_id, cwe, public_date, update_date, score, description, cve_vector)
    detail_data = OrderedDict()
    detail_data['product_id'] = product_id
    detail_data['cve_id'] = cve_id
    detail_data['cwe'] = cwe
    detail_data['public_date'] = public_date
    detail_data['update_date'] = update_date
    detail_data['score'] = score
    detail_data['description'] = description
    detail_data['cve_vector'] = cve_vector
    print(detail_data)

## HTML 내에서 버전 정보를 찾는 함수 ##
def find_version_str(version, str_range, find_str) : 
    veri = str_range.find(find_str)
    ver = str_range[veri:]
    starti = ver.find("<br/>") + 5
    endi = ver.find("</b>")
    ver = ver[starti:endi]
    return ver

## 각 CVE ID에 해당하는 취약한 버전 정보 가져오는 함수 ##
def get_version(soup, product, cve_id, product_id) :
    #regex_prodcut = re.compile(".+cpe.+\:.+\:.+\:.+\:"+product+"\:")
    #regex_single_ver = re.compile(".+cpe.+\:.+\:.+\:.+\:"+product+"\:[^*]{1,}\:.+")
    regex_prodcut = re.compile(".+cpe.+\:.+\:.+\:.+\:"+product+"\:", re.I)
    regex_single_ver = re.compile(".+cpe.+\:.+\:.+\:.+\:"+product+"\:[^*]{1,}\:.+", re.I)
    
    tag_cpe_version_total = soup.find("div", {"data-testid":"vuln-configurations-container"})

    tag_cpe_version = tag_cpe_version_total.find_all("div")

    # 취약한 버전 추출 1단계 : 해당 제품에 맞는 버전 정보 불러옴
    version_html_list = []
    for tag_cpe in tag_cpe_version :
        cpe = tag_cpe.find_all("b")
        for tag_version in cpe :
            if regex_prodcut.search(str(tag_version)) != None :
                version_html_list.append(tag_version)
    single_version = []
    range_version_html = []
    # 취약한 버전 추출 2단계 : 단일 버전인 경우 (ex. 3.0.0)
    for version_html in version_html_list :
        if regex_single_ver.search(str(version_html)) != None :
            element = []
            for single_v in version_html :
                element = str(single_v).split(":")
            if element[6] != "*" :
                single_version.append(element[5] + element[6])
            else :
                single_version.append(element[5])
        # 취약한 버전 추출 3단계(1) : 범위 버전인 경우 (ex. Up to 3.0.0)
        else :
            range_version_html.append(version_html)

    # 취약한 버전 추출 3단계(2) : 범위 버전인 경우 (ex. Up to 3.0.0)
    range_version = []
    tag_cpe_version = str(tag_cpe_version)
    for range_v in range_version_html :
        str_rangei = tag_cpe_version.find(str(range_v))
        str_range = tag_cpe_version[str_rangei:str_rangei+1000]

        version = []
        if str_range.find("From (including)") != -1 :
            ver_From_include = find_version_str(version, str_range, "From (including)") + "i"
            version.append(ver_From_include)
#             print(ver_From_include)
        elif str_range.find("From (excluding)") != -1 :
            ver_From_exclude = find_version_str(version, str_range, "From (excluding)") + "e"
            version.append(ver_From_exclude)
#             print(ver_From_exclude)
        else :
            version.append("0")
#             print("0")

        if str_range.find("Up to (including)") != -1 :
            ver_Up_to_include = find_version_str(version, str_range, "Up to (including)") + "i"
            version.append(ver_Up_to_include)
#             print(ver_Up_to_include)
        elif str_range.find("Up to (excluding)") != -1 :
            ver_Up_to_exclude = find_version_str(version, str_range, "Up to (excluding)") + "e"
            version.append(ver_Up_to_exclude)
#             print(ver_Up_to_exclude)
        else :
            version.append("-")
#             print("-")

        range_version.append(version)
        
    # db(cve_version) 데이터 출력
    """
    print("single version : " + str(single_version))
    print("range version : " + str(range_version))
    print("")
    """
    # db(cve_version) 데이터 삽입
    if(len(single_version) > 0):
        if(len(single_version) == 2):
            #print(cve_id , single_version[0], single_version[1])
            q.insert_cve_version (product_id, cve_id , single_version[0], single_version[1])
        else:
            #print(cve_id , single_version[0], '')
            q.insert_cve_version (product_id, cve_id , single_version[0], '')
    if(len(range_version) > 0):
        for i in range(len(range_version)):
            if(len(range_version[i]) == 2):
                #print(cve_id , range_version[i][0], range_version[i][1])
                q.insert_cve_version (product_id, cve_id , range_version[i][0], range_version[i][1])
            else:
                #print(cve_id , range_version[i][0], '')
                q.insert_cve_version (product_id, cve_id , range_version[i][0],'')
                
    # CVE-2019-15043와 같이 버전 추출 안되는 데이터는 크롤링 제외            
    if (len(single_version) == 0) and (len(range_version) == 0):
        print("single version : " + str(single_version))
        print("range version : " + str(range_version))
        print('버전 추출 안됨')
        print("")
        #sys.exit()
        return 0
    else :
        return 1
    print("")
   
def get_cvss_vector(soup) :
    tag_vector = soup.find("span", attrs={"data-testid": "vuln-cvss3-cna-vector"})
    if tag_vector == None:
        tag_vector = soup.find("span", attrs={"data-testid": "vuln-cvss3-nist-vector"})
        if tag_vector == None:
            tag_vector = soup.find("span", attrs={"data-testid": "vuln-cvss3-nist-vector-na"})
            
        
    vector = tag_vector.string
    if vector != "NVD score not yet provided.":
        return vector
        
    else :
        tag_vector = soup.find("span", attrs={"data-testid": "vuln-cvss2-panel-vector"})
        if tag_vector == None:
            tag_vector = soup.find("span", attrs={"data-testid": "vuln-cvss2-panel-vector-na"})
        
        vector = tag_vector.string
        if vector != "NVD score not yet provided.":
            vector = tag_vector.string[1:len(tag_vector.string)-1]
        return vector
        
    
    print("")
def get_advisories_solutions(soup, cve_id, product_id) :
    tag_advisories_solutions = soup.find("table", {"data-testid":"vuln-hyperlinks-table"})
    print()
    advisories_solutions_list = []
    
    for i in range(len(tag_advisories_solutions.tbody.find_all('tr'))) :
        advisories_solutions_sub_list = []
        tag_advisories_solutions_hyper = soup.find("td", {"data-testid":"vuln-hyperlinks-link-" + str(i)})
        tag_advisories_solutions_a = tag_advisories_solutions_hyper.find_all('a')[0]
        advisories_solutions_a = tag_advisories_solutions_a.string
        advisories_solutions_sub_list.append(advisories_solutions_a)
        #print('Hyperlink: ',advisories_solutions_a)
        res_list = []
        tag_advisories_solutions_td_res = soup.find("td", {"data-testid":"vuln-hyperlinks-restype-" + str(i)})
        if(len(tag_advisories_solutions_td_res.find_all('span')) > 0):
            for span_child in tag_advisories_solutions_td_res.find_all('span'):
                advisories_solutions_res = span_child.string
                res_list.append(advisories_solutions_res)
                # db(reference) 데이터 삽입
                q.insert_reference(product_id, cve_id, advisories_solutions_a, advisories_solutions_res)
        else:
            # db(reference) 데이터 삽입
            q.insert_reference(product_id, cve_id, advisories_solutions_a, '')
        advisories_solutions_sub_list.append(res_list)
        advisories_solutions_list.append(advisories_solutions_sub_list)
    # 결과 3차원 배열, [i][0] = hyperlink, [i][1][j] = resource
    #return(advisories_solutions_list)

def main(product="", cve_id="", file_name = "") :
    
    # 특정 CVE ID에 대해서만 확인, 에러 처리 안했음 (테스트용)
    """
    if product != "" and cve_id != "" :
        url_cve = "https://nvd.nist.gov/vuln/detail/" + cve_id
        soup = request_url(url_cve)
        ##*# 테스트 시 3번째 인자에 person_id 넣어줘야함.
        get_dashboard_data(soup, cve_id, "")
        get_version(soup, product)
        return
    """
    # 특정 제품의 CVE 개수 확인, 에러 처리 안했음 (테스트용)
    if product != "" :
        url_search = ("https://nvd.nist.gov/vuln/search/results?form_type=Advanced&results_type=overview&"
                      "search_type=all&cpe_product=cpe%3A%2F%3A%3A" + product)
        soup = request_url(url_search)
        VulCount = get_VulCount(soup)
        print(product + " total vulnerability : " + str(VulCount))
        return
        
    # 오픈소스 제품 목록 파일 읽어옴
    product_data = np.genfromtxt(file_name, delimiter=',', dtype="|U")
    #product_name = product_data[i][1]
    today = datetime.today().strftime('%m/%d/%Y')
    print("<<"+today+">>")
    for producti in range(len(product_data)) :
#     for producti in range(1) :
        product = product_data[producti][1]
        
        # 공백(%20) URL 인코딩
        product.replace(' ', '%20')
#         url_search = ("https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&query=" + product +
#                 "&queryType=phrase&search_type=all")
        url_search = ("https://nvd.nist.gov/vuln/search/results?form_type=Advanced&results_type=overview&"
                      "search_type=all&cpe_product=cpe%3A%2F%3A%3A" + product)
        soup = request_url(url_search)
    
        VulCount = get_VulCount(soup)
        
        # 해당 제품에 취약점이 없는 경우
        if int(VulCount) == 0 :
            print(product + " : 취약점 없음")
            continue
        
        ## 기존 취약점과 비교하는 코드로 대체(DB에서 취약점 개수 데이터 가져오기)
        ## 가져온 취약점 개수를(변경된 경우/초기 크롤링인 경우) DB(dashboard table)에 저장하는 코드로 대체
        # DB에 해당 제품이 존재하지 않는 경우(초기 크롤링인 경우) 계속 진행
        vulnerability_number = str(VulCount)
        print("----------------------- " + product + " -----------------------")
        print("total vulnerability : " + vulnerability_number)
        print("")
        
        
        # db(product) 데이터 삽입
        is_exist = q.select_source_type_where_name(product)
        if(len(is_exist) > 0):
            product_id = is_exist[0][0]
        
        is_update = q.select_product(product_id)
        print(is_update)
        # 초기 크롤링
        if(len(is_update) == 0):
            print('초기 크롤링')
        else :
            if int(is_update[0][2]) != int(vulnerability_number):
                print('변경된 경우: ',is_update[0][2])
        
        q.insert_product(product_id, is_exist[0][1], vulnerability_number)
        
        # CVE ID 가져옴
        cve_list = []
        cve_list = get_cveID(cve_list, soup)

        # 취약점이 20개 이상인 경우 페이지가 넘어감
        # 페이지에 따른 URL을 유동적으로 변경
        pages_num = int((VulCount-1) / 20)
        if pages_num != 0 :
            for page in range(pages_num) :
                url_page = url_search + "&startIndex=" + str(20 * (page+1))
                soup = request_url(url_page)
                cve_list = get_cveID(cve_list, soup)
#         print(cve_list)
        i = 1
        # CVE ID에 해당하는 정보 불러옴 -> dashboard 테이블에 저장
        for cve_id in cve_list :
            cnt = int(vulnerability_number)-i
            i = i+1
            # DB에 저장되어 있는 CVE_ID인지 확인
            details_data = q.select_details(product_id, cve_id)
            url_cve = "https://nvd.nist.gov/vuln/detail/" + cve_id
            soup = request_url(url_cve)
            print('['+cve_id+'] - '+ product+str(cnt))
            # 저장되어 있지 않은 CVE_ID만 DB에 데이터 삽입
            if len(details_data) == 0:
                # 첫 크롤링이어서 생략
#                if check_update(soup, product_id, cve_id) == 0 :
#                    continue
                
                ##*# 버전을 먼저 크롤링해야함.
                version = get_version(soup, product, cve_id, product_id)
                if version == 1:
                    print('['+cve_id+'] - '+ product+str(cnt))
                    get_dashboard_data(soup, cve_id, product_id)
                    get_advisories_solutions(soup, cve_id, product_id)
                
            else :
                # 업데이트가 되지 않은 경우 다음 CVE로 넘어감
                if check_update(soup, product_id, cve_id) == 0 :
                    continue
                # 업데이트된 경우 다시 크롤링
                ##*# 버전을 먼저 크롤링해야함.
                version = get_version(soup, product, cve_id, product_id)
                if version == 1:
                    print('['+cve_id+'] - '+ product+str(cnt))
                    get_dashboard_data(soup, cve_id, product_id)
                    get_advisories_solutions(soup, cve_id, product_id)
                
                
        print("------------------------------ end ------------------------------")
        print("")
    print("<<"+today+" - END>>")

# main(product = "")
# main(product = "elasticsearch", cve_id="CVE-2019-7614")
#main()