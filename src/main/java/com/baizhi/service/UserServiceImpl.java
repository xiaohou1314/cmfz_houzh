package com.baizhi.service;

import com.baizhi.annotation.RedisCache;
import com.baizhi.dao.UserDAO;
import com.baizhi.entity.User;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDAO userDAO;

    @Override
    public Map<String, Object> selectUsersByStraId(Integer page, Integer rows, String star_id) {
        User user = new User();
        user.setStar_id(star_id);
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<User> list = userDAO.selectByRowBounds(user, rowBounds);
        int count = userDAO.selectCount(user);
        Map<String,Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    @RedisCache
    public Map<String, Object> selectAll(Integer page,Integer rows) {
        User user = new User();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<User> list = userDAO.selectByRowBounds(user, rowBounds);
        int count = userDAO.selectCount(user);
        Map<String,Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    public List<User> export() {
        return userDAO.selectAll();
    }
}
