package com.controller;

import com.dto.BoardDTO;
import com.dto.MemberDTO;
import com.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class BoardController {
    private static final Logger logger = LoggerFactory.getLogger(BoardController.class.getSimpleName());

    @Autowired
    BoardService service;

    @PostMapping("boardWrite")
    public String boardWrite(BoardDTO boardDTO, HttpSession session) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("loginMember");
        boardDTO.setUser_id(memberDTO.getUser_id());
        int n = service.boardWrite(boardDTO);
        String next = "";
        if (n != 0) {
            next = "redirect:/boardMain";
        } else {
            next = "redirect:/boardWriteForm";
        }
        return next;
    }

    @GetMapping("boardDetail")
    public String boardDetail(String id, @ModelAttribute("page") String page, @ModelAttribute("range") String range
            , Model model, HttpSession session) {
        try {
            String sessionId = (String) session.getAttribute("boardId");//새로고침 시 조회수 방지
            List<BoardDTO> list = service.boardDetail(id, sessionId);
            session.setAttribute("boardId", id); //세션에 마지막에 담긴 board_id와 넘어온 id로 메소드 호출 후 세션 값 변경
            logger.debug("전체 리스트 {} ", list);
            BoardDTO boardDTO = list.get(0); //원 게시글
            list.remove(0);
            List<BoardDTO> replyList = new ArrayList<>();
            List<BoardDTO> reReplyList = new ArrayList<>();
            for(BoardDTO xxx: list) {
                if(xxx.getBoard_id_seq().equals(xxx.getBoard_re_lev())) {
                    replyList.add(xxx); //댓글
                } else {
                    reReplyList.add(xxx); //대댓글
                }
            }

            logger.debug("댓글 리스트 {}", replyList);
            logger.debug("대댓글 리스트 {} ", reReplyList);

            model.addAttribute("boardDTO", boardDTO);
            model.addAttribute("replyList", replyList);
            model.addAttribute("reReplyList", reReplyList);
            return "boardDetail";
        } catch (Exception e){
            e.printStackTrace();
            return "redirect:boardMain";
        }


    }

    @GetMapping("boardDelete")
    public String boardDelete(String id, String page, String range, RedirectAttributes rttr) {
        int n = service.boardDelete(id);
        rttr.addAttribute("page",page);
        rttr.addAttribute("range",range);
        return "redirect:/boardMain";
    }

    @GetMapping("boardUpdateForm")
    public String boardUpdateForm(String id, @ModelAttribute("page") String page, @ModelAttribute("range") String range, Model model) {
        BoardDTO boardDTO = service.boardUpdateForm(id);
        model.addAttribute("boardDTO", boardDTO);
        return "boardUpdateForm";
    }

    @PostMapping("boardUpdate")
    public String boardUpdate(BoardDTO boardDTO, String page, String range, RedirectAttributes rttr) {
        logger.debug("수정 : {} ", boardDTO);
        int n = service.boardUpdate(boardDTO);
        rttr.addAttribute("id", boardDTO.getBoard_id_seq());
        rttr.addAttribute("page", page);
        rttr.addAttribute("range", range);
        return "redirect:/boardDetail";
    }

    @ResponseBody
    @PostMapping("replyWrite")
    public void replyWrite(BoardDTO boardDTO){
        logger.debug("댓글 {}", boardDTO);
        int n = service.replyWrite(boardDTO);
    }

    @ResponseBody
    @PostMapping("reReplyWrite")
    public void reReplyWrite(BoardDTO boardDTO){
        logger.debug("댓글 {}", boardDTO);
        int n = service.reReplyWrite(boardDTO);
    }

    @GetMapping("replyDelete")
    public String replyDelete(String del_id, String id, String page, String range, RedirectAttributes rttr) {
        int n = service.boardDelete(del_id);
        rttr.addAttribute("id",id);
        rttr.addAttribute("page",page);
        rttr.addAttribute("range",range);
        return "redirect:boardDetail";
    }
}
