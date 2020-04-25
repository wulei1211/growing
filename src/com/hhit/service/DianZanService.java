package com.hhit.service;

import com.hhit.entity.DianZan;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 15:25 2020/4/23
 * @Modified By:
 */
public interface DianZanService {
    public List<DianZan> findDianZanArticle(String userId);

    public void dianzan(DianZan dian);

    public void quXiaoZan(String articleId, String userId,String dianType);
}
