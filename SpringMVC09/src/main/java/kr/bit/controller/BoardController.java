package kr.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.PageMaker;
import kr.bit.service.BoardService;

@Controller // POJO
@RequestMapping("/board/*")
public class BoardController{	
	//스프2탄 SpringMVC08 
	//페이징처리과련 프로젝트
	//@ModelAttribute로 바로 객체바인딩하면  model.addAttribute("","") 해주지 않아도 jsp로 값을 전달한다.
	
	@Autowired
	BoardService boardService;
	
	//Get / Post 둘다 혀용
	@RequestMapping("/list")
	public String getList( Criteria cri,Model model) {
		List<Board> list = boardService.getList(cri);
		
		// 객체바인딩
		model.addAttribute("list", list); // 객체 바인딩된 Model
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.totalCount(cri));
		model.addAttribute("pageMaker",pageMaker);
		
		return "board/list"; // View
		
	}
	
	@GetMapping("/register") // 글쓰기 폼
	public String register() {
		return "board/register";
	}

	@PostMapping("/register") // 글 등록처리   //RedirectAttributes 리다이렉트할때 컨트롤러가 가지고있는 값을 jsp한테 딱 한번만 보낼수있는 특징이 있다.
	public String register(Board vo, RedirectAttributes rttr) { // 파라메터수집(vo) <-- 한글인코딩
		boardService.register(vo); // 게시물등록(vo->idx, boardGroup)
		System.out.println("vo : "+vo); // 게시글이 등록이되면 idx값과 boardGroup 값이 자동으로 vo에 저장이 된다.
		rttr.addFlashAttribute("result", vo.getIdx());// 일회성 세션을 사용해서 값을 전달한다.   //jsp에서 ${result}으로 받는다.
		return "redirect:/board/list";
	}
	
	//web.xml에 인코딩 필터를 추가한다.
	
	//상세화면
	@GetMapping("/get")                                   
	public String get(@RequestParam("idx") int idx, Model model,@ModelAttribute("cri") Criteria cri) {
		Board vo = boardService.get(idx);
		model.addAttribute("vo",vo);
		model.addAttribute("cri",cri);
		
		return "board/get"; // /WEB-INF/views/board/get.jsp -> ${cri.page}나 ${cri.perPageNum}을 사용할 수있다.
	}
	
	//수정폼
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		Board vo = boardService.get(idx);

		
		model.addAttribute("vo",vo);
		return "board/modify"; // /WEB-INF/views/board/modify.jsp
	}
	
	//수정처리
	@PostMapping("/modify")
	public String modify(Board vo, Criteria cri, RedirectAttributes rttr) { // 파라메터수집(vo)
		boardService.modify(vo); // 수정
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		return "redirect:/board/list";
	}
	
	//삭제처리
	@GetMapping("/remove")
	public String remove(int idx, Criteria cri, RedirectAttributes rttr) {// 넘어오는 변수와 메소드의 매개변수가 같을 경우 @RequestParam("idx") 제외해도 됨
		boardService.remove(idx); // 삭제
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		return "redirect:/board/list";
	}
	
	//답글폼
	@GetMapping("/reply")
	public String reply(int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		Board vo = boardService.get(idx);
		model.addAttribute("vo",vo);
		return "board/reply"; // /WEB-INF/views/board/reply.jsp
	}
	
	//답글처리
	@PostMapping("/reply")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr) { // 파라메터수집(vo)
		boardService.replyProcess(vo); // 답글 저장됨
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());	
		return "redirect:/board/list";
	}
	
	
	
}
