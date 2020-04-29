package com.hhit.dao;

import com.hhit.entity.ArticleType;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:29 2020/4/27
 * @Modified By:
 */
public interface ArticleTypeDaoMapper {
    public List<ArticleType> findAllArticleType();
}
