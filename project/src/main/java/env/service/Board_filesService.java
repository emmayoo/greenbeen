package env.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import env.dao.Board_filesDao;
import env.model.Board;

@Service
public class Board_filesService{
	@Autowired
	private Board_filesDao bd;

	// public List<Board> list(int startRow, int endRow) {
	public List<Board> list(Board board) {
		return bd.list(board);
		// return bd.list(startRow, endRow);
	}

	public int getTotal(Board board) {
		return bd.getTotal(board);
	}

	public int insert(Board board) {
		return bd.insert(board);
	}

	public Board select(int num) {
		return bd.select(num);
	}

	public void selectUpdate(int num) {
		bd.selectUpdate(num);
	}

	public int update(Board board) {
		return bd.update(board);
	}

	public int delete(int num) {
		return bd.delete(num);
	}

	public int getMaxNum() {
		return bd.getMaxNum();
	}

	//찾기
	public List find(String find_val) {
		return bd.find(find_val);
	}
}