package env.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import env.model.ReplyBoard;

public class SessionCheckInter extends HandlerInterceptorAdapter { //HandlerInterceptorAdapter는 원하는 method만 오버라이딩 할 수 있다
	
	// preHandle(request,response,handler)메소드
	// 1.Controller에서 요청(*.nhn)을 받기 전에  preHandle()가 호출되어 가로채는 역할로 사용
	// 2.로그인 하지않고(세션이 없으면) 요청하면 로그인 폼으로 이동 하도록 해주는 역할
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			
			PrintWriter out = response.getWriter();
			
		if (id == null || id.equals(""))  {	
			out.println("<script>");
			out.println("alert('login please! 로그인이 필요합니다.')");
			out.println("</script>");
			
			response.sendRedirect("loginForm.env");	// 세션이 없으면 로그인 폼으로 이동
			out.close();
			return false;
		}
		return true;
	}
}