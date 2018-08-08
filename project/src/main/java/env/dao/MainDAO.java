package env.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import env.model.company;

@Repository
public class MainDAO {
	
	@Autowired
	private SqlSession sqlsession;
	
	public List arealist() {
		return sqlsession.selectList("Test.arealist");
	}
	
	public List arealist2() {
		return sqlsession.selectList("Test.arealist2");
	}
	
	public List areasublist(company com2) {
		return sqlsession.selectList("Test.areasublist",com2);
	}
	
	public String getcode(String state) {
		return sqlsession.selectOne("Test.getcode", state);
	}
	
	public List<company> getamount(company com) {
		List list = sqlsession.selectList("Test.getamount",com);
		return list;
	}
	
	public List<company> getamount2(company com) {
		List list = sqlsession.selectList("Test.getamount2",com);
		return list;
	}
	
	public List<company> getamount3(Map map) {
		List list = sqlsession.selectList("Test.getamount3", map);
		return list;
	}
	
	public List<company> getamount4(Map map) {
		List list = sqlsession.selectList("Test.getamount4", map);
		return list;
	}
	
	public List<company> getamountType(Map map) {
		List list = sqlsession.selectList("Test.getamountType", map);
		return list;
	}
	
	public int countstate(String state) {
		return sqlsession.selectOne("Test.countstate",state);
	}
	
	public List typelist() {
		return sqlsession.selectList("typelist");
	}
	
	public List<company> typesublist(Map map) {
		return sqlsession.selectList("typesublist", map);
	}
	
	//찾기
	public List<company> find(String find_val) {
		return sqlsession.selectList("Test.find",find_val);
	}
	public int cnt(String find_val) {
		return sqlsession.selectOne("Test.cnt",find_val);
	}
	
	public List<company> company_view(String com_name) {
		return sqlsession.selectList("Test.company_view", com_name);
	}
	
	public List<company> list(company com) {
		return sqlsession.selectList("Test.company_list", com);
	}
}
