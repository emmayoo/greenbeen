package env.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import env.model.Board;

@Repository
public class Board_adDao{
	@Autowired
	private SqlSessionTemplate sst;

	//우수회사
	public List<Board> list_best(Board board) {
		return sst.selectList("ad.list_best", board);
	}

	public int getTotal_best(Board board) {
		return sst.selectOne("ad.getTotal_best", board);
	}

	public int insert_best(Board board) {
		return sst.insert("ad.insert_best", board);
	}

	public Board select_best(int num) {
		return sst.selectOne("ad.select_best", num);
	}

	public void selectUpdate_best(int num) {
		sst.update("ad.selectUpdate_best", num);
	}

	public int update_best(Board board) {
		return sst.update("ad.update_best", board);
	}

	public int delete_best(int num) {
		return sst.update("ad.delete_best", num);
	}

	public int getMaxNum_best() {
		return sst.selectOne("ad.getMaxNum_best");
	}
	
	//회사홍보
	public List<Board> list_com(Board board) {

		System.out.println("startRow="+board.getStartRow());
		System.out.println("endRow="+board.getEndRow());
		System.out.println("restep="+board.getRe_step());
		return sst.selectList("ad.list_com", board);
	}

	public int getTotal_com(Board board) {
		return sst.selectOne("ad.getTotal_com", board);
	}

	public int insert_com(Board board) {
		return sst.insert("ad.insert_com", board);
	}

	public Board select_com(int num) {
		return sst.selectOne("ad.select_com", num);
	}

	public void selectUpdate_com(int num) {
		sst.update("ad.selectUpdate_com", num);
	}

	public int update_com(Board board) {
		return sst.update("ad.update_com", board);
	}

	public int delete_com(int num) {
		return sst.update("ad.delete_com", num);
	}

	public int getMaxNum_com() {
		return sst.selectOne("ad.getMaxNum_com");
	}
	
	//찾기
	public List find(String find_val) {
		return sst.selectList("ad.find", find_val);
	}
	//찾기
	public int cnt(String find_val) {
		return (int)sst.selectOne("ad.cnt", find_val);
	}

}