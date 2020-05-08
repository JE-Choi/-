
package com.exe.dao;

import com.exe.dto.ListDTO;
import com.exe.dto.UserDTO;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

public class UserDAO
{

    private SqlSessionTemplate sessionTemplate;
    
    public void setSessionTemplate(SqlSessionTemplate sessionTemplate)
        throws Exception
    {
        this.sessionTemplate = sessionTemplate;
    }

    public void insertUser(UserDTO dto)
    {
        sessionTemplate.insert("sourcemapper.insertUser", dto);
    }

    public UserDTO getReadUserData(String userId)
    {
        UserDTO dto = (UserDTO)sessionTemplate.selectOne("sourcemapper.getReadUserData", userId);
        return dto;
    }

    public void updateUserData(UserDTO dto)
    {
        sessionTemplate.update("sourcemapper.updateUserData", dto);
    }

    public List<ListDTO> getUserListData()
    {
        List<ListDTO>  list = sessionTemplate.selectList("sourcemapper.getUserListData");
        return list;
    }

    public void deleteUserData(String userId)
    {
        sessionTemplate.delete("sourcemapper.deleteUserData", userId);
    }

}
