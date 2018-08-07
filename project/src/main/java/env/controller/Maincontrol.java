package env.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import env.model.company;
import env.service.Mainservice;

@Controller
public class Maincontrol {

	@Autowired
	private Mainservice ms;

	@RequestMapping(value = "first.env")
	public String firstview(String which, Model model) {
		return "first";
	}
	
	@RequestMapping(value = "main.env")
	public String main(String which, Model model) {
		model.addAttribute("which", which);
		return "main";
	}

	@RequestMapping(value = "area.env")
	public String area(Model model) {
		return "area";
	}
	@RequestMapping(value = "part.env")
	public String part(Model model) {
		return "part";
	}
	@RequestMapping(value = "object.env")
	public String object(Model model) {
		return "object";
	}

	@RequestMapping(value = "makelist.env")
	// @ResponseBody
	public String makelist(String which, Model model) {
		List list = new ArrayList();
		TreeSet ts = new TreeSet();
		System.out.println("which3=" + which);
		System.out.println("controller: makelist.env");
		
		if (which.equals("area")) {
			System.out.println("지역별");
			list = (List) ms.arealist();
		}
		if (which.equals("part")) {
			System.out.println("업종별");
			list = (List) ms.typelist();
		}
		if (which.equals("obj")) {
			System.out.println("물질별");
			//list = (List) ms.objlist();
		}
		System.out.println("list=" + list);

		for (int i = 0; i < list.size(); i++) {
			ts.add(list.get(i));
		}
		System.out.println("treeset=" + ts);
		model.addAttribute("list", ts);

		return "makelist";
	}

	@RequestMapping(value = "makesublist.env")
	public String makesublist(String state, String obj, String year, company com, Model model) {
		List list = new ArrayList();
		List<company> list2 = new ArrayList();
		List list3 = new ArrayList();

		TreeSet ts = new TreeSet();
		TreeSet ts2 = new TreeSet();
		company total = new company();
		company com2 = new company();
		int y = 0;
		int count=0;

		System.out.println("state&year=" + state+year);
		System.out.println("obj=" + obj);
		
		System.out.println("controller: makesublist.env");
		System.out.println("list=" + list);
		
		
		com2.setCom_addr1(state);
		
		list = (List) ms.areasublist(com2);
		
		String code = ms.getcode(state);
		System.out.println("code" + code);

		for (int i = 0; i < list.size(); i++) {
			ts.add(list.get(i));
		}
		
		
		System.out.println("treeset=" + ts);
		Iterator iterator;
		Iterator iterator2;
		iterator = ts.iterator();
				
		while(iterator.hasNext()) {
			String first = (String) iterator.next();
			ts2.add(first.trim()); 
		}
		
		iterator2 = ts2.iterator();

		if(obj != null) {
			
			while (iterator2.hasNext()) {
	
				String x = (String) iterator2.next();
	
				System.out.println(state);
				System.out.println(x);
				Map map = new HashMap();
				map.put("com_addr1", state);
				map.put("com_addr2", x);
				map.put("com_year", year);
	
				List<company> li = ms.getamount3(map);
				
					count = 0;	
					if(li.size()>=2) {
						count = 2;			
					}
					
				if (count == 2) {
					for (int j = 0; j < li.size(); j++) {
						company sqlcom = li.get(j);
						if(obj.equals("o1")) {
							total.setCom_water(total.getCom_water() + sqlcom.getCom_water());
						}else if(obj.equals("o1_2")) {
							total.setCom_rewater(total.getCom_rewater() + sqlcom.getCom_rewater());
						}else if(obj.equals("o2")) {
							total.setCom_air(total.getCom_air() + sqlcom.getCom_air());
						}else if(obj.equals("o3")) {
							total.setCom_wp(total.getCom_wp() + sqlcom.getCom_wp());
						}else if(obj.equals("o4")) {
							total.setCom_waste(total.getCom_waste() + sqlcom.getCom_waste());
						}else if(obj.equals("o4_2")) {
							total.setCom_rewaste(total.getCom_rewaste() + sqlcom.getCom_rewaste());
						}else if(obj.equals("o5")) {
							total.setCom_chemical(total.getCom_chemical() + sqlcom.getCom_chemical());
						}else if(obj.equals("o6")) {
							total.setCom_energy(total.getCom_energy() + sqlcom.getCom_energy());
						}
					}
					//y에 넣기
					if(obj.equals("o1")) {
						y = total.getCom_water();
					}else if(obj.equals("o1_2")) {
						y = total.getCom_rewater();
					}else if(obj.equals("o2")) {
						y = total.getCom_air();
					}else if(obj.equals("o3")) {
						y = total.getCom_wp();
					}else if(obj.equals("o4")) {
						y = total.getCom_waste();
					}else if(obj.equals("o4_2")) {
						y = total.getCom_rewaste();
					}else if(obj.equals("o5")) {
						y = total.getCom_chemical();
					}else if(obj.equals("o6")) {
						y = total.getCom_energy();
					}
					
					list3.add(y);
					total.setCom_water(0);
					total.setCom_rewater(0);
					total.setCom_air(0);
					total.setCom_wp(0);
					total.setCom_waste(0);
					total.setCom_rewaste(0);
					total.setCom_chemical(0);
					total.setCom_energy(0);
					
				}else {
					for (int j = 0; j < li.size(); j++) {			
						company sqlcom = li.get(j);
						
						if(obj.equals("o1")) {
							total.setCom_water(sqlcom.getCom_water());
							y = total.getCom_water();	
						}if(obj.equals("o1_2")) {
							total.setCom_rewater(sqlcom.getCom_rewater());
							y = total.getCom_rewater();	
						}else if(obj.equals("o2")) {
							total.setCom_air(sqlcom.getCom_air());
							y = total.getCom_air();
						}else if(obj.equals("o3")) {
							//System.out.println("elsewp");
							total.setCom_wp(sqlcom.getCom_wp());
							y = total.getCom_wp();
						}else if(obj.equals("o4")) {
							total.setCom_waste(sqlcom.getCom_waste());
							y = total.getCom_waste();
						}else if(obj.equals("o4_2")) {
							total.setCom_rewaste(sqlcom.getCom_rewaste());
							y = total.getCom_rewaste();
						}else if(obj.equals("o5")) {
							total.setCom_chemical(sqlcom.getCom_chemical());
							y = total.getCom_chemical();
						}else if(obj.equals("o6")) {
							total.setCom_energy(sqlcom.getCom_energy());
							y = total.getCom_energy();
						}

					list3.add(y);
					total.setCom_water(0);
					total.setCom_rewater(0);
					total.setCom_air(0);
					total.setCom_wp(0);
					total.setCom_waste(0);
					total.setCom_rewaste(0);
					total.setCom_chemical(0);
					total.setCom_energy(0);
	
				}
	
			}
		}
		}

		System.out.println("LIST3" + list3);

		String marker = "x";
		String marker2 = "y";

		model.addAttribute("list", ts2);
		model.addAttribute("code", code);
		model.addAttribute("result", list3);
		model.addAttribute("marker", marker);
		model.addAttribute("marker2", marker2);

		return "makelist";
	}

	@RequestMapping(value = "amount.env")
	public String amount(company com, Model model) {
		company total = new company();
		System.out.println("addr2=" + com.getCom_addr2());	
/*		int count = ms.countstate(com.getCom_addr1());
		System.out.println("count=" + count);*/
		System.out.println("year=" + com.getCom_year());
		System.out.println("obj=" + com.getObj());
		System.out.println("controller: amount.env");

		if (com.getObj() == null) {
			List<company> list = ms.getamount(com);

			int sum = 0;
			for (int i = 0; i < list.size(); i++) {
				company sqlcom = list.get(i);
				// System.out.println("com" + i + "= " + sqlcom.getCom_water());

				total.setCom_water(total.getCom_water() + sqlcom.getCom_water()); // 총 용수량
				total.setCom_energy(total.getCom_energy() + sqlcom.getCom_energy()); // 총 에너지량
				total.setCom_air(total.getCom_air() + sqlcom.getCom_air()); // 총 대기오염
				total.setCom_wp(total.getCom_wp() + sqlcom.getCom_wp()); // 총 수질오염
				total.setCom_waste(total.getCom_waste() + sqlcom.getCom_waste()); // 총 폐기물
				total.setCom_chemical(total.getCom_chemical() + sqlcom.getCom_chemical()); // 총 화학물질

				total.setCom_rewater(total.getCom_rewater() + sqlcom.getCom_rewater()); // 총 용수 재활용 비율
				total.setCom_rewaste(total.getCom_rewaste() + sqlcom.getCom_rewaste()); // 총 폐기물 재활용 비율

			}
			System.out.println(total.getCom_water());
			model.addAttribute("totalDTO", total);
		} 
		return "objcal";
	}

	
	@RequestMapping(value = "typesublist.env")
	public String typesublist(company com, Model model, String type, String year) {
		List<company> list = new ArrayList();
		company total = new company();
		
		System.out.println("type=" + type+year);
		System.out.println("controller: typesublist.env");
		
		type = type.trim();
				
		Map map = new HashMap();
		map.put("com_type", type);
		map.put("com_year", year);
		
		list = ms.typesublist(map);
		
		System.out.println(list);
		System.out.println(list.size());

			for (int i = 0; i < list.size(); i++) {
				company sqlcom = list.get(i);
				
				total.setCom_water(total.getCom_water() + sqlcom.getCom_water()); // 총 용수량
				total.setCom_energy(total.getCom_energy() + sqlcom.getCom_energy()); // 총 에너지량
				total.setCom_air(total.getCom_air() + sqlcom.getCom_air()); // 총 대기오염
				total.setCom_wp(total.getCom_wp() + sqlcom.getCom_wp()); // 총 수질오염
				total.setCom_waste(total.getCom_waste() + sqlcom.getCom_waste()); // 총 폐기물
				total.setCom_chemical(total.getCom_chemical() + sqlcom.getCom_chemical()); // 총 화학물질

				total.setCom_rewater(total.getCom_rewater() + sqlcom.getCom_rewater()); // 총 용수 재활용 비율
				total.setCom_rewaste(total.getCom_rewaste() + sqlcom.getCom_rewaste()); // 총 폐기물 재활용 비율

			}
			System.out.println(total.getCom_water());
			model.addAttribute("totalDTO", total);
			return "objcal";
	}
	
	@RequestMapping(value = "objsublist.env")
	public String objsublist(String obj, String year, company com, Model model) {
		List list = new ArrayList();
		List list3 = new ArrayList();

		TreeSet ts = new TreeSet();
		TreeSet ts2 = new TreeSet();
		company total = new company();
		
		int y = 0;
		int count=0;
		
		System.out.println("controller: objsublist.env");

		list = (List) ms.arealist2();
		System.out.println(list);
	
		for (int i = 0; i < list.size(); i++) {
			ts.add(list.get(i));
		}

		Iterator iterator;
		Iterator iterator2;
		iterator = ts.iterator();
		
		while(iterator.hasNext()) {
			String first = (String) iterator.next();
			ts2.add(first.trim()); 
		}

		
		System.out.println("treeset2"+ts2);
		iterator2 = ts2.iterator();
				
			if(obj != null) {
			
			while (iterator2.hasNext()) {
	
				String com_addr1 = (String) iterator2.next();
				
				System.out.println(com_addr1);
				
				Map map = new HashMap();
				map.put("com_addr1", com_addr1);
				map.put("com_year", year);
	
				List<company> li = ms.getamount4(map);
							
					count = 0;	
					if(li.size()>=2) {
						count = 2;			
					}
					
				if (count == 2) {
					for (int j = 0; j < li.size(); j++) {
						company sqlcom = li.get(j);
						if(obj.equals("com_water")) {
							System.out.println("com_water들어옴");
							total.setCom_water(total.getCom_water() + sqlcom.getCom_water());
						}else if(obj.equals("com_rewater")) {
							total.setCom_rewater(total.getCom_rewater() + sqlcom.getCom_rewater());
						}else if(obj.equals("com_air")) {
							total.setCom_air(total.getCom_air() + sqlcom.getCom_air());
						}else if(obj.equals("com_wp")) {
							total.setCom_wp(total.getCom_wp() + sqlcom.getCom_wp());
						}else if(obj.equals("com_waste")) {
							total.setCom_waste(total.getCom_waste() + sqlcom.getCom_waste());
						}else if(obj.equals("com_rewaste")) {
							total.setCom_rewaste(total.getCom_rewaste() + sqlcom.getCom_rewaste());
						}else if(obj.equals("com_chemical")) {
							total.setCom_chemical(total.getCom_chemical() + sqlcom.getCom_chemical());
						}else if(obj.equals("com_energy")) {
							total.setCom_energy(total.getCom_energy() + sqlcom.getCom_energy());
						}
					}
					//y에 넣기
					if(obj.equals("com_water")) {
						y = total.getCom_water();
					}else if(obj.equals("com_rewater")) {
						y = total.getCom_rewater();
					}else if(obj.equals("com_air")) {
						y = total.getCom_air();
					}else if(obj.equals("com_wp")) {
						y = total.getCom_wp();
					}else if(obj.equals("com_waste")) {
						y = total.getCom_waste();
					}else if(obj.equals("com_rewaste")) {
						y = total.getCom_rewaste();
					}else if(obj.equals("com_chemical")) {
						y = total.getCom_chemical();
					}else if(obj.equals("com_energy")) {
						y = total.getCom_energy();
					}
					
					list3.add(y);
					total.setCom_water(0);
					total.setCom_rewater(0);
					total.setCom_air(0);
					total.setCom_wp(0);
					total.setCom_waste(0);
					total.setCom_rewaste(0);
					total.setCom_chemical(0);
					total.setCom_energy(0);
					
				}else {
					for (int j = 0; j < li.size(); j++) {			
						company sqlcom = li.get(j);
						
						if(obj.equals("com_water")) {	
							total.setCom_water(sqlcom.getCom_water());
							y = total.getCom_water();	
						}else if(obj.equals("com_rewater")) {
							total.setCom_rewater(total.getCom_rewater() + sqlcom.getCom_rewater());
							y = total.getCom_rewater();
						}else if(obj.equals("com_air")) {
							total.setCom_air(total.getCom_air() + sqlcom.getCom_air());
							y = total.getCom_air();
						}else if(obj.equals("com_wp")) {
							System.out.println("elsewp");
							total.setCom_wp(total.getCom_wp() + sqlcom.getCom_wp());
							y = total.getCom_wp();
						}else if(obj.equals("com_waste")) {
							total.setCom_waste(total.getCom_waste() + sqlcom.getCom_waste());
							y = total.getCom_waste();
						}else if(obj.equals("com_rewaste")) {
							total.setCom_rewaste(total.getCom_rewaste() + sqlcom.getCom_rewaste());
							y = total.getCom_rewaste();
						}else if(obj.equals("com_chemical")) {
							total.setCom_chemical(total.getCom_chemical() + sqlcom.getCom_chemical());
							y = total.getCom_chemical();
						}else if(obj.equals("com_energy")) {
							total.setCom_energy(total.getCom_energy() + sqlcom.getCom_energy());
							y = total.getCom_energy();
						}

					list3.add(y);
					total.setCom_water(0);
					total.setCom_rewater(0);
					total.setCom_air(0);
					total.setCom_wp(0);
					total.setCom_waste(0);
					total.setCom_rewaste(0);
					total.setCom_chemical(0);
					total.setCom_energy(0);
	
				}
	
			}
		}
		}

		System.out.println("LIST3" + list3);

		String marker = "x";
		String marker2 = "y";

		model.addAttribute("list", ts2);
		
		model.addAttribute("result", list3);
		model.addAttribute("marker", marker);
		model.addAttribute("marker2", marker2); 
			
		return "objmakelist";
	}
	
	@RequestMapping(value = "objtypelist.env")
	public String objtypelist(String obj, String year, company com, Model model) {
		List list = new ArrayList();
		List list3 = new ArrayList();

		TreeSet ts = new TreeSet();
		company total = new company();
		
		int y = 0;
		int count=0;

	
		System.out.println("controller: objtypelist.env"+year);

		list = (List) ms.typelist();

		for (int i = 0; i < list.size(); i++) {
			ts.add(list.get(i));
		}

		System.out.println("treeset=" + ts);
		
		Iterator iterator;
		iterator = ts.iterator();
						
		if(obj != null) {
			
			while (iterator.hasNext()) {
	
				String com_type = (String) iterator.next();
				
				System.out.println(com_type);
				System.out.println(year);
				
				Map map = new HashMap();
				map.put("com_type", com_type);
				map.put("com_year", year);
	
				List<company> li = ms.getamountType(map);
				
				System.out.println(li);
				
					count = 0;	
					if(li.size()>=2) {
						count = 2;			
					}
					
				if (count == 2) {
					for (int j = 0; j < li.size(); j++) {
						company sqlcom = li.get(j);
						if(obj.equals("com_water")) {
							System.out.println("com_water들어옴");
							total.setCom_water(total.getCom_water() + sqlcom.getCom_water());
						}else if(obj.equals("com_rewater")) {
							total.setCom_rewater(total.getCom_rewater() + sqlcom.getCom_rewater());
						}else if(obj.equals("com_air")) {
							total.setCom_air(total.getCom_air() + sqlcom.getCom_air());
						}else if(obj.equals("com_wp")) {
							total.setCom_wp(total.getCom_wp() + sqlcom.getCom_wp());
						}else if(obj.equals("com_waste")) {
							total.setCom_waste(total.getCom_waste() + sqlcom.getCom_waste());
						}else if(obj.equals("com_rewaste")) {
							total.setCom_rewaste(total.getCom_rewaste() + sqlcom.getCom_rewaste());
						}else if(obj.equals("com_chemical")) {
							total.setCom_chemical(total.getCom_chemical() + sqlcom.getCom_chemical());
						}else if(obj.equals("com_energy")) {
							total.setCom_energy(total.getCom_energy() + sqlcom.getCom_energy());
						}
					}
					
					//y에 넣기
					if(obj.equals("com_water")) {
						y = total.getCom_water();
					}else if(obj.equals("com_rewater")) {
						y = total.getCom_rewater();
					}else if(obj.equals("com_air")) {
						y = total.getCom_air();
					}else if(obj.equals("com_wp")) {
						y = total.getCom_wp();
					}else if(obj.equals("com_waste")) {
						y = total.getCom_waste();
					}else if(obj.equals("com_rewaste")) {
						y = total.getCom_rewaste();
					}else if(obj.equals("com_chemical")) {
						y = total.getCom_chemical();
					}else if(obj.equals("com_energy")) {
						y = total.getCom_energy();
					}
					
					list3.add(y);
					total.setCom_water(0);
					total.setCom_rewater(0);
					total.setCom_air(0);
					total.setCom_wp(0);
					total.setCom_waste(0);
					total.setCom_rewaste(0);
					total.setCom_chemical(0);
					total.setCom_energy(0);
					
				}else {
					for (int j = 0; j < li.size(); j++) {			
						company sqlcom = li.get(j);
						
						if(obj.equals("com_water")) {	
							total.setCom_water(sqlcom.getCom_water());
							y = total.getCom_water();	
						}else if(obj.equals("com_rewater")) {
							total.setCom_rewater(total.getCom_rewater() + sqlcom.getCom_rewater());
							y = total.getCom_rewater();
						}else if(obj.equals("com_air")) {
							total.setCom_air(total.getCom_air() + sqlcom.getCom_air());
							y = total.getCom_air();
						}else if(obj.equals("com_wp")) {
							System.out.println("elsewp");
							total.setCom_wp(total.getCom_wp() + sqlcom.getCom_wp());
							y = total.getCom_wp();
						}else if(obj.equals("com_waste")) {
							total.setCom_waste(total.getCom_waste() + sqlcom.getCom_waste());
							y = total.getCom_waste();
						}else if(obj.equals("com_rewaste")) {
							total.setCom_rewaste(total.getCom_rewaste() + sqlcom.getCom_rewaste());
							y = total.getCom_rewaste();
						}else if(obj.equals("com_chemical")) {
							total.setCom_chemical(total.getCom_chemical() + sqlcom.getCom_chemical());
							y = total.getCom_chemical();
						}else if(obj.equals("com_energy")) {
							total.setCom_energy(total.getCom_energy() + sqlcom.getCom_energy());
							y = total.getCom_energy();
						}

					list3.add(y);
					total.setCom_water(0);
					total.setCom_rewater(0);
					total.setCom_air(0);
					total.setCom_wp(0);
					total.setCom_waste(0);
					total.setCom_rewaste(0);
					total.setCom_chemical(0);
					total.setCom_energy(0);
	
				}
	
			}
		}
		}
		
		System.out.println("LIST3" + list3);

		String marker = "x";
		String marker2 = "y";

		model.addAttribute("list", ts);
		
		model.addAttribute("result", list3);
		model.addAttribute("marker", marker);
		model.addAttribute("marker2", marker2); 
			
		return "objmakelist";
	}
		
	//yeonjoo
	@RequestMapping("/summary.env")
	public String summary(String id,Model model){
		System.out.println("id="+id);
		model.addAttribute("id",id);
		//환경정보공개개요
		if(id.equals("summary")) return "/intro/summary";
		if(id.equals("purpose")) return "/intro/purpose";
		if(id.equals("procedure")) return "/intro/procedure";
		if(id.equals("information")) return "/intro/information";
		//알림마당
		if(id.equals("files_list")) return "redirect:/files_list.env?id="+id;
		if(id.equals("notice_list")) return "redirect:/notice_list.env?id="+id;
		if(id.equals("ad_list")) return "redirect:/ad_com_list.env?id=ad_com_list";
		if(id.equals("ad_com_list")) return "redirect:/ad_com_list.env?id="+id;
		if(id.equals("ad_best_list")) return "redirect:/ad_best_list.env?id="+id;
		if(id.equals("know_list")) return "redirect:/know_news_list.env?id=know_news_list";
		if(id.equals("know_news_list")) return "redirect:/know_news_list.env?id="+id;
		if(id.equals("know_quiz_list")) return "redirect:/know_quiz_list.env?id="+id;
		if(id.equals("question_list")) return "redirect:/question_list.env?id="+id;
		//통계
		if(id.equals("area")) return "redirect:/area.env";
		if(id.equals("object")) return "redirect:/object.env";
		if(id.equals("part")) return "redirect:/part.env";
		return null;
	}

	@RequestMapping("download.env")
	public void download(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		// response.setCharacterEncoding("utf-8");

		System.out.println("download()...");
		String fname = request.getParameter("fname");
		System.out.println("fname = " + fname);

		String DownloadPath = request.getRealPath("upload");
		String path = DownloadPath + "\\" + fname;
		System.out.println("path=" + path);

		File file = new File(path);
		String downName = file.getName(); //다운로드 받을 파일명을 절대경로로  구해옴

		// 이 부분이 한글 파일명이 깨지는 것을 방지해 줍니다
		downName = new String(downName.getBytes("utf-8"), "iso-8859-1");

		// octet-stream은 8비트로 된 일련의 데이터를 뜻합니다. 지정되지 않은 파일 형식을 의미합니다. 
		// response.setHeader("Content-Type", "application/octet-stream");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + downName + "\"");

		FileInputStream in = null;
		OutputStream out = null;
		try {
			in = new FileInputStream(file); //경로 안에 있는 파일 읽어오기
			out = response.getOutputStream(); //출력 stream 만들기
			FileCopyUtils.copy(in, out); //읽어온거 출력하기 (/w. copy 함수)
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	
	@RequestMapping("/company_view.env")
	public String company_view(String com_name,Model model){
		List<company> com = ms.company_view(com_name);
		model.addAttribute("com_name",com_name);
		model.addAttribute("company",com);
		return "company_view";
	}
	
	@RequestMapping("/logincheck.env")
	public String question_re(HttpServletRequest request){
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		if (id == null || id.equals(""))  {	
		return "redirect:loginForm.env?inter=inter";
	}
		return null;
	}
	
}
