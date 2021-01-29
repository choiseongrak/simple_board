package com.dao;

import com.dto.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {

    @Autowired
    SqlSessionTemplate template;

    public int userJoin(MemberDTO member) {
        return template.insert("userJoin", member);
    }

    public int userLogin(MemberDTO member) {
        return template.selectOne("userLogin", member);
    }
}
