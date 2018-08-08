package env.controller;

import java.util.List;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import env.model.Board;
import env.model.PagingPgm;
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
	public String find(company company,Board board,String pageNum,String more,String find_val,Model model){
		
		//회사 목록
		TreeSet<String> ts = new TreeSet<>();
		//TreeSet<String> ts2 = new TreeSet<>();
		List<company> com_list = cs.find(find_val);
		//int com_cnt=cs.cnt(find_val);
		for(int i =0; i<com_list.size();i++) {
			company com = com_list.get(i);
			
			ts.add(com.getCom_name());
			//ts2.add(com.getCom_addr1()+" "+com.getCom_addr2()+" "+com.getCom_addr3());
		}
		model.addAttribute("com_list",ts);
//		/model.addAttribute("com_list",ts2);
		model.addAttribute("com_cnt",ts.size());
		//model.addAttribute("com_cnt",com_cnt);
		
		List files_list = fs.find(find_val);
		//int files_cnt=fs.cnt(find_val);
		
		model.addAttribute("files_list",files_list);
		model.addAttribute("files_cnt",files_list.size());
		//model.addAttribute("files_cnt",files_cnt);
		
		List notice_list = ns.find(find_val);
		int notice_cnt=ns.cnt(find_val);
		
		model.addAttribute("notice_list",notice_list);
		model.addAttribute("notice_cnt",notice_list.size());
		//model.addAttribute("notice_cnt",notice_cnt);
		
		List ad_list = as.find(find_val);
		int ad_cnt=as.cnt(find_val);
		
		model.addAttribute("ad_list",ad_list);
		model.addAttribute("ad_cnt",ad_list.size());
		//model.addAttribute("ad_cnt",ad_cnt);
		
		List know_list = ks.find(find_val);
		int know_cnt= ks.cnt(find_val);
		
		model.addAttribute("know_list",know_list);
		model.addAttribute("know_cnt",know_list.size());
		//model.addAttribute("know_cnt",know_cnt);
		
		List q_list = bs.find(find_val);
		int q_cnt=bs.cnt(find_val);
		
		model.addAttribute("q_list",q_list);
		model.addAttribute("q_cnt",q_list.size());
		//model.addAttribute("q_cnt",q_cnt);
		
		model.addAttribute("find_val",find_val);
		String findpage= "/find/find";
		
		
		//더보기를 눌렀을 때 
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		if (more == null || more.equals("")) {
			
		}else{
			final int rowPerPage = 10;
			int currentp = Integer.parseInt(pageNum);
			int total = 0;
			if(more.equals("com")){ total=ts.size(); findpage = "/find/com_more";} 
			if(more.equals("files")){ total=files_list.size(); findpage = "/find/more";}
			if(more.equals("notice")) { total=notice_list.size(); findpage = "/find/more";}
			if(more.equals("ad")) { total=ad_list.size(); findpage = "/find/more";}
			if(more.equals("news")) { total=know_list.size(); findpage = "/find/more";}
			if(more.equals("question")) { total=q_list.size(); findpage = "/find/more";}
			int startrow = (currentp - 1)*rowPerPage +1;
			int endrow = startrow + rowPerPage - 1;
			PagingPgm pp= new PagingPgm(total, rowPerPage, currentp);
			board.setStartRow(startrow);
			board.setEndRow(endrow);
			company.setStartRow(startrow);
			company.setEndRow(endrow);
			company.setCom_name(find_val);
			int no = total - startrow + 1;
			if(more.equals("com")){List<company> list1 = cs.list(company);model.addAttribute("list1",list1);} 
			if(more.equals("files")){List<Board> list2 = fs.list(board);model.addAttribute("list2",list2);}
			if(more.equals("notice")){List<Board> list3 = ns.list(board);model.addAttribute("list3",list3);}
			if(more.equals("ad")){List<Board> list4 = as.list_com(board);model.addAttribute("list4",list4);}
			if(more.equals("news")){List<Board> list5 = ks.list_news(board);model.addAttribute("list5",list5);}
			if(more.equals("question")){List<Board> list6 = bs.list(board);model.addAttribute("list6",list6);}

			model.addAttribute("no",no);
			model.addAttribute("pp",pp);
			
		}
		//통합검색 page
		return findpage;
	}
}