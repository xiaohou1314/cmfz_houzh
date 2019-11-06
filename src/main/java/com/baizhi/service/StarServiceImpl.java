package com.baizhi.service;

import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.annotation.RedisCache;
import com.baizhi.dao.StarDAO;
import com.baizhi.entity.Star;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class StarServiceImpl implements StarService{

    @Autowired
    private StarDAO starDAO;

    @Override
    @RedisCache
    public Map<String,Object> selectAll(Integer page,Integer rows) {
        Star star = new Star();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Star> list = starDAO.selectByRowBounds(star, rowBounds);
        int count = starDAO.selectCount(star);
        Map<String, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    @ClearRedisCache
    public String add(Star star) {
        star.setId(UUID.randomUUID().toString());
        star.setBir(new Date());
        int i = starDAO.insertSelective(star);
        if (i==0){
            throw new RuntimeException("添加失败");
        }
        return star.getId();
    }

    @Override
    @ClearRedisCache
    public void edit(Star star){
        if ("".equals(star.getPhoto())){
            star.setPhoto(null);
        }
        try{
            starDAO.updateByPrimaryKeySelective(star);
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException("修改失败");
        }
    }

    @Override
    public List<Star> getAllStarForSelect() {
        List<Star> list = starDAO.selectAll();
        return list;
    }
}
