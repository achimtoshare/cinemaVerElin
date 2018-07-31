package com.kyeonghee.cinema.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kyeonghee.cinema.admin.model.service.ManagerService;
import com.kyeonghee.cinema.admin.model.vo.Manager;
import com.kyeonghee.cinema.common.select.SelectValue;
import com.kyeonghee.cinema.member.model.vo.Member;
import com.kyeonghee.cinema.movie.model.vo.Movie;

@SessionAttributes({"managerLoggedIn","managerTheater"})
@Controller
public class ManagerController {
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private ManagerService mgs;
	
	@Autowired
	private SelectValue commonSelect;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/manager/managerLogin.do")
	public ModelAndView adminLogin(@RequestParam(value="managerId") String managerId,@RequestParam(value="pw") String pw) {
		ModelAndView mav = new ModelAndView();
		
		String msg = "";
		String loc = "/";
		
		Manager mg = mgs.selectOneManager(managerId);
		
		
		//Member m = ms.selectOneMember(memberId);
		if(mg!=null) {
			if(bcryptPasswordEncoder.matches(pw, mg.getPw())) {
				logger.debug("로그인 성공");
				mav.addObject("managerLoggedIn", mg);
				String managerTheater=mgs.selectManagerTheaterName(mg.getTno());
				if(managerTheater==null) managerTheater="";
				mav.addObject("managerTheater", managerTheater);
				
				msg="로그인 성공";
				loc="/manager/movie";
			}else {
				msg="비밀번호가 틀렸습니다.";
			}
		}else {
			msg="존재하지 않는 관리자입니다.";
		}
		
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");

		return mav;
	}
	
	
	/********************** 관리자 페이지 이동 메소드 *****************************************/
	
	@RequestMapping("/manager/manager")
	public String moveManager() {
		return "manager/manager";
	}
	
	@RequestMapping("/manager/movie")
	public String moveManagerMovie() {
		return "manager/movie";
	}
	
	@RequestMapping("/manager/schedule")
	public ModelAndView moveManagerSchedule(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Manager mg=null;
		
		if(session!=null) {
			mg=(Manager)session.getAttribute("managerLoggedIn");
			
		} 
		
		mav.addObject("managerLoggedIn",mg);
		
		mav.setViewName("manager/schedule");
		
		return mav;
	}
	
	/*************** Manager Movie *****************************/
	@RequestMapping("/manager/movieEnroll.do")
	public ModelAndView insertMovie(Movie m, @RequestParam(value="posterImg") MultipartFile posterImg,
			@RequestParam(value="upFile") MultipartFile[] upFiles, @RequestParam(value="genres") String[] genre
			,HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		String imgs=""; //서브 이미지 파일
		String genres="";
		int i=0;
		
		System.out.println("$$$$$$movie정보="+m);
		
		//장르값 set
		for(String s:genre) {
			if(i!=0) genres+=",";
			genres+=s;
		}
		i=0;
		m.setGenre(genres);
		
		//포스터값 set
		String saveDirectory="";
		String renamedFileName="";
		
		try { 
			//1. 파일 업로드 처리 
			saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/movie");		
			if(!posterImg.isEmpty()) {
				//파일명 재생성
				String originalFileName = posterImg.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000); //0~9999
				renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
				
				try {
					posterImg.transferTo(new File(saveDirectory+"/"+renamedFileName)); //실제 저장하는 코드. 
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}
		
		}catch(Exception e) {
			throw new RuntimeException("포스터 업로드 오류");
		}
		
		m.setPoster(renamedFileName);
		
		
		
		
		//서브이미지를 제외하고 먼저 영화를 insert한다. 서브이미지를 안 넣을 수도 있기에 서브이미지가 있다면 update해줌 
		int result = mgs.insertMovie(m);
		
		if(result>0) {
			try { //최초 메소드 부른 곳은 controller이기때문에 여기서 에러 처리함. 
			//1. 파일 업로드 처리 
			//saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/movie");
			System.out.println("save"+saveDirectory);
			//********* MultipartFile을 이용한 파일 업로드 처리 로직 시작 ********//*
			for(MultipartFile f : upFiles) {
				
				if(!f.isEmpty()) {
					//파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random()*1000); //0~9999
					renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
					
					try {
						f.transferTo(new File(saveDirectory+"/"+renamedFileName)); //실제 저장하는 코드. 
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					if(i!=0) {
						imgs+=",";
					}
					imgs+=renamedFileName;
					i++;
				}
			}
			
			m.setSubImg(imgs);
			//서브이미지 업데이트하기
			result = mgs.updateSugImg(m);
	
			System.out.println("imgs="+imgs);
		}catch(Exception e) {
			throw new RuntimeException("영화 등록 오류");
		}
		}
			
		
		mav.setViewName("manager/movie");
		return mav;
		
		
	}
	
	@RequestMapping("/manager/theater")
	public ModelAndView moveTheater() {
		ModelAndView mav = new ModelAndView();
		
		
		mav.setViewName("manager/theater");
		return mav;
	}
	
	
	@RequestMapping("/manager/selectLocal.do")
	public ModelAndView selectLocal() {
		ModelAndView mav = new ModelAndView("jsonView");
		List<Map<String,Object>> list=commonSelect.selectLocal();
		
		System.out.println("locallist"+list);
		mav.addObject("list", list);
		return mav;
	}
	
	
	//특정 지역의 영화관 리스트 가져오기
	@RequestMapping("/manager/selectTheater.do")
	public ModelAndView selectTheater(@RequestParam(value="lno") int lno, @RequestParam(value="type") String type) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		Map<String,Object> map=new HashMap<>();
		map.put("lno", lno);
		if(type.equals("manager")) map.put("type", "manager");
		else if(type.equals("ticket")) map.put("type","ticket");
		else {
			
		}
		
		List<Map<String,Object>> list= commonSelect.selectTheater(map);
		mav.addObject("list",list);
		
		return mav;
	}
	
	
	
	
	/****************Manager Schedule ****************************************/
	@RequestMapping("/manager/checkSchedule.do/{date}")
	public ModelAndView selectSchedule(@PathVariable(value="date", required=false) String date) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		Map<String,Object> map = new HashMap<>();
		map.put("date", date);
		List<Map<String,Object>> list = selectSchedule(map); 
		mav.addObject("list",list);
		return mav;
		
	}
	
	
	//해당 날짜의 등록된 스케쥴을 가져오는 메소드
	private List<Map<String, Object>> selectSchedule(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mgs.selectSchedule(map);
	}


	@RequestMapping("/manager/searchMovie.do")
	public ModelAndView searchMovie(@RequestParam(value="searchName") String searchName) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<Map<String,Object>> list = mgs.searchMovie(searchName);
		
		mav.addObject("list", list);
		
		return mav;
	}
	
	// 담당 매니저 영화관의 상영관 정보 가져오기
	@RequestMapping("/manager/selectRoomByTheater.do")
	@ResponseBody
	public List<Map<String,Object>> selectRoomByTheater(@RequestParam(value="tno") int tno){
		List<Map<String,Object>> list = mgs.selectRoomByTheater(tno);
		
		return list;
	}
	
	
	@RequestMapping("/manager/scheduleEnroll.do")
	public ModelAndView insertSchedule(@RequestParam(value="mvno") int mvno, @RequestParam(value="rno") int rno,
			@RequestParam(value="sTime") String sTime, @RequestParam(value="eTime") String eTime,@RequestParam(value="sno",defaultValue="0") int sno) {
		ModelAndView mav = new ModelAndView();
		
		//좌석 값들 가져오기 
	/*	Map<String,Object> seatInfo=new HashMap<>();
		seatInfo = mgs.selectSeatInfo(sno);
		*/
		
		
		//중복 검사 함수
		boolean isDuplicate=checkDuplicateSchedule(sTime, eTime);
		
		
		if(!isDuplicate) {
			Map<String,Object> map = new HashMap<>();
			map.put("mvno", mvno);
			map.put("rno", rno);
			map.put("sTime", sTime);
			map.put("eTime", eTime);
	/*		map.put("seat", seatInfo.get("shape"));
			map.put("lseat", seatInfo.get("lseat"));*/
			System.out.println("#############map"+map);
			
			int result = mgs.insertSchedule(map);
			
			mav.setViewName("manager/schedule");
		}
		
		return mav;
	}

	
	// 등록/수정하려는 시간과 이미 존재하는 스케쥴이 중복되는지 검사하는 메소드.
	private boolean checkDuplicateSchedule(String sTime,String eTime) {
		
		/*, , ,;*/
		
		String date = sTime.substring(0, 10);
		Map<String,Object> map=new HashMap<>();
		map.put("date", date);
		List<Map<String,Object>> list =selectSchedule(map);
	
		
		int stotal_new = Integer.parseInt(sTime.substring(11, 13))*60+Integer.parseInt(sTime.substring(14));
		int etotal_new = Integer.parseInt(eTime.substring(11, 13))*60+Integer.parseInt(eTime.substring(14));
		
		for(Map<String,Object> sc:list) {
			int stotal = Integer.parseInt(sc.get("SHOUR").toString())*60+Integer.parseInt(sc.get("SMIN").toString());
			int etotal = Integer.parseInt(sc.get("EHOUR").toString())*60+Integer.parseInt(sc.get("EMIN").toString());
			
			//아예 안 겹치는 경우
			if(stotal>etotal_new || etotal<stotal_new) {
				logger.info("안겹칩니다. 시간~~");
				
			}else {
				logger.info("겹칩니다. 시간");
				return true;
			}
			
		}
		
		
		return false;
	}

}
