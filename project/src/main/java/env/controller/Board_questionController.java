package env.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import env.model.Board;
import env.model.PagingPgm;
import env.model.joinBean;
import env.service.Board_questionService;
import env.service.ReplyBoardServiceImpl;
import env.service.joinservice;

@Controller
public class Board_questionController {
	@Autowired
	private ReplyBoardServiceImpl rbs;
	@Autowired
	private Board_questionService bs;
	@Autowired
	private joinservice js;
	
	private Date dt=new Date();
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * this is controller for question_view
	 * @param id
	 * @param pageNum
	 * @param num
	 * @param model
	 * @return
	 */
	@RequestMapping("/question_view.env")
	public String question_view(String id,String pageNum,int num,Model model,HttpServletRequest request) throws Exception{

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
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("id",id);
		return "/board/question/question_view";
	}
	
	@RequestMapping("/question_list.env")
	public String question_list(Board board,String pageNum,String id,Model model){ //왜인지 모르지만 question_list,question_list 두 번 적힘
		System.out.println("id(question_list.env)="+id);
		int comma=0;
		try {			
			comma =id.indexOf(",");
			id = id.substring(comma+1);
		}catch(Exception e) {
			comma = 0;
			System.out.println(e.getMessage());
		}
		
		System.out.println("comma="+comma);
		
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
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("search", board.getSearch());
		model.addAttribute("keyword", board.getKeyword());
		model.addAttribute("id",id);
		
		return "/board/question/question_list";
	}
	
	@RequestMapping("/question_new.env")
	public String question_new(String nm,String pageNum,String id,Model model,HttpSession session) throws Exception{

		System.out.println("nu="+nm);
		System.out.println("question_new.env="+id);
		
		String idcheck = (String)session.getAttribute("id");
		joinBean member = js.userCheck(idcheck);
		
		if (nm==null) {nm = null;}
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
		model.addAttribute("member",member);
		return "/board/question/question_new";
	}
	@RequestMapping(value="/question_insert.env", method = RequestMethod.POST)
//	public @ResponseBody String question_insert(@RequestParam("attach1") MultipartFile mf,Board board,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
	public String question_insert(@RequestParam("attach1") MultipartFile mf,Board board,String pageNum,String id,Model model,HttpSession session,HttpServletRequest request)throws IllegalStateException, IOException{
		System.out.println("question_insert.env");
		int num = board.getNum();
		int number = bs.getMaxNum();
		if (num != 0) {
			bs.updateRe(board);
			board.setRe_level(board.getRe_level() + 1);
			board.setRe_step(board.getRe_step() + 1);
		} else board.setRef(number);
		
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
		return "/board/question/question";
	}
	
	@RequestMapping("/question_modifyForm.env")
	public String question_modifyForm(String id,String pageNum,int num,Model model){
		Board board = bs.select(num);
		
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/question/question_modifyForm";
	}
	
	@RequestMapping(value="/question_modify.env", method = RequestMethod.POST)
	public String question_modify(@RequestParam("attach1") MultipartFile mf,String preattach,String id,String pageNum,Board board,Model model,HttpServletRequest request){
		
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
		try {			
			File file = new File(path);
			file.mkdirs();
			
			File[] f = file.listFiles();
			for(int i =0; i< f.length;i++) {
				if(f[i].getName().equals(preattach)) {
					System.out.println("예");
					f[i].delete();
				}
			}
		}catch(Exception e) {System.out.println(e.getStackTrace());}
		int result = bs.update(board);
		
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:question_list.env";
	}
	
	@RequestMapping("/question_deleteForm.env")
	public String question_deleteForm(String id,String pageNum,int num,Model model){
		Board board = bs.select(num);
		model.addAttribute("id",id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "/board/question/question_deleteForm";
	}
	
	@RequestMapping(value="/question_delete.env", method = RequestMethod.POST)
	public String question_delete(String id,String pageNum,String preattach,int num,Model model,HttpServletRequest request){
		System.out.println("id="+id+"p="+pageNum+"num="+num);
		
		/*String path= request.getRealPath("upload");
		//이전에 있던 파일 없애기
		File file = new File(path);
		file.mkdirs();
				
		File[] f = file.listFiles();
		for(int i =0; i< f.length;i++) {
			if(f[i].getName().equals(preattach)) {
				System.out.println("예");
				f[i].delete();
			}
		}*/
		
		int result = bs.delete(num);
		model.addAttribute("id",id);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "redirect:question_list.env";
	}

}
