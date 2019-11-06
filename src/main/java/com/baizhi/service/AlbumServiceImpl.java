package com.baizhi.service;

import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.annotation.RedisCache;
import com.baizhi.dao.AlbumDAO;
import com.baizhi.dao.StarDAO;
import com.baizhi.entity.Album;
import com.baizhi.entity.Star;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class AlbumServiceImpl implements AlbumService{

    @Autowired
    private AlbumDAO albumDAO;
    @Autowired
    private StarDAO starDAO;

    @Override
    @RedisCache
    public Map<String, Object> selectAll(Integer page, Integer rows) {
        Album album = new Album();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Album> list = albumDAO.selectByRowBounds(album, rowBounds);
        for (Album a : list){
            Star star = starDAO.selectByPrimaryKey(a.getStar_id());
            a.setStar(star);
        }
        int count = albumDAO.selectCount(album);
        Map<String, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    @ClearRedisCache
    public String add(Album album) {
        album.setId(UUID.randomUUID().toString());
        album.setCount(0);
        int i = albumDAO.insertSelective(album);
        if (i==0){
            throw new RuntimeException("添加失败");
        }
        return album.getId();
    }

    @Override
    @ClearRedisCache
    public void edit(Album album) {
        if ("".equals(album.getCover())){
            album.setCover(null);
        }
        try{
            albumDAO.updateByPrimaryKeySelective(album);
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException("修改失败");
        }
    }

    @Override
    public Album selectOne(String id) {
        Album album = albumDAO.selectByPrimaryKey(id);
        return album;
    }
}
