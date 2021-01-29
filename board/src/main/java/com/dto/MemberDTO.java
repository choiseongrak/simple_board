package com.dto;

import lombok.*;
import org.apache.ibatis.type.Alias;

@Alias("MemberDTO")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MemberDTO {
    private String user_id;
    private String user_password;
    private String user_name;
}
