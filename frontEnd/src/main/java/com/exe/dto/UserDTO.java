// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   UserDTO.java

package com.exe.dto;


public class UserDTO
{

    public UserDTO()
    {
    }

    public String getUser_id()
    {
        return user_id;
    }

    public void setUser_id(String user_id)
    {
        this.user_id = user_id;
    }

    public String getUser_password()
    {
        return user_password;
    }

    public void setUser_password(String user_password)
    {
        this.user_password = user_password;
    }

    public String getUser_name()
    {
        return user_name;
    }

    public void setUser_name(String user_name)
    {
        this.user_name = user_name;
    }

    public String getUser_phonenumber()
    {
        return user_phonenumber;
    }

    public void setUser_phonenumber(String user_phonenumber)
    {
        this.user_phonenumber = user_phonenumber;
    }

    public String getUser_email()
    {
        return user_email;
    }

    public void setUser_email(String user_email)
    {
        this.user_email = user_email;
    }

    private String user_id;
    private String user_password;
    private String user_name;
    private String user_phonenumber;
    private String user_email;
}
