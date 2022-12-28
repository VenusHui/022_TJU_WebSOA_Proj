package com.ticket.sharingsystem.controller;

import com.ticket.sharingsystem.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Objects;

import static java.lang.Integer.parseInt;

@RestController
/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/28 16:27
 * @version: 1.0
 */
public class CommentController {

    @Autowired
    CommentService commentService;

    @GetMapping("/sharings/{sharingId}/comments/")
    /**
     * @param sharingId:
     * @param filter: 筛选标准
     *              all: 所有评论
     *              user: 该用户的所有评论
     * @param id: 用户 id
     * @return: ResponseEntity<Object>
     * @author: VenusHui
     * @description: 根据 filter 获取评论
     * @date: 2022/12/28 17:48
     */
    public ResponseEntity<Object> getComments(@PathVariable String sharingId,
                                              @RequestParam(value = "filter", defaultValue = "all") String filter,
                                              @RequestParam(value = "id", defaultValue = "0") Integer id) {
        if (Objects.equals(filter, "all")) {
            return ResponseEntity.ok(commentService.getAll(sharingId));
        }
        else if (Objects.equals(filter, "user")) {
            return ResponseEntity.ok(commentService.getCommentsByUserId(sharingId, id));
        }
        return ResponseEntity.badRequest().body("请求参数有误");
    }

    @PostMapping("/sharings/{sharingId}/comments/")
    /**
     * @param sharingId:
     * @param form:
     *            Integer user_id
     *            String context
     * @return: ResponseEntity<Object>
     * @author: VenusHui
     * @description: 向 id 为 sharingId 的分享中添加评论
     * @date: 2022/12/28 17:49
     */
    public ResponseEntity<Object> addComment(@PathVariable String sharingId,
                                             @RequestParam Map<String, Object> form) {
        Integer userId = parseInt(form.get("user_id").toString());
        String context = form.get("context").toString();
        return ResponseEntity.ok(commentService.addComment(sharingId, userId, context));
    }
}
