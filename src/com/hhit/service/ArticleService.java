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

    public List<Article> findAllArticle(String articleTitle,String guanzhu,String articleType,String master,String shouCang,Integer page);

    public int findAllArticleCount(String articleTitle,String guanzhu,String articleType,String master,String shouCang,String userId);

    public Article findArticleById(String articleId);

    public void addLiuLanCount(int articleCount,String articleId);

    public void deleteArticleById(String articleId);

    public void updateArticleById(Article article);

    public List<Article> getAllArticles(Article article);

    public int getAllArticlesCount(Article article);

//    public int findAllShouCangCount(String userId);
}
