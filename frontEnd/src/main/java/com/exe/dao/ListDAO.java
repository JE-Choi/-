package com.exe.dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;

import com.exe.dto.ListDTO;

public class ListDAO
{
	private SqlSessionTemplate sessionTemplate;
	
    public void setSessionTemplate(SqlSessionTemplate sessionTemplate)
        throws Exception
    {
        this.sessionTemplate = sessionTemplate;
    }

    public List<ListDTO> getUserListData()
    {
        List<ListDTO> list = 
        		sessionTemplate.selectList("sourcemapper.getListData");
     
        return list;
    }

}
