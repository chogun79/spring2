package kr.bit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Member;

@Mapper //- Mybatis API
public interface BoardMapper {	 

	public List<Board> getList(Criteria cri);	//게시판 목록 Get
	
	public void insertSelectKey(Board vo);//글 등록처리 /select key가 적용된 등록 - JUnit Test공용
	
	public Member login(Member vo);	// 로그인 처리
	
	public Board read(int idx); 	// 글 상세화면 / 수정폼 공통
	
	public void update(Board vo); 	// 수정 처리
	
	public void delete(int idx); 	// 삭제 처리
	
	public void replySeqUpdate(Board parent); 	// 부모글의 BoardSequence보다 큰 BoardSequence 들은 모두 +1 해주는메소드
	
	public void replyInsert(Board vo); // 작성한 답글 저장하기
	
	
	public int totalCount(Criteria cri); // 총 게시글 수 가져오기
	
	

	public void insert(Board vo);//등록 Post - JUnit Test
	public void register(Board vo);//글 등록하기
	
/*	public List<Board> getLists();
     public void boardInsert(Board vo); 
     public Board boardContent(int idx);
     
     public void boardDelete(int idx);
     
     public void boardUpdate(Board vo);
     
     @Update("update myboard set count=count+1 where idx=#{idx}")
     public void boardCount(int idx);
*/	 
   
}