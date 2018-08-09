package env.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import env.model.Board;

@Repository
public class Board_filesDao{
	@Autowired
	private SqlSessionTemplate sst;

	public List<Board> list(Board board) {
		return sst.selectList("files.list", board);
	}

	public int getTotal(Board board) {
		return sst.selectOne("files.getTotal", board);
	}

	public int insert(Board board) {
		return sst.insert("files.insert", board);
	}

	public Board select(int num) {
		return sst.selectOne("files.select", num);
	}

	public void selectUpdate(int num) {
		sst.update("files.selectUpdate", num);
	}

	public int update(Board board) {
		return sst.update("files.update", board);
	}

	public int delete(int num) {
		return sst.update("files.delete", num);
	}

	public int getMaxNum() {
		return sst.selectOne("files.getMaxNum");
	}
	
	//찾기
	public List find(String find_val) {
		return sst.selectList("files.find", find_val);
	}

}