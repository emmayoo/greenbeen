package env.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import env.dao.joinDAOImpl;
import env.model.joinBean;


@Service
public class joinservice {

	@Autowired
	private joinDAOImpl joinDao;
	
	public int checkMemberId(String id) throws Exception{
		return joinDao.checkId(id);
	}
		
	
	public joinBean findpwd(Map m)throws Exception {
		return joinDao.findpwd(m);
	}
	
	public void insertMember(joinBean member) throws Exception{
		joinDao.insertMember(member);
	}
	
	public joinBean userCheck(String id) throws Exception{
		return joinDao.userCheck(id);		
	}
	
	public void updateMember(joinBean member) throws Exception{
		joinDao.updateMember(member);
	}
	
	public void deleteMember(joinBean member) throws Exception{
		joinDao.deleteMember(member);
	}
	
	public joinBean findid(String email) throws Exception{
		return joinDao.findid(email);
	}
	
	public List<joinBean> member_list() throws Exception{
		return joinDao.member_list();
	}
	
	public int temp_pwd(Map map) throws Exception {
		return joinDao.temp_pwd(map);
	}
}
