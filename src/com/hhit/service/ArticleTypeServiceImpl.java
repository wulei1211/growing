package com.hhit.service;

import com.hhit.dao.ArticleTypeDaoMapper;
import com.hhit.entity.ArticleType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:27 2020/4/27
 * @Modified By:
 */
@Service("articleTypeService")
public class ArticleTypeServiceImpl implements  ArticleTypeService {
    @Autowired
    private ArticleTypeDaoMapper articleTypeDaoMapper;

    @Override
    public List<ArticleType> findAllArticleType() {
        return articleTypeDaoMapper.findAllArticleType();
    }
}
