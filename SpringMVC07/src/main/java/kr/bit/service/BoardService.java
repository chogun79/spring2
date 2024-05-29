package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;
import kr.bit.entity.Member;

public interface BoardService {

	public List<Board> getList();		// 게시판 목록
	public Member login(Member vo); 	// 로그인
	public void register(Board vo); 	// 글 등록 처리
	public Board get(int idx); 			// 글 상세(상세화면/수정폼 공통)
	public void modify(Board vo); 		// 글 수정 처리
	public void remove(int idx);  		// 글 삭제 처리
	public void replyProcess(Board vo); // 답글등록 처리
	
}
