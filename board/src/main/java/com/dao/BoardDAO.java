package com.dao;

import com.dto.BoardDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class BoardDAO {
    @Autowired
    SqlSessionTemplate template;

    public int boardWrite(BoardDTO boardDTO) {
        return template.insert("boardWrite", boardDTO);
    }

    public List<BoardDTO> boardList() {
        return template.selectList("boardList");
    }


    public List<BoardDTO> boardDetail(String id) {
        return template.selectList("boardDetail", id);
    }

    public int boardDelete(String id) {
        return template.delete("boardDelete", id);
    }

    public BoardDTO boardUpdateForm(String id) {
        return template.selectOne("boardUpdateForm", id);
    }

    public int boardUpdate(BoardDTO boardDTO) {
        return  template.update("boardUpdate", boardDTO);
    }

    public int replyWrite(BoardDTO boardDTO) {
        return template.insert("replyWrite", boardDTO);
    }

    public int reReplyWrite(BoardDTO boardDTO) {
        return template.insert("reReplyWrite", boardDTO);
    }

    public void boardHit(String id) {
        template.update("boardHit", id);
    }
}
