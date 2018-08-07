package env.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import env.dao.Board_knowDao;
import env.model.Board;

@Service
public class Board_knowService{
	@Autowired
	private Board_knowDao bd;

	//오늘의 퀴즈
	public List<Board> list_quiz(Board board) {
		return bd.list_quiz(board);
	}

	public int getTotal_quiz(Board board) {
		return bd.getTotal_quiz(board);
	}

	public int insert_quiz(Board board) {
		return bd.insert_quiz(board);
	}

	public Board select_quiz(int num) {
		return bd.select_quiz(num);
	}

	public void selectUpdate_quiz(int num) {
		bd.selectUpdate_quiz(num);
	}

	public int update_quiz(Board board) {
		return bd.update_quiz(board);
	}

	public int delete_quiz(int num) {
		return bd.delete_quiz(num);
	}

	public int getMaxNum_quiz() {
		return bd.getMaxNum_quiz();
	}
	
	public int updatePoint(String loginid) {
		return bd.updatePoint(loginid);
	}
	
	//오늘의 뉴스
	public List<Board> list_news(Board board) {
		return bd.list_news(board);
	}

	public int getTotal_news(Board board) {
		return bd.getTotal_news(board);
	}

	public int insert_news(Board board) {
		return bd.insert_news(board);
	}

	public Board select_news(int num) {
		return bd.select_news(num);
	}

	public void selectUpdate_news(int num) {
		bd.selectUpdate_news(num);
	}

	public int update_news(Board board) {
		return bd.update_news(board);
	}

	public int delete_news(int num) {
		return bd.delete_news(num);
	}

	public int getMaxNum_news() {
		return bd.getMaxNum_news();
	}
	
	//찾기
	public List find(String find_val) {
		return bd.find(find_val);
	}
	public int cnt(String find_val) {
		return bd.cnt(find_val);
	}
	

}