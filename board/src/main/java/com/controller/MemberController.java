package com.controller;

import com.common.Pagination;
import com.dto.BoardDTO;
import com.dto.MemberDTO;
import com.service.BoardService;
import com.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MemberController {
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class.getSimpleName());

    @Autowired
    MemberService memberService;

    @Autowired
    BoardService boardService;

    @PostMapping("/userJoin")
    public String userJoin(MemberDTO member) {
        logger.debug("회원가입 : {} ", member);
        int n = memberService.userJoin(member);
        String next = "";
        if(n != 0){
            next = "redirect:/";
        } else {
            next = "redirect:/userJoinForm";
        }
        return next;
    }

    @PostMapping("/userLogin")
    public String userLogin(MemberDTO member, HttpSession session) {
        logger.debug("로그인 : {} ", member);
        int n = memberService.userLogin(member);
        String next = "";
        if(n != 0) {
            member.setUser_password(null);
            session.setAttribute("loginMember",member);
            next = "redirect:/boardMain";
        } else {
            next = "redirect:/";
        }
        return next;
    }

    @GetMapping("/boardMain")
    public String boardMain(Model model, @RequestParam(required = false, defaultValue = "1") int page
            , @RequestParam(required = false, defaultValue = "1") int range) {
        List<BoardDTO> xxx = boardService.boardList();
        List<BoardDTO> list = new ArrayList<>();
        logger.debug("전체 리스트 : {}", xxx);
        for(BoardDTO dto: xxx) {
            if(dto.getBoard_id_seq().equals(dto.getBoard_group())){
                list.add(dto);
            }
        }
        logger.debug("추출 리스트 : {}", list);

        Pagination pagination = new Pagination();
        pagination.pageInfo(page, range, list.size());

        logger.debug("페이징 {}", pagination);
        if(page*10 < list.size()){
            List<BoardDTO> boardList = new ArrayList<>(list.subList(page*10-10, page*10));
            model.addAttribute("boardList", boardList);
        } else {
            List<BoardDTO> boardList = new ArrayList<>(list.subList(page*10-10, list.size()));
            model.addAttribute("boardList", boardList);
        }

        model.addAttribute("page", pagination);
        return "boardMain";
    }


}
