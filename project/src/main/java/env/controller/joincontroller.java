package env.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.security.PrivateKey;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import env.model.RSA;
import env.model.joinBean;
import env.service.RSAService;
import env.service.SHAService;
import env.service.joinservice;


@Controller
public class joincontroller {

	@Autowired 
	private joinservice js;
	
	@Autowired
	private RSAService rsas;
	
	private SHAService shas;
	
	// ID중복검사 ajax함수로 처리부분
		@RequestMapping(value = "/idcheck.env", method = RequestMethod.POST)
		public String member_idcheck(String memid, Model model) throws Exception {			
			
			System.out.println("id=" + memid);			

			int result = js.checkMemberId(memid);
			System.out.println("result:"+result);
			model.addAttribute("result",result);
			
			return "login/id_result";			
		}

		/* 로그인 폼 뷰 */
		@RequestMapping(value = "/loginForm.env")
		public String member_login(String inter,Model model,HttpServletRequest request,HttpSession session) {
			System.out.println("loginForm.env inter="+inter);
			
			PrivateKey key = (PrivateKey) session.getAttribute("privateKey");

			if (key != null) {
				session.removeAttribute("privateKey");
			}

			RSA rsa = rsas.createRSA();
			model.addAttribute("modulus", rsa.getModulus());
			model.addAttribute("exponent", rsa.getExponent());
			session.setAttribute("privateKey", rsa.getPrivateKey());
			/*			
			String id=null, pwd=null;
			
			try {
				Cookie[] cookies = request.getCookies(); //client의 모든 cookies를 가져오기
				for(int i=0;i<cookies.length;i++) {
					String name= cookies[i].getName();
					if(name.equals("cookie_id")) {
						id=URLDecoder.decode(cookies[i].getValue(),"utf-8"); //encoding된거 decoding하기
					}
					if(name.equals("cookie_pwd")) {
						pwd=URLDecoder.decode(cookies[i].getValue(),"utf-8");
					}
					autologin = "autologin";
					System.out.println("쿠키 있어요~>>"+id+"/"+pwd);
				}
			}catch(Exception e) {System.out.println(e.getMessage());}*/
			
			model.addAttribute("inter",inter);
//			model.addAttribute("id",id);
//			model.addAttribute("pwd",pwd);
			return "login/loginForm";
			// member 폴더의 member_login.jsp 뷰 페이지 실행
		}
		
		/* 아이디찾기 폼 */
		@RequestMapping(value = "/id_find.env")
		public String id_find() {
			return "login/id_find";
			// member 폴더의 pwd_find.jsp 뷰 페이지 실행
		}
		
		/* 비번찾기 폼 */
		@RequestMapping(value = "/pwd_find.env")
		public String pwd_find() {
			return "login/pwd_find";
			// member 폴더의 pwd_find.jsp 뷰 페이지 실행
		}

		/* 회원가입 폼 */
		@RequestMapping(value = "/join.env")
		public String member_join(Model model,HttpSession session) {
			PrivateKey key = (PrivateKey) session.getAttribute("privateKey");

			if (key != null) { //기존에 있던 privatekey 삭제
				session.removeAttribute("privateKey");
			}

			RSA rsa = rsas.createRSA();
			model.addAttribute("modulus", rsa.getModulus());
			model.addAttribute("exponent", rsa.getExponent());
			session.setAttribute("privateKey", rsa.getPrivateKey()); //새로운 privatekey생성
			
			return "login/join";
		}

		
		@RequestMapping(value = "/join_ok.env", method = RequestMethod.POST)
		public String member_join_ok(joinBean m,Model model,HttpSession session,
									HttpServletRequest request) throws Exception{
			
			String join_pwd = request.getParameter("join_pwd1").trim();
			String join_phone1 = request.getParameter("join_phone1").trim();
			String join_phone2 = request.getParameter("join_phone2").trim();
			String join_phone3 = request.getParameter("join_phone3").trim();
			String join_phone = join_phone1 + "-" + join_phone2 + "-" + join_phone3;
			String join_mailid = request.getParameter("join_mailid").trim();
			String join_maildomain = request.getParameter("join_maildomain").trim();
			String join_email = join_mailid + "@" + join_maildomain;
			
			System.out.println("join_ok 암호된 pw : " + join_pwd);

			// 개인키 취득
			PrivateKey key = (PrivateKey) session.getAttribute("privateKey");
				if (key == null) {
					System.out.println("비정상 적인 접근 입니다.");
					return null;
				}
						// session에 저장된 개인키 초기화
			session.removeAttribute("privateKey");
			try {
				// 암호화된 내용 복호화
				join_pwd = rsas.getDecryptText(key, join_pwd);
				System.out.println("복호화된 pwd="+join_pwd);
				
				//sha로 다시 암호화
				join_pwd = shas.SHA256(join_pwd);
				
			
			} catch (Exception e) {
				System.out.println("memberJoin 에러 : " + e);
			}
			// 첨부 파일 받는 부분
			m.setJoin_pwd(join_pwd);
			m.setJoin_phone(join_phone);
			m.setJoin_email(join_email);
			js.insertMember(m);
			return "redirect:loginForm.env";
		}
		/* 로그인 인증 */
		@RequestMapping(value="login_ok.env", method = RequestMethod.POST)
		public String member_login_ok(String id_cookie,@RequestParam("inter") String inter,
									HttpServletRequest request, HttpServletResponse response, HttpSession session
									,Model model,RedirectAttributes rttr) throws Exception {
			//request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();// 출력스트림 객체 생성
			
			String id = request.getParameter("id").trim();
			String pwd = request.getParameter("pwd").trim();
			
			System.out.println("login_ok 암호된 pwd : " + pwd);
			
			// 개인키 취득
			PrivateKey key = (PrivateKey) session.getAttribute("privateKey");
			if (key == null) {
				System.out.println("비정상 적인 접근 입니다.");
				return null;
			}
			// session에 저장된 개인키 초기화
			session.removeAttribute("privateKey");
			try {
				// 암호화된 내용 복호화
				pwd = rsas.getDecryptText(key, pwd);
				System.out.println("복호화된 pwd="+pwd);
				
				//sha로 다시 암호화
				pwd = shas.SHA256(pwd);
				
			} catch (Exception e) {
				System.out.println("memberJoin 에러 : " + e);
			}
			
			//자동 로그인 쿠키
			if(id_cookie==null) {id_cookie="off";}

			if(id_cookie=="on"||id_cookie.equals("on")) {
				try {
					String id2 =URLEncoder.encode(id, "utf-8");
					Cookie idcookie = new Cookie("cookie_id", id2); //쿠키 생성
					idcookie.setMaxAge(60*60*24*365); //쿠키 저장기간(1년)
					String pwd2 =URLEncoder.encode(pwd, "utf-8");
					Cookie pwdcookie = new Cookie("cookie_pwd", pwd2); //쿠키 생성
					pwdcookie.setMaxAge(60*60*24*365); //쿠키 저장기간(1년)
				
					response.addCookie(idcookie); //client 컴퓨터에 저장
					response.addCookie(pwdcookie);
					System.out.println("자동 저장 - 쿠키 생성 됨");
				}catch(Exception e) {System.out.println(e.getMessage());}
			}else {System.out.println("자동 저장 안 함!");}
			
			joinBean m = this.js.userCheck(id);

			if (m == null) {// 등록되지 않은 회원일때
				rttr.addFlashAttribute("msg","등록되지 않은 회원입니다!\n you are not our friend");
				return "redirect:/loginForm.env";
			} else {// 등록된 회원일때
				if (m.getJoin_pwd().equals(pwd)) {// 비번이 같을때
					session.setAttribute("id", id);
					System.out.println("login_ok.env="+inter);
					// jsp폴더의 index.jsp로 이동 (inter!)
					if(inter.equals("inter")||inter=="inter") {
						out.println("<script>");					
						out.println("alert('환영합니다 \n welcome');");
						out.println("history.go(-2);");						
						out.println("</script>");
						out.close();
						return null;
					}
					return "main";
				} else {// 비번이 다를때
					rttr.addFlashAttribute("msg","비밀번호가 틀립니다!\n wrong password");
					return "redirect:/loginForm.env";
				}
			}
		}

		/* 회원정보 수정 폼 */
		@RequestMapping(value = "/member_edit.env")
		public ModelAndView member_edit(HttpServletRequest request, HttpServletResponse response, HttpSession session)
				throws Exception {
			//response.setContentType("text/html;charset=UTF-8");
			String id = (String) session.getAttribute("id");

			joinBean editm = this.js.userCheck(id);

			String join_phone = editm.getJoin_phone();
			StringTokenizer st02 = new StringTokenizer(join_phone, "-");
			// java.util 패키지의 StringTokenizer 클래스는 첫번째 전달인자를
			// 두번째 -를 기준으로 문자열을 파싱해준다.
			String join_phone1 = st02.nextToken();// 첫번째 전화번호 저장
			String join_phone2 = st02.nextToken(); // 두번째 전번 저장
			String join_phone3 = st02.nextToken();// 세번째 전번 저장

			String join_email = editm.getJoin_email();
			StringTokenizer st03 = new StringTokenizer(join_email, "@");
			// java.util 패키지의 StringTokenizer 클래스는 첫번째 전달인자를
			// 두번째 @를 기준으로 문자열을 파싱해준다.
			String join_mailid = st03.nextToken();// 첫번째 전화번호 저장
			String join_maildomain = st03.nextToken(); // 두번째 전번 저장

			ModelAndView m = new ModelAndView("login/member_edit");
			m.addObject("editm", editm);
			m.addObject("join_phone1", join_phone1);
			m.addObject("join_phone2", join_phone2);
			m.addObject("join_phone3", join_phone3);
			m.addObject("join_mailid", join_mailid);
			m.addObject("join_maildomain", join_maildomain);

			return m;

		}

		/* 회원정보 수정 */
		@RequestMapping(value = "/member_edit_ok.env", method = RequestMethod.POST)
		public ModelAndView member_edit_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session)
				throws Exception {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			// session = request.getSession();// 세션객체를 만듬
			joinBean member = new joinBean();


			String id = (String) session.getAttribute("id");
			// 세션아이디값을 취득

			String join_pwd = request.getParameter("join_pwd1").trim();
			String join_name = request.getParameter("join_name").trim();
			String join_phone1 = request.getParameter("join_phone1").trim();
			String join_phone2 = request.getParameter("join_phone2").trim();
			String join_phone3 = request.getParameter("join_phone3").trim();
			String join_phone = join_phone1 + "-" + join_phone2 + "-" + join_phone3;
			String join_mailid = request.getParameter("join_mailid").trim();
			String join_maildomain = request.getParameter("join_maildomain").trim();
			String join_email = join_mailid + "@" + join_maildomain;

			joinBean editm = this.js.userCheck(id);
			// 아이디를 기준으로 디비로 부터 회원정보를 가져옴
			
			member.setJoin_id(id);
			member.setJoin_pwd(join_pwd);
			member.setJoin_name(join_name);
			member.setJoin_phone(join_phone);
			member.setJoin_email(join_email);
			this.js.updateMember(member);// 수정 메서드 호출
			// response.sendRedirect("member_edit.nhn");
			ModelAndView mv = new ModelAndView("main");
			mv.addObject("join_name", member.getJoin_name());
			return mv;
		}

		/* 회원정보 삭제 폼 */
		@RequestMapping(value = "/member_del.env")
		public ModelAndView member_del(HttpServletRequest request, HttpServletResponse response, HttpSession session)
				throws Exception {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();// 출력 스트림 객체 생성
			// session = request.getSession();// 세션 객체 생성

			String id = (String) session.getAttribute("id");
		
			joinBean deleteM = this.js.userCheck(id);

			ModelAndView dm = new ModelAndView("login/member_del");
			dm.addObject("d_id", id);
			dm.addObject("d_name", deleteM.getJoin_name());
			return dm;

		}

		/* 회원정보 삭제 완료 */
		@RequestMapping(value = "/member_del_ok.env", method = RequestMethod.POST)
		public ModelAndView member_del_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session)
				throws Exception {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			// session = request.getSession();

			String id = (String) session.getAttribute("id");
	
			String pass = request.getParameter("pwd").trim();
			String del_cont = request.getParameter("del_cont").trim();
			joinBean member = this.js.userCheck(id);

				// 아이디에 해당하는 디비 회원정보를 가져온다.
			if (!member.getJoin_pwd().equals(pass)) {
				out.println("<script>");
				out.println("alert('비번이 다릅니다!')");
				out.println("history.back()");
				out.println("</script>");
			} else {// 비번이 같은 경우
				String up = request.getRealPath("upload");
				/*String fname = member.getJoin_profile();
				// 디비에 저장된 기존 이진파일명을 가져옴
				if (fname != null) {// 기존 이진파일이 존재하면
					File delFile = new File(up + fname);
					delFile.delete();// 기존 이진파일을 삭제
				}*/
				joinBean delm = new joinBean();
				delm.setJoin_id(id);
				delm.setJoin_delcont(del_cont);

				this.js.deleteMember(delm);// 삭제 메서드 호출

				session.invalidate();// 세션만료

				response.sendRedirect("loginForm.env");
			}
			return null;
		
		}

		// 로그아웃
		@RequestMapping("logout.env")
		public String logout(HttpSession session,HttpServletRequest request, HttpServletResponse response) {
			session.invalidate();
			
			try {
				Cookie[] cookies = request.getCookies(); //client의 모든 cookies를 가져오기
				for(int i=0;i<cookies.length;i++) {
					String name= cookies[i].getName();
					if(name.equals("cookie_id")) {
						cookies[i].setMaxAge(0);
					}
					if(name.equals("cookie_pwd")) {
						cookies[i].setMaxAge(0);
					}
					response.addCookie(cookies[i]);
					System.out.println("쿠키 삭제 성공");
				}
			}catch(Exception e) {System.out.println(e.getMessage());}
			
			return "main";
		}
		
		/* 내 페이지 */
		@RequestMapping(value = "/mypage.env")
		public ModelAndView mypage(HttpServletRequest request, HttpServletResponse response, HttpSession session)
				throws Exception {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			// session = request.getSession();
			String id = (String) session.getAttribute("id");
			// 아이디 키값의 세션아이디를 구함
			
			joinBean editm = js.userCheck(id);

			ModelAndView m = new ModelAndView("login/mypage");
			m.addObject("member", editm);

			return m;
		}
		
		/* id 인증번호보내기 */
		@RequestMapping(value = "/id_send_mail.env")
		public String id_send_mail(joinBean jb,String join_name,String join_mailid,String join_maildomain,Model model) throws Exception {
			Random random = new Random();
			int a = random.nextInt(100); //임시 비번 (난수를 설정하여 메일로 전송할 것)
			
			String result ="n";
			//String result ="이름 또는 이메일을 확인하세요";
			jb.setJoin_name("");
			String useremail= join_mailid+"@"+join_maildomain;
			List<joinBean> list = js.member_list();
			for(int i=0; i<list.size();i++) {
				jb=list.get(i);
				if(useremail.equals(jb.getJoin_email())) {
					jb= js.findid(useremail);
					break;//for문 나가기
				}
				System.out.println(i);
				if(i==(list.size()-1)) {
					model.addAttribute("result", "그런 이메일 없어요~");
					return "login/result";
				}
			}
		
			if(!join_name.equals(jb.getJoin_name())) { 
				System.out.println("여기닷ㅅㅁㅇㄴㄹ?");
			}else {								//내가 적은 이름과 == db에 있는 이름(같을때)
			//	result="이메일로 인증번호가 갔어요~";
			result="y";
			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com";
			String hostSMTPid = "duswn1452@naver.com";
			String hostSMTPpwd = "project1234"; // 비밀번호 입력해야함

			// 보내는 사람 EMail, 제목, 내용
			String fromEmail = "duswn1452@naver.com";
			String fromName = "관리자";
			String subject = "[환경정보공개시스템]인증메일입니다.";

			// 받는 사람 E-Mail 주소
			String mail = useremail;

			try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(587);

				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet); //받는 사람
				email.setFrom(fromEmail, fromName, charSet); //보내는 사람
				email.setSubject(subject);
				email.setHtmlMsg("<p align = 'center'>[환경정보공개시스템]인증메일입니다.</p><br>" 
								 + "<div align='center'> 인증번호 : " + a + "</div>");
				email.send();
	
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			}
			model.addAttribute("result", result+","+a);
			model.addAttribute("a", a);

			return "login/result";
		}
		
		/* 아이디찾기 폼 */
		@RequestMapping(value = "/id_find_ok.env", method = RequestMethod.POST)
		public String id_find_ok(joinBean jb,String findid,String join_mailid,String join_maildomain,String mailcheck,Model model) throws Exception {
			System.out.println("send_mail="+jb.getJoin_name());
			String email= join_mailid+"@"+join_maildomain;
			jb.setJoin_email(email);
			int a = Integer.parseInt(findid);
			System.out.println("아이디 찾기 폼"+a+"/"+mailcheck);
			if(a==Integer.parseInt(mailcheck)) System.out.println("같아용");
			jb = js.findid(email);
			model.addAttribute("result",jb.getJoin_id());
			return "login/id_find_ok";
			//return "login/id_find_ok";
		}
			
		/* pwd 인증번호보내기 */
		@RequestMapping(value = "/pwd_send_mail.env")
		public String pwd_send_mail(joinBean jb,String join_id,String join_mailid,String join_maildomain,Model model) throws Exception {
			Random random = new Random();
			int a = random.nextInt(100); //임시 비번 (난수를 설정하여 메일로 전송할 것)
			String result ="n";
			//String result ="아이디 또는 이메일을 확인하세요";
			jb.setJoin_id("");
			String useremail= join_mailid+"@"+join_maildomain;
			List<joinBean> list = js.member_list();
			for(int i=0; i<list.size();i++) {
				jb=list.get(i);
				if(useremail.equals(jb.getJoin_email())) {
					jb= js.findid(useremail);
					break;//for문 나가기
				}
				System.out.println(i);
				if(i==(list.size()-1)) {
					model.addAttribute("result", "그런아이디가 없어요~");
					return "login/result";
				}
			}
		
			if(!join_id.equals(jb.getJoin_id())) { 
			}else {		//내가 적은 id == db에 있는 id(같을때)
			Map map = new HashMap();
			map.put("join_pwd",a);
			map.put("join_id",join_id);
			js.temp_pwd(map);	
			result="yes";
			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com";
			String hostSMTPid = "duswn1452@naver.com";
			String hostSMTPpwd = "project1234"; // 비밀번호 입력해야함

			// 보내는 사람 EMail, 제목, 내용
			String fromEmail = "duswn1452@naver.com";
			String fromName = "관리자";
			String subject = "[환경정보공개시스템]임시비밀번호 입니다.";

			// 받는 사람 E-Mail 주소
			String mail = useremail;

			try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(587);

				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet); //받는 사람
				email.setFrom(fromEmail, fromName, charSet); //보내는 사람
				email.setSubject(subject);
				email.setHtmlMsg("<p align = 'center'>[환경정보공개시스템]임시 비밀번호 입니다.</p><br>" 
								 + "<div align='center'> 임시 비밀번호 : " + a + "</div>");
				email.send();
	
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			}
			model.addAttribute("result", result);

			return "login/result";
		}
		
		
		/* 아이디찾기 폼 */
		@RequestMapping(value = "/pwd_find_ok.env", method = RequestMethod.POST)
		public String pwd_find_ok() throws Exception {
			return "login/result2";
			//return "login/id_find_ok";
		}

}
