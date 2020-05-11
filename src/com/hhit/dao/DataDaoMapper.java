package com.hhit.dao;

import com.hhit.entity.Data;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:46 2020/5/7
 * @Modified By:
 */
public interface DataDaoMapper {
    void addData(Data d);

    List<Data> findGrowsDataById(@Param("gid") String gid);

    List<Data> getGrowsChuanById(@Param("gid")String gid,@Param("cid") String cid);
}
