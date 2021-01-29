package com.service;

import com.dao.BoardDAO;
import com.dto.BoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Service
public class BoardService {

    @Autowired
    BoardDAO dao;

    public int boardWrite(BoardDTO boardDTO) {
        return dao.boardWrite(boardDTO);
    }

    public List<BoardDTO> boardList() {
        return dao.boardList();
    }

    @Transactional
    public List<BoardDTO> boardDetail(String id, String sessinoId) throws Exception {
        if(!id.equals(sessinoId)){
            dao.boardHit(id);
        }
        return dao.boardDetail(id);
    }

    public int boardDelete(String id) {
        return dao.boardDelete(id);
    }

    public BoardDTO boardUpdateForm(String id) {
        return dao.boardUpdateForm(id);
    }

    public int boardUpdate(BoardDTO boardDTO) {
        return dao.boardUpdate(boardDTO);
    }

    public int replyWrite(BoardDTO boardDTO) {
        return dao.replyWrite(boardDTO);
    }

    public int reReplyWrite(BoardDTO boardDTO) {
        return dao.reReplyWrite(boardDTO);
    }
}
