package com.ticket.sharingsystem.controller;

import com.ticket.sharingsystem.service.SharingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Objects;

import static java.lang.Integer.parseInt;

@RestController
public class SharingController {

    @Autowired
    SharingService sharingService;

    @GetMapping("/sharings/")
    /**
     * @param filter: 筛选标准
     *              all: 所有分享
     *              user: 该用户的所有分享
     *              histrionics: 该演出的所有分享
     * @param id: 用户 id / 演出 id
     * @return: ResponseEntity<Object>
     * @author: VenusHui
     * @description: 根据 filter 获取分享
     * @date: 2022/12/28 16:19
     */
    public ResponseEntity<Object> getSharings(@RequestParam(value = "filter", defaultValue = "all") String filter,
                                              @RequestParam(value = "id", defaultValue = "0") Integer id) {
        if (Objects.equals(filter, "histrionics")) {
            return ResponseEntity.ok(sharingService.getSharingsByHistrionicsId(id));
        }
        else if (Objects.equals(filter, "user")) {
            return ResponseEntity.ok(sharingService.getSharingsByUserId(id));
        }
        else if (Objects.equals(filter, "all")){
            return ResponseEntity.ok(sharingService.getAll());
        }
        return ResponseEntity.badRequest().body("请求参数错误");
    }

    @PostMapping("/sharings/")
    public ResponseEntity<Object> addSharing(@RequestParam Map<String, Object> form) {
        Integer userId = parseInt(form.get("user_id").toString());
        Integer histrionicsId = parseInt(form.get("histrionics_id").toString());
        String context = form.get("context").toString();
        String imageUrl = form.get("image_url").toString();
        return ResponseEntity.ok(sharingService.addSharing(userId, histrionicsId, context, imageUrl));
    }

    @GetMapping("/sharings/{sharingId}/")
    /**
     * @param sharingId:
     * @return: ResponseEntity<Object>
     * @author: VenusHui
     * @description: 根据 id 获取分享
     * @date: 2022/12/28 15:21
     */
    public ResponseEntity<Object> getSharing(@PathVariable String sharingId) {
        return ResponseEntity.ok(sharingService.getSharing(sharingId));
    }

    @PutMapping("/sharings/{sharingId}/")
    /**
     * @param sharingId:
     * @param form:
     * @return: ResponseEntity<Object>
     * @author: VenusHui
     * @description: 修改分享信息：文本内容、图片地址、点赞数、喜欢数
     * @date: 2022/12/28 17:24
     */
    public ResponseEntity<Object> setSharing(@PathVariable String sharingId,
                                             @RequestParam Map<String, Object> form) {

        Integer stars=null;
        Integer likes=null;
        String imageUrl=null;
        String context=null;
        if(form.get("context")!=null)
            context = form.get("context").toString();
        if(form.get("stars")!=null)
            stars=parseInt(form.get("stars").toString());
        if(form.get("likes")!=null)
            likes=parseInt(form.get("likes").toString());
        if(form.get("image_url")!=null)
            imageUrl=form.get("image_url").toString();
        return ResponseEntity.ok(sharingService.setSharing(sharingId, context, imageUrl, stars, likes));
    }
}
