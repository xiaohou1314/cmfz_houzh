package com.baizhi.controller;

import com.baizhi.entity.Article;
import com.baizhi.service.ArticleService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("article")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @RequestMapping("selectAll")
    public Map<String,Object> selectAll(Integer page,Integer rows){
        return articleService.selectAll(page,rows);
    }

    @RequestMapping("add")
    public void add(Article article){
        articleService.add(article);
    }

    @RequestMapping("edit")
    public void edit(Article article) {
        articleService.edit(article);
    }
}
