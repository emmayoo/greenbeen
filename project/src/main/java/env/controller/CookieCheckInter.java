package env.controller;

import java.net.URLDecoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//I Have a Question!!! - 이거 때문에 좀 느려진건지???? 매번 들렸다가 가야하니까
public class CookieCheckInter extends HandlerInterceptorAdapter { //HandlerInterceptorAdapter는 원하는 method만 오버라이딩 할 수 있다
	
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		System.out.print("CookieCheckInter: ");
		String id = null, pwd=null;
		id=(String)session.getAttribute("id");
		
		try {
			Cookie[] cookies = request.getCookies();
			for(int i=0; i<cookies.length;i++) {
				String name= cookies[i].getName();
				if(name.equals("cookie_id"))
					id = URLDecoder.decode(cookies[i].getValue(), "utf-8");
				if(name.equals("cookie_pwd")) {
					pwd = URLDecoder.decode(cookies[i].getValue(), "utf-8");
					System.out.println("쿠키 있어요.>>"+id+"/"+pwd);						
				}
			}
			session.setAttribute("id", id);
			//session.setAttribute("pwd", pwd);
			
		}catch(Exception e) {System.out.println(e.getMessage());}	

		return true;
	}
}