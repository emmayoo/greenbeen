package env.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import env.model.Board;
import env.model.ReplyBoard;

@Repository
public class Board_questionDao{
	@Autowired
	private SqlSessionTemplate sst;

	public List<Board> list(Board board) {
		return sst.selectList("question.list", board);
	}

	public int getTotal(Board board) {
		return sst.selectOne("question.getTotal", board);
	}

	public int insert(Board board) {
		return sst.insert("question.insert", board);
	}

	public Board select(int num) {
		return sst.selectOne("question.select", num);
	}

	public void selectUpdate(int num) {
		sst.update("question.selectUpdate", num);
	}

	public int update(Board board) {
		return sst.update("question.update", board);
	}

	public int delete(int num) {
		return sst.update("question.delete", num);
	}

	public int getMaxNum() {
		return sst.selectOne("question.getMaxNum");
	}

	public void updateRe(Board board) {
		sst.update("question.updateRe", board);
	}
	
	//찾기
	public List find(String find_val) {
		return sst.selectList("question.find", find_val);
	}
	//찾기
	public int cnt(String find_val) {
		return (int)sst.selectOne("question.cnt", find_val);
	}
}