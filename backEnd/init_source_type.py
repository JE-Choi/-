"""
    #오픈소스 제품 목록.cvs읽어서 Database에 삽
"""
import numpy as np
import query as q

# 오픈소스 제품 목록 파일 읽어옴
product_data = np.genfromtxt("opensource_product_list_detail.csv", delimiter=',', dtype="|U")

for i in range(len(product_data)):
    q.insert_source_type(product_data[i][0], product_data[i][1],  product_data[i][2]);

