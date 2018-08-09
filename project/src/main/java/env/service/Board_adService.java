package env.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import env.dao.Board_adDao;
import env.model.Board;

@Service
public class Board_adService{
	@Autowired
	private Board_adDao bd;

	//회사홍보
	public List<Board> list_best(Board board) {
		return bd.list_best(board);
	}

	public int getTotal_best(Board board) {
		return bd.getTotal_best(board);
	}

	public int insert_best(Board board) {
		return bd.insert_best(board);
	}

	public Board select_best(int num) {
		return bd.select_best(num);
	}

	public void selectUpdate_best(int num) {
		bd.selectUpdate_best(num);
	}

	public int update_best(Board board) {
		return bd.update_best(board);
	}

	public int delete_best(int num) {
		return bd.delete_best(num);
	}

	public int getMaxNum_best() {
		return bd.getMaxNum_best();
	}
	
	//우수회사
	public List<Board> list_com(Board board) {
		return bd.list_com(board);
	}

	public int getTotal_com(Board board) {
		return bd.getTotal_com(board);
	}

	public int insert_com(Board board) {
		return bd.insert_com(board);
	}

	public Board select_com(int num) {
		return bd.select_com(num);
	}

	public void selectUpdate_com(int num) {
		bd.selectUpdate_com(num);
	}

	public int update_com(Board board) {
		return bd.update_com(board);
	}

	public int delete_com(int num) {
		return bd.delete_com(num);
	}

	public int getMaxNum_com() {
		return bd.getMaxNum_com();
	}
	
	//찾기
	public List find(String find_val) {
		return bd.find(find_val);
	}
}