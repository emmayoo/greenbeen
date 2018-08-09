package env.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import env.dao.MainDAO;
import env.model.company;

@Service
public class Mainservice {
	
	@Autowired
	private MainDAO md;
	
	public List arealist() {
		return md.arealist();
	}
	
	public List arealist2() {
		return md.arealist2();
	}
	
	public List areasublist(company com2) {
		return md.areasublist(com2);
	}
	
	public String getcode(String state) {
		return md.getcode(state);
	}
	
	public List<company> getamount(company com) {
		return md.getamount(com);
	}
	
	public List<company> getamount2(company com) {
		return md.getamount2(com);
	}
	
	public List<company> getamount3(Map map) {
		return md.getamount3(map);
	}

	public List<company> getamount4(Map map) {
		return md.getamount4(map);
	}
	
	public List<company> getamountType(Map map) {
		return md.getamountType(map);
	}
		
	public int countstate(String state) {
		return md.countstate(state);
	}
	
	public List typelist() {
		return md.typelist();
	}
	
	public List<company> typesublist(Map map) {
		return md.typesublist(map);
	}
	
	//찾기
	public List<company> find(String find_val) {
		return md.find(find_val);
	}
	public List<company> company_view(String com_name) {
		return md.company_view(com_name);
	}
	public List<company> list(company com) {
		return md.list(com);
	}
	
}
