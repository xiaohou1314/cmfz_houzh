package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @RequestMapping("login")
    public Map<String,Object> login(Admin admin, String inputCode, HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        try {
            adminService.login(admin,inputCode,request);
            map.put("status",true);
        } catch (Exception e) {
            map.put("status",false);
            map.put("message",e.getMessage());
        }
        return map;
    }

    @RequestMapping("exit")
    public void exit(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("loginAdmin");
    }
}
