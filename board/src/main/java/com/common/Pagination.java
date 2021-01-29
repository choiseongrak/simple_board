package com.common;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class Pagination {
    private int listSize = 10;  //초기값으로 목록개수를 10으로 셋팅
    private int rangeSize = 10; //초기값으로 페이지범위를 10으로 셋팅
    private int page; //현재 목록의 페이지 번호
    private int range; //각 페이지 범위 시작 번호
    private int listCnt; //전체 게시물 개수
    private int pageCnt; //전체 페이지 범위의 개수
    private int startPage; //각 페이지 범위 시작 번호
    private int endPage; //각 페이지 범위 끝 번호
    private int startList;// 게시판 시작 번호
    private boolean prev; //이전 페이지 여부
    private boolean next; //다음 페이지 여부

    public void pageInfo(int page, int range, int listCnt) {
        this.page = page;
        this.range = range;
        this.listCnt = listCnt;

        //전체 페이지 수
//        this.pageCnt = (int) Math.ceil(listCnt/listSize);
        if(listCnt%listSize == 0) this.pageCnt = listCnt/listSize;
        else this.pageCnt = listCnt/listSize + 1;
        //시작 페이지
        this.startPage = (range - 1) * rangeSize + 1;
        //끝 페이지
        this.endPage = range * rangeSize;
        //게시판 시작 번호
        this.startList = (page - 1) * listSize;
        //이전 버튼 상태
        this.prev = range != 1;
        //다음 버튼 상태
        this.next = endPage <= pageCnt;
        //마지막 번호가 페이지 개수보다 클 경우 마지막 번호로 세팅
        if(this.endPage > this.pageCnt) {
            this.endPage = this.pageCnt;
            this.next = false;
        }
    }
}
