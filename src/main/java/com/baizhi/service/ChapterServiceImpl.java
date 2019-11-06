package com.baizhi.service;

import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.annotation.RedisCache;
import com.baizhi.dao.ChapterDAO;
import com.baizhi.entity.Chapter;
import com.baizhi.entity.Star;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class ChapterServiceImpl implements ChapterService{

    @Autowired
    private ChapterDAO chapterDAO;

    @Override
    @RedisCache
    public Map<String, Object> selectAll(Integer page, Integer rows,String album_id) {
        Chapter chapter = new Chapter();
        chapter.setAlbum_id(album_id);
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Chapter> list = chapterDAO.selectByRowBounds(chapter, rowBounds);
        int count = chapterDAO.selectCount(chapter);
        Map<String, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    @ClearRedisCache
    public String add(Chapter chapter) {
        chapter.setId(UUID.randomUUID().toString());
        chapter.setCreate_date(new Date());
        int i = chapterDAO.insertSelective(chapter);
        if (i==0){
            throw new RuntimeException("添加章节失败");
        }
        return chapter.getId();
    }

    @Override
    @ClearRedisCache
    public void edit(Chapter chapter) {
        int i = chapterDAO.updateByPrimaryKeySelective(chapter);
        if (i==0){
            throw new RuntimeException("修改章节失败");
        }
    }
}
