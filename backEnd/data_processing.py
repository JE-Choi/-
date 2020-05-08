CVSS3_processed_vector = {"공격 종류" : "",
               "공격 복잡도" : "",
               "공격에 필요한 권한" : "",
               "일반 사용자의 상호작용 요구" : "",
               "보안 영향 범위" : "",
               "기밀성 위협" : "",
               "무결성 위협" : "",
               "가용성 위협" : ""}

CVSS2_processed_vector = {"공격 종류" : "",
               "공격 복잡도" : "",
               "공격자의 인증" : "",
               "기밀성 위협" : "",
               "무결성 위협" : "",
               "가용성 위협" : ""}

CVSS2_3_AV_value = {"N" : "원격 네트워크 공격",
                 "A" : "인접(내부) 네트워크 공격",
                 "L" : "내부 공격",
                 "P" : "물리적 공격"}

CVSS2_3_Vul_value = {"N" : "없음",
              "L" : "낮음",
              "M" : "중간",
              "H" : "높음",
              "R" : "필수"}

CVSS3_scope_value = {"U" : "다른 자원에 영향 없음",
                   "C" : "다른 자원에 영향 있음"}

CVSS2_Auth_value = {"M" : "복수의 인증 필요",
                   "S" : "한번의 인증 필요",
                   "N" : "인증 필요하지 않음"}

CVSS2_CIA_value = {"N" : "없음",
                  "P" : "부분적 영향",
                  "C" : "영향 높음"}

def vector_transform(version, vector) :
    if version == 2 :
        vector_list = vector.split('/')
        attack_vector = (vector_list[0].split(':'))[1] # 공격 벡터(AV)
        attack_complexity = (vector_list[1].split(':'))[1] # 공격 복잡도 (AC)
        authentication = (vector_list[2].split(':'))[1] # 인증 (AU)
        confidentiality = (vector_list[3].split(':'))[1] #기밀성 (C)
        integrity = (vector_list[4].split(':'))[1] #무결성 (I)
        availability = (vector_list[5].split(':'))[1] #가용성 (A)
        
        CVSS2_processed_vector["공격 종류"] = CVSS2_3_AV_value[attack_vector]
        CVSS2_processed_vector["공격 복잡도"] = CVSS2_3_Vul_value[attack_complexity]
        CVSS2_processed_vector["공격자의 인증"] = CVSS2_Auth_value[authentication]
        CVSS2_processed_vector["기밀성 위협"] = CVSS2_CIA_value[confidentiality]
        CVSS2_processed_vector["무결성 위협"] = CVSS2_CIA_value[integrity]
        CVSS2_processed_vector["가용성 위협"] = CVSS2_CIA_value[availability]
        
        return CVSS2_processed_vector
    
    elif version == 3 :
        vector_list = vector.split('/')
        attack_vector = (vector_list[1].split(':'))[1] # 공격 벡터(AV)
        attack_complexity = (vector_list[2].split(':'))[1] # 공격 복잡도 (AC)
        privileges_required = (vector_list[3].split(':'))[1] # 권한 필요 (PR)
        user_interaction = (vector_list[4].split(':'))[1]  # 사용자 상호작용 (UI)
        scope = (vector_list[5].split(':'))[1] # 범위 (S)
        confidentiality = (vector_list[6].split(':'))[1] #기밀성 (C)
        integrity = (vector_list[7].split(':'))[1] #무결성 (I)
        availability = (vector_list[8].split(':'))[1] #가용성 (A)
        
        CVSS3_processed_vector["공격 종류"] = CVSS2_3_AV_value[attack_vector]
        CVSS3_processed_vector["공격 복잡도"] = CVSS2_3_Vul_value[attack_complexity]
        CVSS3_processed_vector["공격에 필요한 권한"] = CVSS2_3_Vul_value[privileges_required]
        CVSS3_processed_vector["일반 사용자의 상호작용"] = CVSS2_3_Vul_value[user_interaction]
        CVSS3_processed_vector["보안 영향 범위"] = CVSS3_scope_value[scope]
        CVSS3_processed_vector["기밀성 위협"] = CVSS2_3_Vul_value[confidentiality]
        CVSS3_processed_vector["무결성 위협"] = CVSS2_3_Vul_value[integrity]
        CVSS3_processed_vector["가용성 위협"] = CVSS2_3_Vul_value[availability]
        
        return CVSS3_processed_vector