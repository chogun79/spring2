package kr.bit.service;

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
public class BoardServiceTest {
	@Autowired
	BoardService boardService;
		
	//3.Junit테스트를 위한 Service 요청 및 결과 나오는지 확인(데이터 가져오기)
	@Test
	public void testGetList() {

		//List<Board> list =boardService.getList();
//		for(Board vo : list) {
//			//System.out.println(vo);
//		log.info(vo);
//		}
		
		// List<Board>
		boardService.getList().forEach(vo->log.info(vo)); // 람다식
		//.forEach는 boardService.getList() 값 중 하나를 vo로 받아서 꺼내고(람다식) Log를 찍어준다.
	}
}

