// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DetailsDTO.java

package com.exe.dto;


public class DetailsDTO
{

    public DetailsDTO()
    {
    }

    public int getCount()
    {
        return count;
    }

    public void setCount(int count)
    {
        this.count = count;
    }

    public String getProduct_id()
    {
        return product_id;
    }

    public void setProduct_id(String product_id)
    {
        this.product_id = product_id;
    }

    public String getCve_id()
    {
        return cve_id;
    }

    public void setCve_id(String cve_id)
    {
        this.cve_id = cve_id;
    }

    public String getVulnerability_type()
    {
        return vulnerability_type;
    }

    public void setVulnerability_type(String vulnerability_type)
    {
        this.vulnerability_type = vulnerability_type;
    }

    public String getPublish_date()
    {
        return publish_date;
    }

    public void setPublish_date(String publish_date)
    {
        this.publish_date = publish_date;
    }

    public String getUpdate_date()
    {
        return update_date;
    }

    public void setUpdate_date(String update_date)
    {
        this.update_date = update_date;
    }

    public String getVulnerability_score()
    {
        return vulnerability_score;
    }

    public void setVulnerability_score(String vulnerability_score)
    {
        this.vulnerability_score = vulnerability_score;
    }

    public String getVulnerability_description()
    {
        return vulnerability_description;
    }

    public void setVulnerability_description(String vulnerability_description)
    {
        this.vulnerability_description = vulnerability_description;
    }

    public String getCve_vector()
    {
        return cve_vector;
    }

    public void setCve_vector(String cve_vector)
    {
        this.cve_vector = cve_vector;
    }

    private String product_id;
    private String cve_id;
    private String vulnerability_type;
    private String publish_date;
    private String update_date;
    private String vulnerability_score;
    private String vulnerability_description;
    private String cve_vector;
    private int count;
}
