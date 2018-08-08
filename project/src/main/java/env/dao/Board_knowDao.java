package env.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import env.model.Board;
import env.model.joinBean;

@Repository
public class Board_knowDao{
	@Autowired
	private SqlSessionTemplate sst;

	//오늘의 퀴즈
	public List<Board> list_quiz(Board board) {
		return sst.selectList("know.list_quiz", board);
	}

	public int getTotal_quiz(Board board) {
		return sst.selectOne("know.getTotal_quiz", board);
	}

	public int insert_quiz(Board board) {
		return sst.insert("know.insert_quiz", board);
	}

	public Board select_quiz(int num) {
		return sst.selectOne("know.select_quiz", num);
	}

	public void selectUpdate_quiz(int num) {
		sst.update("know.selectUpdate_quiz", num);
	}
	
	//해나
	public String selectQuiz_date(String idcheck) {
		return sst.selectOne("know.selectQuiz_date",idcheck);
	}

	public int update_quiz(Board board) {
		return sst.update("know.update_quiz", board);
	}

	public int delete_quiz(int num) {
		return sst.update("know.delete_quiz", num);
	}

	public int getMaxNum_quiz() {
		return sst.selectOne("know.getMaxNum_quiz");
	}
	
	public int updatePoint(String loginid) {
		return sst.update("know.updatePoint", loginid);
	}
	
	public void updateQdate(String loginid) {
		sst.update("know.updateQdate", loginid);
	}
	
	//오늘의 뉴스
	public List<Board> list_news(Board board) {

		System.out.println("startRow="+board.getStartRow());
		System.out.println("endRow="+board.getEndRow());
		System.out.println("restep="+board.getRe_step());
		return sst.selectList("know.list_news", board);
	}

	public int getTotal_news(Board board) {
		return sst.selectOne("know.getTotal_news", board);
	}

	public int insert_news(Board board) {
		return sst.insert("know.insert_news", board);
	}

	public Board select_news(int num) {
		return sst.selectOne("know.select_news", num);
	}

	public void selectUpdate_news(int num) {
		sst.update("know.selectUpdate_news", num);
	}

	public int update_news(Board board) {
		return sst.update("know.update_news", board);
	}

	public int delete_news(int num) {
		return sst.update("know.delete_news", num);
	}

	public int getMaxNum_news() {
		return sst.selectOne("know.getMaxNum_news");
	}
	
	//찾기
	public List find(String find_val) {
		return sst.selectList("know.find", find_val);
	}
	//찾기
	public int cnt(String find_val) {
		return (int)sst.selectOne("know.cnt", find_val);
	}
}