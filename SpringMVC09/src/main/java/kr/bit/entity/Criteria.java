package kr.bit.entity;

import lombok.Data;
//현재 페이지 정보
@Data
public class Criteria {
	private int page; //현재 페이지 번호
	private int perPageNum; // 한페이지에 보여줄 게시글의 수
	
	//검색기능에 필요한 변수
	private String type;
	private String keyword;
	public Criteria() {
		this.page = 1;
		this.perPageNum = 5; //10//조정가능하다.
	}
	// 현재 페이지 게시글의 시작번호
	public int getPageStart() {		// 1page	2page	3page
		return (page-1)*perPageNum; // 0~		10~		20~		: limit #{pageStart}, #{perPageNum}			
	}
	//MySQL limit : Limit 단어는 '한계', '한도'라는 단어 뜻을 갖고있다. MySQL데이터베이스 Select문장에서 Limit키워드를 사용하면
	//테이블 데이터 조회 시 한계를 지정할 수 있다.
	//예를 들어, 테이블에서 10개의 데이터만 가져오는 SELECT문장을 만들기 위해서는 아래처럼 사용하면 된다.
	// --  행데이터 10개만 조회하기
	//SELECT TITLE, CONTENT, WRITER FROM BOARD LIMIT 10;
	//그리고 Offset 옵션을 이요하면, 가져오고자 하는 행데이터의 시작 지점을 지정할 수 있다.
	//아래 쿼리를 실행하면 테이블의 11행부터 20행까지의 데이터를 가져온다
	// -- 11번째 ~ 20번째 행 데이터 조회
	//SELECT TITLE, CONTENT, WRITER FROM BOARD LIMIT 10,10;
	//Offset 값은 0부터 시작하므로 첫 번째 행 데이터를 가리키는 값은 0이다.
	
}
