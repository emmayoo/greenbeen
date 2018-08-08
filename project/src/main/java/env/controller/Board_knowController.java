package env.controller;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import env.model.Board;
import env.model.PagingPgm;
import env.model.joinBean;
import env.service.Board_knowService;
import env.service.ReplyBoardServiceImpl;
import env.service.joinservice;

@Controller
public class Board_knowController {
	@Autowired
	private ReplyBoardServiceImpl rbs;
	@Autowired
	private Board_knowService bs;
	@Autowired
	private joinservice js;
	
	private Date dt=new Date();
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	
	//오늘의 뉴스
	@RequestMapping("/know_news_view.env")
	public String know_news_view(String id,String pageNum,int num,Model model,HttpServletRequest request) throws Exception{

		//position=master인 계정만 수정&삭제 할 수 있음
		HttpSession session = request.getSession();
		String idcheck = (String)session.getAttribute("id");
		String position="none";
		if(idcheck==null) {	
		}else {
			joinBean editm = js.userCheck(idcheck);
			position = editm.getPosition();
		}
		model.addAttribute("position",position);
		
		bs.selectUpdate_news(num);
		Board board = bs.select_news(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/know/know_news_view";
	}
	
	@RequestMapping("/know_news_list.env")
	public String know_news_list(Board board,String pageNum,String id,Model model,HttpServletRequest request) throws Exception { //왜인지 모르지만 know_news_list,know_news_list 두 번 적힘
		System.out.println("id(know_news_list.env)="+id);
		int comma =0;
		try {			
			comma =id.indexOf(",");
			id = id.substring(comma+1);
		}catch(Exception e) {
			comma = 0;
			System.out.println(e.getMessage());
		}
		System.out.println("comma="+comma);
		System.out.println("know_news_list.env="+id);
		
		final int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		// int total = bs.getTotal();
		int total = bs.getTotal_news(board); // 검색
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		// List<Board> list = bs.list(startRow, endRow);
		int no = total - startRow + 1;
		List<Board> list = bs.list_news(board);
		
		//position=master인 계정만 글 쓸 수 있음
		HttpSession session = request.getSession();
		String idcheck = (String)session.getAttribute("id");
		String position="none";
		if(idcheck==null) {	
		}else {
			joinBean editm = js.userCheck(idcheck);
			position = editm.getPosition();
		}
		model.addAttribute("position",position);
		//new article
		int nacnt=0;
		for(int na=0;na<list.size();na++) {
			Board bna = list.get(na);
			if(bna.getReg_date().equals(sd.format(dt))) {
				if(bna.getDel().equals("y")) nacnt--;	
				nacnt++;
			} 
		}
		model.addAttribute("na",nacnt);
		model.addAttribute("today",sd.format(dt));
		
		
		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", board.getSearch());
		model.addAttribute("keyword", board.getKeyword());
		model.addAttribute("id",id);
		return "/board/know/know_news_list";
	}
	
	@RequestMapping("/know_news_new.env")
	public String know_news_new(String nm,String pageNum,String id,Model model){

		System.out.println("nu="+nm);
		System.out.println("know_news_new.env="+id);
		if (nm==null) {nm = null; System.out.println("dddss");}
		int num = 0, ref = 0, re_level = 0, re_step = 0;
		
		if (nm != null) {
			num = Integer.parseInt(nm);
			Board board = bs.select_news(num);
			ref = board.getRef();
			re_level = board.getRe_level();
			re_step = board.getRe_step();
		}
		
		model.addAttribute("num", num);
		model.addAttribute("ref", ref);
		model.addAttribute("re_level", re_level);
		model.addAttribute("re_step", re_step);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("id",id);
		return "/board/know/know_news_new";
	}
	@RequestMapping(value="/know_news_insert.env", method = RequestMethod.POST)
//	public @ResponseBody String know_news_insert(@RequestParam("attach1") MultipartFile mf,Board board,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
	public String know_news_insert(@RequestParam("attach1") MultipartFile mf,Board board,String pageNum,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
		System.out.println("know_news_insert.env");
		int num = board.getNum();
		int number = bs.getMaxNum_news();
		board.setRef(number);
		
		board.setNum(number);
		
		String fileName = mf.getOriginalFilename(); 
		int fileSize = (int) mf.getSize();
		
		System.out.println("name="+mf.getName()); 
		System.out.println("fileName="+fileName); 
		System.out.println("fileSize="+fileSize);
		
		String path = session.getServletContext().getRealPath("/upload");
		System.out.println("path:" + path);
		
//		InetAddress local = InetAddress.getLocalHost();
//		String ip = local.getHostAddress();
		String ip = request.getRemoteAddr();

		
		board.setIp(ip);
		board.setAttach(fileName);

		try {
			mf.transferTo(new File(path + "/" + fileName));
		}catch(Exception e) {e.printStackTrace();} //파일 안 넣으면 error 나는 데 무시하세여
		 
		int result = bs.insert_news(board);
		
		model.addAttribute("id",id);
		model.addAttribute("result",result);
		
		//return board.toString();
		return "/board/know/know";
	}
	
	@RequestMapping("/know_news_modifyForm.env")
	public String know_news_modifyForm(String id,String pageNum,int num,Model model){
		Board board = bs.select_news(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/know/know_news_modifyForm";
	}
	
	@RequestMapping(value="/know_news_modify.env", method = RequestMethod.POST)
	public String know_news_modify(@RequestParam("attach1") MultipartFile mf,String preattach,HttpServletRequest request,String id,String pageNum,Board board,Model model){
		String fileName = mf.getOriginalFilename(); 
		int fileSize = (int) mf.getSize();
		
		System.out.println("name="+mf.getName()); 
		System.out.println("fileName="+fileName); 
		System.out.println("fileSize="+fileSize);
		
		//String path = session.getServletContext().getRealPath("/upload");
		String path = request.getRealPath("/upload");
		System.out.println("path:" + path);

		String ip = request.getRemoteAddr();

		
		board.setIp(ip);
		board.setAttach(fileName);

		try {
			mf.transferTo(new File(path + "/" + fileName));
		}catch(Exception e) {e.printStackTrace();} //파일 안 넣으면 error 나는 데 무시하세여
		
		//이전에 있던 파일 없애기
		File file = new File(path);
		file.mkdirs();
		
		File[] f = file.listFiles();
		for(int i =0; i< f.length;i++) {
			if(f[i].getName().equals(preattach)) {
				System.out.println("예");
				f[i].delete();
			}
		}
		
		int result = bs.update_news(board);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:know_news_list.env";
	}
	
	@RequestMapping("/know_news_deleteForm.env")
	public String know_news_deleteForm(String id,String pageNum,int num,Model model){
		Board board = bs.select_news(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/know/know_news_deleteForm";
	}
	
	@RequestMapping(value="/know_news_delete.env", method = RequestMethod.POST)
	public String know_news_delete(String id,String pageNum,int num,Model model){
		int result = bs.delete_news(num);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:know_news_list.env";
	}
	
	//오늘의 퀴즈
	@RequestMapping("/know_quiz_view.env")
	public String know_quiz_view(String id,String pageNum,int num, Model model,HttpServletRequest request) throws Exception{

		//position=master인 계정만 수정&삭제 할 수 있음
		HttpSession session = request.getSession();
		String idcheck = (String)session.getAttribute("id");
		String position="none";
		if(idcheck==null) {	
			
		}else {
			joinBean editm = js.userCheck(idcheck);
			position = editm.getPosition();
		}
		model.addAttribute("position",position);

		bs.selectUpdate_quiz(num);
			
		if(idcheck!=null) {
		//해나
			String qdate = bs.selectQuiz_date(idcheck);
			System.out.println("qdate"+qdate);
		
		
		Board board = bs.select_quiz(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("qdate", qdate);
		}
		
		return "/board/know/know_quiz_view";
	}
	
	@RequestMapping("/know_quiz_solve.env")
	public String know_quiz_solve(RedirectAttributes rttr,String id, String point, String pageNum, int num, Model model,HttpServletRequest request) throws Exception{
		System.out.println("quiz solve env 들어옴");
		
		HttpSession session = request.getSession();
		String loginid = (String)session.getAttribute("id");
		//System.out.println(loginid);
		System.out.println("point"+point);
		
		if (point.equals("1")) {
			int result = bs.updatePoint(loginid);
			System.out.println("result"+result);
		}else 
			bs.updateQdate(loginid);
				
		//model.addAttribute("attempt",result);
		//rttr.addFlashAttribute("attempt",result);
		
		//return "redirect:/know_quiz_list.env?attempt="+result;
		
		return "redirect:/know_quiz_list.env";
	}
	
	@RequestMapping("/know_quiz_list.env")
	public String know_quiz_list(Board board,String pageNum,String id,Model model,HttpServletRequest request) throws Exception{ //왜인지 모르지만 know_list,know_list 두 번 적힘
		System.out.println("id(know_list.env)="+id);
		int comma=0;
		try {			
			comma =id.indexOf(",");
			id = id.substring(comma+1);
		}catch(Exception e) {
			comma = 0;
			System.out.println(e.getMessage());
		}
		System.out.println("comma="+comma);
		System.out.println("know_list.env="+id);
		
		final int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		// int total = bs.getTotal();
		int total = bs.getTotal_quiz(board); // 검색
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		// List<Board> list = bs.list(startRow, endRow);
		int no = total - startRow + 1;
		List<Board> list = bs.list_quiz(board);
		
		//position=master인 계정만 글 쓸 수 있음
		HttpSession session = request.getSession();
		String idcheck = (String)session.getAttribute("id");
		String position="none";
		if(idcheck==null) {	
		}else {
			joinBean editm = js.userCheck(idcheck);
			position = editm.getPosition();
		}
		model.addAttribute("position",position);
		
		//new article
		int nacnt=0;
		for(int na=0;na<list.size();na++) {
			Board bna = list.get(na);
			if(bna.getReg_date().equals(sd.format(dt))) {
				if(bna.getDel().equals("y")) nacnt--;	
				nacnt++;
			} 
		}
		model.addAttribute("na",nacnt);
		model.addAttribute("today",sd.format(dt));
		
		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		// 검색
		model.addAttribute("search", board.getSearch());
		model.addAttribute("keyword", board.getKeyword());
		model.addAttribute("id",id);
		return "/board/know/know_quiz_list";
	}
	
	@RequestMapping("/know_quiz_new.env")
	public String know_quiz_new(String nm,String pageNum,String id,Model model){

		System.out.println("nu="+nm);
		System.out.println("know_new.env="+id);
		if (nm==null) {nm = null; System.out.println("dddss");}
		int num = 0, ref = 0, re_level = 0, re_step = 0;
		
		if (nm != null) {
			num = Integer.parseInt(nm);
			Board board = bs.select_quiz(num);
			ref = board.getRef();
			re_level = board.getRe_level();
			re_step = board.getRe_step();
		}
		
		model.addAttribute("num", num);
		model.addAttribute("ref", ref);
		model.addAttribute("re_level", re_level);
		model.addAttribute("re_step", re_step);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("id",id);
		return "/board/know/know_quiz_new";
	}
	@RequestMapping(value="/know_quiz_insert.env", method = RequestMethod.POST)
//	public @ResponseBody String know_insert(@RequestParam("attach1") MultipartFile mf,Board board,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
	public String know_quiz_insert(@RequestParam("attach1") MultipartFile mf,Board board,String pageNum,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
		System.out.println("know_insert.env");
		int num = board.getNum();
		int number = bs.getMaxNum_quiz();
		board.setRef(number);
		
		board.setNum(number);
		
		String fileName = mf.getOriginalFilename(); 
		int fileSize = (int) mf.getSize();
		
		System.out.println("name="+mf.getName()); 
		System.out.println("fileName="+fileName); 
		System.out.println("fileSize="+fileSize);
		
		String path = session.getServletContext().getRealPath("/upload");
		System.out.println("path:" + path);
		
//		InetAddress local = InetAddress.getLocalHost();
//		String ip = local.getHostAddress();
		String ip = request.getRemoteAddr();

		
		board.setIp(ip);
		board.setAttach(fileName);

		try {
			mf.transferTo(new File(path + "/" + fileName));
		}catch(Exception e) {e.printStackTrace();} //파일 안 넣으면 error 나는 데 무시하세여
		 
		int result = bs.insert_quiz(board);
		
		model.addAttribute("id",id);
		model.addAttribute("result",result);
		
		//return board.toString();
		return "/board/know/know_quiz";
	}
	
	@RequestMapping("/know_quiz_modifyForm.env")
	public String know_quiz_modifyForm(String id,String pageNum,int num,Model model){
		Board board = bs.select_quiz(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/know/know_quiz_modifyForm";
	}
	
	@RequestMapping(value="/know_quiz_modify.env", method = RequestMethod.POST)
	public String know_quiz_modify(@RequestParam("attach1") MultipartFile mf,String preattach,HttpServletRequest request,String id,String pageNum,Board board,Model model){
		String fileName = mf.getOriginalFilename(); 
		int fileSize = (int) mf.getSize();
		
		System.out.println("name="+mf.getName()); 
		System.out.println("fileName="+fileName); 
		System.out.println("fileSize="+fileSize);
		
		//String path = session.getServletContext().getRealPath("/upload");
		String path = request.getRealPath("/upload");
		System.out.println("path:" + path);

		String ip = request.getRemoteAddr();

		
		board.setIp(ip);
		board.setAttach(fileName);

		try {
			mf.transferTo(new File(path + "/" + fileName));
		}catch(Exception e) {e.printStackTrace();} //파일 안 넣으면 error 나는 데 무시하세여
		
		//이전에 있던 파일 없애기
		File file = new File(path);
		file.mkdirs();
		
		File[] f = file.listFiles();
		for(int i =0; i< f.length;i++) {
			if(f[i].getName().equals(preattach)) {
				System.out.println("예");
				f[i].delete();
			}
		}
		
		int result = bs.update_quiz(board);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:know_quiz_list.env";
	}
	
	@RequestMapping("/know_quiz_deleteForm.env")
	public String know_quiz_deleteForm(String id,String pageNum,int num,Model model){
		Board board = bs.select_quiz(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/know/know_quiz_deleteForm";
	}
	
	@RequestMapping(value="/know_quiz_delete.env", method = RequestMethod.POST)
	public String know_quiz_delete(String id,String pageNum,int num,Model model){
		int result = bs.delete_quiz(num);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:know_quiz_list.env";
	}
}
