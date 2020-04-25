package com.hhit.service;

import com.hhit.entity.Article;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 14:22 2020/4/22
 * @Modified By:
 */
public interface ArticleService {
    public void articleAdd(Article article);

    public List<Article> findAllArticle(String articleTitle,Integer page);

    public int findAllArticleCount(String articleTitle,String userId);

    public Article findArticleById(String articleId);
}
