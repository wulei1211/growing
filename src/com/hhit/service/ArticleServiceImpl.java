package com.hhit.service;

import com.hhit.dao.ArticleDaoMapper;
import com.hhit.entity.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 14:22 2020/4/22
 * @Modified By:
 */
@Service("articleService")
public class ArticleServiceImpl implements  ArticleService {

    @Autowired
    private ArticleDaoMapper articleDaoMapper;

    @Override
    @Transactional
    public void articleAdd(Article article) {
        articleDaoMapper.articleAdd(article);
    }

    @Override
    public List<Article> findAllArticle(String articleTitle,String guanzhu,String articleType,String master,String shouCang,Integer page) {
        return articleDaoMapper.findAllArticle(articleTitle,guanzhu,articleType,master,shouCang,page);
    }

    @Override
    public int findAllArticleCount(String articleTitle,String guanzhu,String articleType,String master,String shouCang,String userId) {
        return articleDaoMapper.findAllArticleCount(articleTitle,guanzhu,articleType,master,shouCang,userId);
    }

    @Override
    public Article findArticleById(String articleId) {
        return articleDaoMapper.findArticleById(articleId);
    }

    @Override
    @Transactional
    public void addLiuLanCount(int articleCount,String articleId) {
        articleDaoMapper.addLiuLanCount(articleCount,articleId);
    }

    @Override
    @Transactional
    public void deleteArticleById(String articleId) {
        articleDaoMapper.deleteArticleById(articleId);
    }

//    @Override
//    public int findAllShouCangCount(String userId) {
//        return articleDaoMapper.findAllShouCangCount(userId);
//    }
}
