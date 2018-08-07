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

import env.model.Board;
import env.model.PagingPgm;
import env.model.joinBean;
import env.service.Board_adService;
import env.service.ReplyBoardServiceImpl;
import env.service.joinservice;

@Controller
public class Board_adController {
	@Autowired
	private ReplyBoardServiceImpl rbs;
	@Autowired
	private Board_adService bs;
	@Autowired
	private joinservice js;
	

	private Date dt=new Date();
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	
	//우수회사
	@RequestMapping("/ad_best_view.env")
	public String ad_best_view(String id,String pageNum,int num,Model model,HttpServletRequest request) throws Exception{
		
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
		
		bs.selectUpdate_best(num);
		Board board = bs.select_best(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/ad/ad_best_view";
	}
	
	@RequestMapping("/ad_best_list.env")
	public String ad_best_list(Board board,String pageNum,String id,Model model,HttpServletRequest request) throws Exception{ //왜인지 모르지만 ad_best_list,ad_best_list 두 번 적힘
		System.out.println("id(ad_best_list.env)="+id);
		int comma =0;
		try {			
			comma =id.indexOf(",");
			id = id.substring(comma+1);
		}catch(Exception e) {
			comma = 0;
			System.out.println(e.getMessage());
		}
		System.out.println("comma="+comma);
		System.out.println("ad_best_list.env="+id);
		
		final int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		// int total = bs.getTotal();
		int total = bs.getTotal_best(board); // 검색
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		// List<Board> list = bs.list(startRow, endRow);
		int no = total - startRow + 1;
		List<Board> list = bs.list_best(board);
		
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
		return "/board/ad/ad_best_list";
	}
	
	@RequestMapping("/ad_best_new.env")
	public String ad_best_new(String nm,String pageNum,String id,Model model){

		System.out.println("nu="+nm);
		System.out.println("ad_best_new.env="+id);
		if (nm==null) {nm = null; System.out.println("dddss");}
		int num = 0, ref = 0, re_level = 0, re_step = 0;
		
		if (nm != null) {
			num = Integer.parseInt(nm);
			Board board = bs.select_best(num);
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
		return "/board/ad/ad_best_new";
	}
	@RequestMapping(value="/ad_best_insert.env", method = RequestMethod.POST)
//	public @ResponseBody String ad_best_insert(@RequestParam("attach1") MultipartFile mf,Board board,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
	public String ad_best_insert(@RequestParam("attach1") MultipartFile mf,Board board,String pageNum,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
		System.out.println("ad_best_insert.env");
		int num = board.getNum();
		int number = bs.getMaxNum_best();
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
		 
		int result = bs.insert_best(board);
		
		model.addAttribute("id",id);
		model.addAttribute("result",result);
		
		//return board.toString();
		return "/board/ad/ad";
	}
	
	@RequestMapping(value="/ad_best_modifyForm.env", method = RequestMethod.GET)
	public String ad_best_modifyForm(String id,String pageNum,int num,Model model){
		Board board = bs.select_best(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/ad/ad_best_modifyForm";
	}
	
	@RequestMapping(value="/ad_best_modify.env", method = RequestMethod.POST)
	public String ad_best_modify(@RequestParam("attach1") MultipartFile mf,String preattach,HttpServletRequest request,String id,String pageNum,Board board,Model model){
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
		
		int result = bs.update_best(board);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:ad_best_list.env";
	}
	
	@RequestMapping("/ad_best_deleteForm.env")
	public String ad_best_deleteForm(String id,String pageNum,int num,Model model){
		Board board = bs.select_best(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/ad/ad_best_deleteForm";
	}
	
	@RequestMapping(value="/ad_best_delete.env", method = RequestMethod.POST)
	public String ad_best_delete(String id,String pageNum,int num,Model model){
		int result = bs.delete_best(num);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:ad_best_list.env";
	}
	
	//회사 홍보
	@RequestMapping("/ad_com_view.env")
	public String ad_com_view(String id,String pageNum,int num,Model model,HttpServletRequest request) throws Exception{

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
		
		bs.selectUpdate_com(num);
		Board board = bs.select_com(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/ad/ad_com_view";
	}
	
	@RequestMapping("/ad_com_list.env")
	public String ad_com_list(Board board,String pageNum,String id,Model model,HttpServletRequest request) throws Exception{ //왜인지 모르지만 ad_list,ad_list 두 번 적힘
		System.out.println("id(ad_list.env)="+id);
		int comma=0;
		try{			
			comma=id.indexOf(",");
			id = id.substring(comma+1);
		}catch(Exception e) {
			comma = 0;
			System.out.println(e.getMessage());
		}
		System.out.println("comma="+comma);
		System.out.println("ad_list.env="+id);
		
		final int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		// int total = bs.getTotal();
		int total = bs.getTotal_com(board); // 검색
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		// List<Board> list = bs.list(startRow, endRow);
		int no = total - startRow + 1;
		List<Board> list = bs.list_com(board);
		
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
		return "/board/ad/ad_com_list";
	}
	
	@RequestMapping("/ad_com_new.env")
	public String ad_com_new(String nm,String pageNum,String id,Model model){

		System.out.println("nu="+nm);
		System.out.println("ad_new.env="+id);
		if (nm==null) {nm = null; System.out.println("dddss");}
		int num = 0, ref = 0, re_level = 0, re_step = 0;
		
		if (nm != null) {
			num = Integer.parseInt(nm);
			Board board = bs.select_com(num);
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
		return "/board/ad/ad_com_new";
	}
	@RequestMapping(value="/ad_com_insert.env", method = RequestMethod.POST)
//	public @ResponseBody String ad_insert(@RequestParam("attach1") MultipartFile mf,Board board,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
	public String ad_com_insert(@RequestParam("attach1") MultipartFile mf,Board board,String pageNum,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
		System.out.println("ad_insert.env");
		int num = board.getNum();
		int number = bs.getMaxNum_com();
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
		 
		int result = bs.insert_com(board);
		
		model.addAttribute("id",id);
		model.addAttribute("result",result);
		
		//return board.toString();
		return "/board/ad/ad_com";
	}
	
	@RequestMapping(value="/ad_com_modifyForm.env", method = RequestMethod.GET)
	public String ad_com_modifyForm(String id,String pageNum,int num,Model model){
		System.out.println("우수기업수정");
		Board board = bs.select_com(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/ad/ad_com_modifyForm";
	}
	
	@RequestMapping(value="/ad_com_modify.env", method = RequestMethod.POST)
	public String ad_com_modify(@RequestParam("attach1") MultipartFile mf,String preattach,HttpServletRequest request,String id,String pageNum,Board board,Model model){
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
		
		int result = bs.update_com(board);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:ad_com_list.env";
	}
	
	@RequestMapping("/ad_com_deleteForm.env")
	public String ad_com_deleteForm(String id,String pageNum,int num,Model model){
		Board board = bs.select_com(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/ad/ad_com_deleteForm";
	}
	
	@RequestMapping(value="/ad_com_delete.env", method = RequestMethod.POST)
	public String ad_com_delete(String id,String pageNum,int num,Model model){
		int result = bs.delete_com(num);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:ad_com_list.env";
	}
}
