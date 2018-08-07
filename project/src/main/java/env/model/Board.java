package env.model;

import java.text.SimpleDateFormat;
import java.util.Date;
//import java.sql.Date; //sql 은 yyyy-MM-dd만 나온다

public class Board {
	private int num;
	private String writer;
	private String subject;
	private String content;
	private String email;
	private int readcount;
	private String passwd;
	private int ref;
	private int re_step;
	private int re_level;
	private String ip;
	private String attach;
	private String reg_date;
	private String reg_date2;
	
	private String question;
	private String answer1;
	private String answer2;
	private String answer3;
	private String answer4;
	private String answer5;
	private String answer_correct;
	
	//private Date reg_date;
	//private Date reg_date2;
	private String del;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdf2=new SimpleDateFormat("HH:mm:ss");
	
	// page
	private int startRow;
	private int endRow;
	// 검색
	private String search;
	private String keyword;

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRe_step() {
		return re_step;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}


	public String getAttach() {
		return attach;
	}

	public void setAttach(String attach) {
		this.attach = attach;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = sdf.format(reg_date);
		this.reg_date2 = sdf2.format(reg_date);
	}


	public String getReg_date2() {
		return reg_date2;
	}


	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer1() {
		return answer1;
	}

	public void setAnswer1(String answer1) {
		this.answer1 = answer1;
	}

	public String getAnswer2() {
		return answer2;
	}

	public void setAnswer2(String answer2) {
		this.answer2 = answer2;
	}

	public String getAnswer3() {
		return answer3;
	}

	public void setAnswer3(String answer3) {
		this.answer3 = answer3;
	}

	public String getAnswer4() {
		return answer4;
	}

	public void setAnswer4(String answer4) {
		this.answer4 = answer4;
	}

	public String getAnswer5() {
		return answer5;
	}

	public void setAnswer5(String answer5) {
		this.answer5 = answer5;
	}

	public String getAnswer_correct() {
		return answer_correct;
	}

	public void setAnswer_correct(String answer_correct) {
		this.answer_correct = answer_correct;
	}

	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}


	@Override
	public String toString() {
		return "Board [num=" + num + ", writer=" + writer + ", subject=" + subject + ", content=" + content + ", email="
				+ email + ", readcount=" + readcount + ", passwd=" + passwd + ", ref=" + ref + ", re_step=" + re_step
				+ ", re_level=" + re_level + ", ip=" + ip + ", attach=" + attach + ", reg_date=" + reg_date + ", del="
				+ del + ", startRow=" + startRow + ", endRow=" + endRow + ", search=" + search + ", keyword=" + keyword
				+ ", reg_date2=" + reg_date2+ "]";
	}

	
	
}