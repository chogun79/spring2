package kr.bit.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.entity.Board;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardMapperTest {

	@Autowired
	BoardMapper boardMapper;
	
	//2.Junit테스트를 위한 쿼리 정상 요청 및 결과 나오는지 확인(데이터 가져오기)
	@Test
	public void testInsert() {
		Board vo = new Board();
		vo.setMemID("bit03");
		vo.setTitle("C");
		vo.setContent("새로작성한 글");
		vo.setWriter("홍길동");
		//boardMapper.insert(vo);
		boardMapper.insertSelectKey(vo);  
		            
		log.info(vo);
	}
	/*
	public void testGetList() {
		List<Board> list= boardMapper.getList();
		for(Board vo : list) {
			//System.out.println(vo);
			log.info(vo);
		}
	} */

	
}
