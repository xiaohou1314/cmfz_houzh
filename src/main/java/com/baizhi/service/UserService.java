package com.baizhi.service;

import com.baizhi.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    Map<String,Object> selectUsersByStraId(Integer page,Integer rows,String star_id);
    Map<String,Object> selectAll(Integer page,Integer rows);
    List<User> export();
}
