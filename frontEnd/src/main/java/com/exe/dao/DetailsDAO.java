
package com.exe.dao;

import com.exe.dto.DetailsDTO;
import com.exe.dto.FinalDTO;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;

public class DetailsDAO
{

    private SqlSessionTemplate sessionTemplate;

    public void setSessionTemplate(SqlSessionTemplate sessionTemplate)
        throws Exception
    {
        this.sessionTemplate = sessionTemplate;
    }

    public List<DetailsDTO> getDetailsData(String product_id)
    {
        List<DetailsDTO> list = sessionTemplate.selectList("sourcemapper.getDetails2", product_id);
        return list;
    }

    public DetailsDTO getFinalDetails(String cve_id)
    {
        DetailsDTO dto = (DetailsDTO)sessionTemplate.selectOne("sourcemapper.getDetails", cve_id);
        return dto;
    }

    public List<FinalDTO> getReference(String cve_id)
    {
        List<FinalDTO> list = sessionTemplate.selectList("sourcemapper.getReference", cve_id);
        return list;
    }

    public List<DetailsDTO> getBarGraph(String product_id)
    {
        List<DetailsDTO> list = sessionTemplate.selectList("sourcemapper.getBarGraph", product_id);
        return list;
    }

    public int[] getDonutGraph(String product_id)
    {
        int count[] = new int[3];
        count[0] = ((Integer)sessionTemplate.selectOne("sourcemapper.getHigh", product_id)).intValue();
        count[1] = ((Integer)sessionTemplate.selectOne("sourcemapper.getMedium", product_id)).intValue();
        count[2] = ((Integer)sessionTemplate.selectOne("sourcemapper.getLow", product_id)).intValue();
        return count;
    }

}
