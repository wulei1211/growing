package com.hhit.dao;

import com.hhit.entity.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 14:26 2020/4/22
 * @Modified By:
 */
public interface ArticleDaoMapper {
    public void articleAdd(Article article);

    public List<Article> findAllArticle(@Param("articleTitle") String articleTitle,@Param("page")Integer page);

    public Integer getArticlePinglunCount(String articleId);

    public Integer getArticleLoveCount(@Param("articleId") String articleId);

    public int findAllArticleCount(@Param("articleTitle") String articleTitle,@Param("userId") String userId);

    public Article findArticleById(String articleId);
}
