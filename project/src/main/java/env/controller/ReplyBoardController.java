package env.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import env.model.Board;
import env.model.ReplyBoard;
import env.model.company;
import env.model.joinBean;
import env.service.Board_adService;
import env.service.Board_filesService;
import env.service.Board_knowService;
import env.service.Board_noticeService;
import env.service.Board_questionService;
import env.service.Mainservice;
import env.service.ReplyBoardServiceImpl;
import env.service.joinservice;

@Controller
public class ReplyBoardController {
	@Autowired
	private ReplyBoardServiceImpl rbs;
	@Autowired
	private joinservice js;
	
	
	//찾기
	@Autowired
	private Board_questionService bs;
	@Autowired
	private Board_noticeService ns;
	@Autowired
	private Board_filesService fs;
	@Autowired
	private Board_adService as;
	@Autowired
	private Board_knowService ks;
	@Autowired
	private Mainservice cs;	
	

	@RequestMapping("/question_slist.env")
	public String slist(@RequestParam("num") int num, Model model) {
		Board board = bs.select(num);
		List<ReplyBoard> slist = rbs.list(num); //댓글 목록 
		model.addAttribute("slist", slist);
		model.addAttribute("board", board);
		return "board/question/slist"; 
	}

	@RequestMapping("question_sInsert.env")
	public String sInsert(@ModelAttribute ReplyBoard rb,HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		rb.setReplyer(id);
		
		rbs.insert(rb);
		return "redirect:question_slist.env?num="+rb.getBno();
	}

	@RequestMapping("question_repDelete.env")
	public String delete(ReplyBoard rb, Model model) {
		rbs.delete(rb.getRno());
		return "redirect:question_slist.env?num=" + rb.getBno();
	}

	@RequestMapping("question_repUpdate.env")
	public String repUpdate(ReplyBoard rb, Model model) {
		rbs.update(rb);
		return "redirect:question_slist.env?num=" + rb.getBno();
	}
	
	@RequestMapping("/question_replyForm.env")
	public String question_replyForm(String id,String pageNum,int num,Model model,HttpSession session) throws Exception{
		String user = (String)session.getAttribute("id");
		joinBean jb = js.userCheck(user);

		int ref = 0, re_level = 0, re_step = 0;
		
		Board board = bs.select(num);
		ref = board.getRef();
		re_level = board.getRe_level();
		re_step = board.getRe_step();

		model.addAttribute("ref", ref);
		model.addAttribute("re_level", re_level);
		model.addAttribute("re_step", re_step);
		model.addAttribute("jb",jb);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/question/question_replyForm";
	}
	
/*	@RequestMapping("/question_reply.env")
	public String question_reply(String id,String pageNum,int num,Model model){

		bs.selectUpdate(num);
		Board board = bs.select(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/question/question_reply";
	}*/
	
	@RequestMapping("/find.env")
	public String find(String find_val,Model model){
		List com_list = cs.find(find_val);
		int com_cnt=cs.cnt(find_val);
		
		model.addAttribute("com_list",com_list);
		model.addAttribute("com_cnt",com_cnt);
		
		List files_list = fs.find(find_val);
		int files_cnt=fs.cnt(find_val);
		
		model.addAttribute("files_list",files_list);
		model.addAttribute("files_cnt",files_cnt);
		
		List notice_list = ns.find(find_val);
		int notice_cnt=ns.cnt(find_val);
		
		model.addAttribute("notice_list",notice_list);
		model.addAttribute("notice_cnt",notice_cnt);
		
		List ad_list = as.find(find_val);
		int ad_cnt=as.cnt(find_val);
		
		model.addAttribute("ad_list",ad_list);
		model.addAttribute("ad_cnt",ad_cnt);
		
		List know_list = ks.find(find_val);
		int know_cnt= ks.cnt(find_val);
		
		model.addAttribute("know_list",know_list);
		model.addAttribute("know_cnt",know_cnt);
		
		List q_list = bs.find(find_val);
		int q_cnt=bs.cnt(find_val);
		
		model.addAttribute("q_list",q_list);
		model.addAttribute("q_cnt",q_cnt);
		
		
		model.addAttribute("find_val",find_val);
		return "find";
	}
}