<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="env.dao.joinDAOImpl" %>
<%
 request.setCharacterEncoding("utf-8");
 
 String id=request.getParameter("memid"); 
 String pass=request.getParameter("mempass");
 System.out.println("id="+id);
 System.out.println("pass="+pass);
 
 joinDAOImpl jd=new joinDAOImpl();

 int re=jd.checkId(id);
 //1이면 중복 -1이면 사용가능 아이디

 out.println(re);
%>
 