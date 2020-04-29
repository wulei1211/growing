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

    public List<Article> findAllArticle(@Param("articleTitle") String articleTitle,@Param("guanzhu") String guanzhu,@Param("articleType") String articleType,@Param("master") String master,@Param("shouCang") String shouCang,@Param("page") Integer page);

    public Integer getArticlePinglunCount(String articleId);

    public Integer getShouCangCount(@Param("articleId") String articleId);

    public Integer getArticleLoveCount(@Param("articleId") String articleId);

    public int findAllArticleCount(@Param("articleTitle") String articleTitle,@Param("guanzhu") String guanzhu,@Param("articleType") String articleType,@Param("master") String master,@Param("shouCang") String shouCang,@Param("userId") String userId);

    public Article findArticleById(String articleId);

    public void addLiuLanCount(@Param("articleCount") int articleCount,@Param("articleId") String articleId);

    public void deleteArticleById(@Param("articleId") String articleId);
}
