package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("album")
public class AlbumController {

    @Autowired
    private AlbumService albumService;

    @RequestMapping("selectAll")
    public Map<String,Object> selectAll(Integer page,Integer rows){
        Map<String, Object> map = albumService.selectAll(page, rows);
        return map;
    }

    @RequestMapping("edit")
    public Map<String,Object> edit(String oper, Album album, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        try{
            if ("add".equals(oper)){
                String id = albumService.add(album);
                map.put("message",id);
            }
            map.put("status",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("status",false);
            map.put("message",e.getMessage());
        }
        return map;
    }

    @RequestMapping("upload")
    public Map<String,Object> upload(MultipartFile cover, String id, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        try{
            //文件上传
            cover.transferTo(new File(request.getServletContext().getRealPath("/main/album_img"),cover.getOriginalFilename()));
            //修改album对象中cover属性
            Album album = new Album();
            album.setId(id);
            album.setCover(cover.getOriginalFilename());
            albumService.edit(album);
            map.put("status",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("status",false);
        }
        return map;
    }
}
