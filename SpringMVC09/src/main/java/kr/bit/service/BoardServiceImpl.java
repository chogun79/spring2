package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Member;
import kr.bit.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	
	// 게시판 목록
	@Override
	public List<Board> getList(Criteria cri) {
		List<Board> list = boardMapper.getList(cri);
		return list;
	}

	// 로그인 처리
	@Override
	public Member login(Member vo) {
		Member mvo = boardMapper.login(vo);
		return mvo;
	}

	// 글 등록 처리
	@Override
	public void register(Board vo) {
		boardMapper.insertSelectKey(vo);
		
	}

	// 글 상세화면 / 수정폼 공통
	@Override
	public Board get(int idx) {
		Board vo = boardMapper.read(idx);
		return vo;
	}

	// 글 수정 처리
	@Override
	public void modify(Board vo) {
		boardMapper.update(vo);
	}

	// 글 삭제 처리
	@Override
	public void remove(int idx) {
		boardMapper.delete(idx);
	}

	@Override
	public void replyProcess(Board vo) {
		// - 답글만들기
		// 1. 부모글(원글)의 정보를 가져오기 (vo -> idx)
		 Board parent = boardMapper.read(vo.getIdx());
		 // 2. 부모글의 boardGroup의 값을->답글(vo)정보에 저장하기
		 vo.setBoardGroup(parent.getBoardGroup());
		 // 3. 부모글의 boardSequence의 값에 1을 더해서 -> 답글(vo)정보에 저장하기
		 vo.setBoardSequence(parent.getBoardSequence()+1);
		 // 4. 부모글의 boardlevel의 값에 1을 더해서 -> 답글(vo)정보에 저장하기
		 vo.setBoardLevel(parent.getBoardLevel()+1);
		 // 5. 같은 boardGroup에 있는 글 중에서 부모글의 boardSequence보다 큰 boardSequence값들을 모두 1Tlr 업데이트 하기
		 boardMapper.replySeqUpdate(parent);
		 // 6. 답글(vo)을 저장하기
		 boardMapper.replyInsert(vo);
		
	}

	@Override
	public int totalCount(Criteria cri) {
		return boardMapper.totalCount(cri);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
