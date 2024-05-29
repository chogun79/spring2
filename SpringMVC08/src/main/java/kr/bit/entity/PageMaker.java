package kr.bit.entity;

import lombok.Data;

// 페이징 처리를 만드는 클래스(vo)
@Data
public class PageMaker {
	private Criteria cri;
	private int totalCount;	//총 게시글의 수  : 전체 게시글의 수에 10개씩이면 10으로 나누면 몇페이지가 나오는지 알수있다.
	private int startPage;	//시작페이지번호  : 페이지번호가 10개씩이라고하면 1.2.3.4.5.6.7.8.9.10 의 시작페이지는 1page
	private int endPage;	//끝페이지 번호(끝페이지번호는 조정이 되어야한다.)
	private boolean prev;	//이전버튼(true, false)
	private boolean next;	//다음버튼(true, false)
	private int displayPageNum=5; //10//하단에 몇개의 페이지를 보여줄것인지 : 1 2 3 4 5 6 7 8 9 10
	// 총 게시글의 수를 구하는 메서드
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePaging();
	}
	private void makePaging() {
		//1. 화면에 보여질 마지막 페이지 번호
		endPage =  (int) (Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		//2. 화면에 보여질 시작 페이지 번호
		startPage=(endPage-displayPageNum) +1;
		if(startPage <= 0) startPage = 1;
		//3. 전체 마지막 페이지 계산
		int tempEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		//4. 화면에 보여질 마지막 페이지 유효성 체크
		if(tempEndPage<endPage) {
			endPage = tempEndPage;
		}
		//5. 이전페이지 버튼(링크)존재 여부
		prev = (startPage==1) ? false : true;
		//6. 다음페이지 버튼(링크)존재 여부
		next = (endPage < tempEndPage) ? true : false;
	}
	
	
}
