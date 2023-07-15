package com.nth.service;

import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Getter
@Setter
public class Pagination {

    private static final Logger log = LoggerFactory.getLogger(Pagination.class);

    private int listSize = 5;  // 초기값으로 목록개수를 5으로 셋팅
    private int rangeSize = 5; // 초기값으로 페이지범위를 5으로 셋팅
    private int page;
    private int range;
    private int listCnt;
    private int pageCnt;
    private int startPage;
    private int startList;
    private int endPage;
    private boolean prev;
    private boolean next;

    /**
     * 페이지설정
     * @param listSize : 출력목록
     * @param rangeSize : 페이지 범위
     */
    public void pageconfig(int listSize,int rangeSize){
        this.listSize = listSize;
        this.rangeSize = rangeSize;
        log.info("페이지설정 pageconfig() 실행됨\n" +
                "------------------------------------------------------\n" +
                "설정된 페이지 값 \n" +
                "출력목록갯수 = {} 변수명:listSize\n"+
                "페이지범위 = {} 변수명:rangeSize\n"+
                "-------------------------------------------------------\n",listSize,rangeSize);
    }

    public void pageInfo(int page, int range, int listCnt) {
        this.page = page;
        this.range = range;
        this.listCnt = listCnt;

        //전체 페이지수
        this.pageCnt = (int) Math.ceil(listCnt*1.0/listSize);

        //시작 페이지
        this.startPage = (range - 1) * rangeSize + 1 ;

        //끝 페이지
        this.endPage = range * rangeSize;

        //게시판 시작번호
        this.startList = (page - 1) * listSize;

        //이전 버튼 상태
        this.prev = range == 1 ? false : true;

        //다음 버튼 상태
        this.next = endPage > pageCnt ? false : true;
        if (this.endPage > this.pageCnt) {
            this.endPage = this.pageCnt;
            this.next = false;
        }
    }


}
