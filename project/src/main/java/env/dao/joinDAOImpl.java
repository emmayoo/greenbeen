package env.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import env.model.joinBean;


@Repository
public class joinDAOImpl {

	@Autowired
	private SqlSession sqlSession;
	
	/***** 아이디 중복 체크 *****/
//	@Transactional
	public int checkId(String id) throws Exception {
		int re = -1;
		joinBean jb = (joinBean) sqlSession.selectOne("login.login_check", id);
		if (jb != null)
			re = 1; // 중복id
		return re;
	}

	public joinBean findpwd(Map pm) throws Exception {
		return (joinBean) sqlSession.selectOne("login.pwd_find", pm);
	}


	public void insertMember(joinBean m) throws Exception {

		sqlSession.insert("login.join", m);
	}

	public joinBean userCheck(String id) throws Exception {
		return (joinBean) sqlSession.selectOne("login.login_check", id);
	}

	/* 회원수정 */
//	@Transactional
	public void updateMember(joinBean member) throws Exception {
		sqlSession.update("login.member_edit", member);
	}

	public void deleteMember(joinBean delm) throws Exception {
		sqlSession.update("login.member_delete", delm);
	}
	
	public joinBean findid(String email) throws Exception {
		return sqlSession.selectOne("login.findid", email);
	}
	
	public List<joinBean> member_list() throws Exception {
		return sqlSession.selectList("login.member_list");
	}
	public int temp_pwd(Map map) throws Exception {
		return sqlSession.update("login.temp_pwd",map);
	}
}
