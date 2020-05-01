package com.hhit.service;

import com.hhit.dao.DianZanDaoMapper;
import com.hhit.entity.DianZan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 15:25 2020/4/23
 * @Modified By:
 */
@Service("dianZanService")
public class DianZanServiceImpl implements DianZanService {

    @Autowired
    private DianZanDaoMapper dianZanDaoMapper;

    @Override
    @Transactional
    public List<DianZan> findDianZanArticle(String userId) {

        return dianZanDaoMapper.findDianZanArticle(userId);
    }

    @Override
    @Transactional
    public void dianzan(DianZan dian) {
        dianZanDaoMapper.dianzan(dian);
    }

    @Override
    @Transactional
    public void quXiaoZan(String articleId, String userId,String dianType) {
        dianZanDaoMapper.quXiaoZan(articleId,userId,dianType);
    }

    @Override
    public List<DianZan> findShouCangArticleIds(String id) {
        return dianZanDaoMapper.findShouCangArticleIds(id);
    }

    @Override
    public List<DianZan> checkBooleanDian(String articleId, String id) {
        return dianZanDaoMapper.checkBooleanDian(articleId,id);
    }
}
