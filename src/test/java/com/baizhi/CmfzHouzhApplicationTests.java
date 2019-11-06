package com.baizhi;

import com.baizhi.dao.AdminDAO;
import com.baizhi.entity.Admin;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class CmfzHouzhApplicationTests {

    @Autowired
    private AdminDAO adminDAO;

    @Test
    void contextLoads() {
        List<Admin> list = adminDAO.selectAll();
        for (Admin admin : list){
            System.out.println(admin);
        }
    }

}
