package kr.bit.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import kr.bit.service.BoardServiceTest;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //서블릿 컨테이너가 새로 만들어 진다.
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"}) //Controller Junit 테스트를 위해 servlet-context.xml의 controller 스켄을 가져온다. 
public class BoardControllerTest {										   //스켄을 통해 컨트롤러가 메모리에 올라간다.
/*	
	
	java.lang.NoClassDefFoundError: javax/servlet/SessionCookieConfig
	Junit으로 테스트 케이스를 만들어 세션에 어떤 작업을 할 때, MockHttpSession 객체를 생성하게 되는데, 서블릿 버전 3.1 이하에서는 SessionCookieConfig 클래스를 찾지 못하는 오류가 발생한다.
	서블릿 jar 파일을 3.1 버전으로 업데이트 해 주면 해결된다.
	
    <!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
		<dependency>
	        <groupId>javax.servlet</groupId>
	        <artifactId>javax.servlet-api</artifactId>
	        <version>3.1.0</version>
	        <scope>provided</scope>
		</dependency>
    
*/

    
		@Autowired
		private WebApplicationContext ctx; // Spring Container 스프링 컨테이너 메모리공간을 ctx가 받는다.
		
		//톰켓서버를 구동하지 않고 임의로 가상의 서버환경을 만들어 준다.  가상의 MVC프레임워크(프론트컨트롤러, 핸들러매핑, 뷰리졸버)처럼 동작을 시켜줄수있는 객체
		private MockMvc mockMvc; // 구성은 우리가 만들어 줘야한다.
		
		@Before //@test 보다 먼저 실행된다. 
		public void setup() {
			this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();//가상 MVC동작환경을 만들어준다.
		}
		
		//4.Junit테스트를 위한 Controller 요청 및 결과 나오는지 확인(데이터 가져오기) : Controller테스트할때는 다른테스트와다르게 WebApplicationContext, MockMvc,setup() 우선 작업한다.
		@Test
		public void testList() throws Exception{
			log.info(
					mockMvc.perform(//Controller한테 실제 요청을 날려주는 메소드
										MockMvcRequestBuilders.get("/board/list"))// 요청을 만들어주고 get으로 요청을 날린다.
					.andReturn()//실행된 결과(값)를 받는다.
					.getModelAndView() 	// 객체 바인딩된 Model과 View  둘다 보여준다.
					//.getModelMap() 	// 모델과 뷰 둘중에서 모델의 값만 확인하려면 .getModelMap() 메소드를 별도로 추가 붙여준다.
					//.getViewName()   	// 모델과 뷰 둘중에서 view 값만 확인하려면 .getViewName() 메소드를 별도로 추가 붙여준다.

					);// Log.info로 출력한다.
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}
