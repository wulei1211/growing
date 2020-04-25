package com.hhit.dao;

import com.hhit.entity.DianZan;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 15:31 2020/4/23
 * @Modified By:
 */
public interface DianZanDaoMapper {
    public List<DianZan> findDianZanArticle(@Param("userId") String userId);

    public void dianzan(DianZan dianZan);

    public void quXiaoZan(@Param("articleId") String articleId, @Param("userId") String userId,@Param("dianType") String dianType);
}
