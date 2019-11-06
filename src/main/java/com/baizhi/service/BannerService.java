package com.baizhi.service;

import com.baizhi.entity.Banner;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;


public interface BannerService {

    public Map<String,Object> selectAll(Integer page, Integer rows);
    public String add(Banner banner);
    void edit(Banner banner);
    void del(String id, HttpServletRequest request);
}
