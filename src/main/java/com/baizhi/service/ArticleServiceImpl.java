package com.baizhi.service;

import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.annotation.RedisCache;
import com.baizhi.dao.ArticleDAO;
import com.baizhi.entity.Article;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class ArticleServiceImpl implements ArticleService{

    @Autowired
    private ArticleDAO articleDAO;

    @Override
    @RedisCache
    public Map<String, Object> selectAll(Integer page, Integer rows) {
        Article article = new Article();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Article> list = articleDAO.selectByRowBounds(article,rowBounds);
        int count = articleDAO.selectCount(article);
        Map<String, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    @ClearRedisCache
    public void add(Article article) {
        article.setId(UUID.randomUUID().toString());
        article.setCreate_date(new Date());
        int i = articleDAO.insertSelective(article);
        if (i==0){
            throw new RuntimeException("添加文章失败");
        }
    }

    @Override
    @ClearRedisCache
    public void edit(Article article) {
        int i = articleDAO.updateByPrimaryKeySelective(article);
        if (i==0){
            throw new RuntimeException("修改文章失败");
        }
    }
}
