#!/usr/bin/env python
# coding: utf-8

# In[1]:


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

