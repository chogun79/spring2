package kr.bit.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.bit.entity.Member;
import kr.bit.service.BoardService;

@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@Autowired
	BoardService boardService;
	
	// 로그인 처리
	@RequestMapping("/loginProcess")
	public String loginProcess(Member vo, HttpSession session) {

		Member mvo = boardService.login(vo);

		if(mvo != null) {//로그인 성공 하면 세션을 만들어준다.
			session.setAttribute("mvo", mvo); // 객체바인딩 -> ${!empty mvo} //jsp에서 이렇게 확인한다.
		}

		return "redirect:/board/list";
	}
	
	// 로그아웃 처리
	@RequestMapping("/logoutProcess")
	public String logoutProcess(HttpSession session) {
		session.invalidate(); // 세션 무효화(로그아웃)
		return "redirect:/board/list";
	}
}
