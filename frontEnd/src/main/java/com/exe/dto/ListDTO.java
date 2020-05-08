// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ListDTO.java

package com.exe.dto;


public class ListDTO
{

    public ListDTO()
    {
    }

    public int getVulnerability_number()
    {
        return vulnerability_number;
    }

    public void setVulnerability_number(int vulnerability_number)
    {
        this.vulnerability_number = vulnerability_number;
    }

    public String getProduct_id()
    {
        return product_id;
    }

    public void setProduct_id(String product_id)
    {
        this.product_id = product_id;
    }

    public String getProduct_name()
    {
        return product_name;
    }

    public void setProduct_name(String product_name)
    {
        this.product_name = product_name;
    }

    private String product_id;
    private String product_name;
    private int vulnerability_number;
}
