package env.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import env.model.Board;

@Repository
public class Board_noticeDao{
	@Autowired
	private SqlSessionTemplate sst;

	public List<Board> list(Board board) {
		return sst.selectList("notice.list", board);
	}

	public int getTotal(Board board) {
		return sst.selectOne("notice.getTotal", board);
	}

	public int insert(Board board) {
		return sst.insert("notice.insert", board);
	}

	public Board select(int num) {
		return sst.selectOne("notice.select", num);
	}

	public void selectUpdate(int num) {
		sst.update("notice.selectUpdate", num);
	}

	public int update(Board board) {
		return sst.update("notice.update", board);
	}

	public int delete(int num) {
		return sst.update("notice.delete", num);
	}

	public int getMaxNum() {
		return sst.selectOne("notice.getMaxNum");
	}
	
	//찾기
	public List find(String find_val) {
		return sst.selectList("notice.find", find_val);
	}

}