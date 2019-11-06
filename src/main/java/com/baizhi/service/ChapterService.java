package com.baizhi.service;

import com.baizhi.entity.Chapter;

import java.util.Map;

public interface ChapterService {

    Map<String,Object> selectAll(Integer page,Integer rows,String star_id);
    String add(Chapter chapter);
    void edit(Chapter chapter);
}
