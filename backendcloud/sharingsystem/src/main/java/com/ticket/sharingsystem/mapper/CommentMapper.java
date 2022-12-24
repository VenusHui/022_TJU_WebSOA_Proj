package com.ticket.sharingsystem.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ticket.sharingsystem.pojo.Comment;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper extends BaseMapper<Comment> {
}
