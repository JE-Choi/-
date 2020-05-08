import os
import sys
from urllib.request import Request, urlopen
from urllib.parse import quote
import json

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
    
def translate_description(logfile, cve_id, msg) :
    # 번역 완료된 CVE_ID가 기록된 파일 read
    f = open(logfile, "r")
    
    complete_list = f.readlines()
    for complete_cve in complete_list :
        # 번역하려는 CVE_ID가 로그 파일에 있는지 점검
        if complete_cve == cve_id +"\n" :
            f.close()
            return 0
    f.close()
    
    # 번역하려는 CVE_ID를 로그 파일에 기록하기 위해 내용 추가 모드로 open
    f = open(logfile, "a")
    try :
        msg = papago_translation(msg)
        ## DB 내에 있는 description 교체 코드 필요
        print(msg)
    except Exception as e:
        f.close()
        return -1
    
    # CVE_ID를 기록
    f.write(cve_id + "\n")
    f.close()
    return 1