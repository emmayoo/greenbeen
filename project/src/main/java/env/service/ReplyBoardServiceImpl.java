package env.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import env.dao.ReplyBoardDaoImpl;
import env.model.ReplyBoard;

@Service
public class ReplyBoardServiceImpl{
	@Autowired
	private ReplyBoardDaoImpl rbd;

	public List<ReplyBoard> list(int num) {
		return rbd.list(num);
	}

	public void insert(ReplyBoard rb) {
		rbd.insert(rb);
	}

	public void delete(int rno) {
		rbd.delete(rno);
	}

	public void update(ReplyBoard rb) {
		rbd.update(rb);
		
	}
}