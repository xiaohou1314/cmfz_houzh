package com.baizhi.service;

import com.baizhi.annotation.ClearRedisCache;
import com.baizhi.annotation.RedisCache;
import com.baizhi.dao.BannerDAO;
import com.baizhi.entity.Banner;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Service
@Transactional
public class BannerServiceImpl implements BannerService{

    @Autowired
    private BannerDAO bannerDAO;


    @Override
    @RedisCache
    public Map<String, Object> selectAll(Integer page, Integer rows) {
        Banner banner = new Banner();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Banner> list = bannerDAO.selectByRowBounds(banner, rowBounds);
        int count = bannerDAO.selectCount(banner);
        Map<String,Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);//总页数
        map.put("records",count);//总共有几条数据
        return map;
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    @ClearRedisCache
    public String add(Banner banner) {
        banner.setId(UUID.randomUUID().toString());
        banner.setCreate_date(new Date());
        int i = bannerDAO.insertSelective(banner);
        if (i==0){
            throw new RuntimeException("添加失败");
        }
        return banner.getId();
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    @ClearRedisCache
    public void edit(Banner banner) {
        if ("".equals(banner.getCover())){
            banner.setCover(null);
        }
        try{
            bannerDAO.updateByPrimaryKeySelective(banner);
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException("修改失败");
        }
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    @ClearRedisCache
    public void del(String id, HttpServletRequest request) {
        Banner banner = bannerDAO.selectByPrimaryKey(id);
        int i = bannerDAO.deleteByPrimaryKey(id);
        if (i==0){
            throw new RuntimeException("删除失败");
        }else{
            String cover = banner.getCover();
            File file = new File(request.getServletContext().getRealPath("/main/img"),cover);
            boolean b = file.delete();
            if (b == false){
                throw new RuntimeException("删除图片失败");
            }
        }
    }
}
