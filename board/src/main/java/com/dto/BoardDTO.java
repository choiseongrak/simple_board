package com.dto;

import lombok.*;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@Alias("BoardDTO")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class BoardDTO {
    private String board_id_seq;
    private int board_no_seq;
    private String board_group;
    private String board_re_lev;
    private String board_writer;
    private String board_subject;
    private String board_content;
    private int board_hits;
    private Date reg_date;
    private String user_id;
}
