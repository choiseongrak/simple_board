package com.service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    MemberDAO dao;

    public int userJoin(MemberDTO member) {
        return dao.userJoin(member);
    }

    public int userLogin(MemberDTO member) {
        return dao.userLogin(member);
    }
}
