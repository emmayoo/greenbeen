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
import env.service.Board_filesService;
import env.service.ReplyBoardServiceImpl;
import env.service.joinservice;

@Controller
public class Board_filesController {
	@Autowired
	private ReplyBoardServiceImpl rbs;
	@Autowired
	private Board_filesService bs;
	@Autowired
	private joinservice js;
	
	private Date dt=new Date();
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	
	@RequestMapping("/files_view.env")
	public String files_view(String id,String pageNum,int num,Model model,HttpServletRequest request) throws Exception{
		
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
		
		bs.selectUpdate(num);
		Board board = bs.select(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/files/files_view";
	}
	
	@RequestMapping("/files_list.env")
	public String files_list(Board board,String pageNum,String id,Model model,HttpServletRequest request) throws Exception{ 
		System.out.println("id(files_list.env)="+id);
		int comma =0;
		try {			
			comma =id.indexOf(",");
			id = id.substring(comma+1);
		}catch(Exception e) {
			comma = 0;
			System.out.println(e.getMessage());
		}
		System.out.println("comma="+comma);
		System.out.println("files_list.env="+id);
		
		final int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		// int total = bs.getTotal();
		int total = bs.getTotal(board); // 검색
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		// List<Board> list = bs.list(startRow, endRow);
		int no = total - startRow + 1;
		List<Board> list = bs.list(board);
		
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
		return "/board/files/files_list";
	}
	
	@RequestMapping("/files_new.env")
	public String files_new(String nm,String pageNum,String id,Model model){

		System.out.println("nu="+nm);
		System.out.println("files_new.env="+id);
		if (nm==null) {nm = null; System.out.println("dddss");}
		int num = 0, ref = 0, re_level = 0, re_step = 0;
		
		if (nm != null) {
			num = Integer.parseInt(nm);
			Board board = bs.select(num);
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
		return "/board/files/files_new";
	}
	@RequestMapping(value="/files_insert.env", method = RequestMethod.POST)
//	public @ResponseBody String files_insert(@RequestParam("attach1") MultipartFile mf,Board board,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
	public String files_insert(@RequestParam("attach1") MultipartFile mf,Board board,String pageNum,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
		System.out.println("files_insert.env");
		int num = board.getNum();
		int number = bs.getMaxNum();
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
		 
		int result = bs.insert(board);
		
		model.addAttribute("id",id);
		model.addAttribute("result",result);
		
		//return board.toString();
		return "/board/files/files";
	}
	
	@RequestMapping("/files_modifyForm.env")
	public String files_modifyForm(String id,String pageNum,int num,Model model){
		Board board = bs.select(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/files/files_modifyForm";
	}
	
	@RequestMapping(value="/files_modify.env", method = RequestMethod.POST)
	public String files_modify(@RequestParam("attach1") MultipartFile mf,String preattach,HttpServletRequest request,String id,String pageNum,Board board,Model model){
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
		int result = bs.update(board);
		System.out.println("files modify / id="+id);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:files_list.env";
	}
	
	@RequestMapping("/files_deleteForm.env")
	public String files_deleteForm(String id,String pageNum,int num,Model model){
		Board board = bs.select(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/files/files_deleteForm";
	}
	
	@RequestMapping(value="/files_delete.env", method = RequestMethod.POST)
	public String files_delete(String id,String pageNum,int num,Model model){
		int result = bs.delete(num);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:files_list.env";
	}
		
}
