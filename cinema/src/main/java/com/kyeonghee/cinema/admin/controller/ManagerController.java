package com.kyeonghee.cinema.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kyeonghee.cinema.admin.model.service.ManagerService;
import com.kyeonghee.cinema.admin.model.vo.Manager;
import com.kyeonghee.cinema.member.model.vo.Member;
import com.kyeonghee.cinema.movie.model.vo.Movie;

@SessionAttributes("managerLoggedIn")
@Controller
public class ManagerController {
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private ManagerService as;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/manager/managerLogin.do")
	public ModelAndView adminLogin(@RequestParam(value="managerId") String managerId,@RequestParam(value="pw") String pw) {
		ModelAndView mav = new ModelAndView();
		
		String msg = "";
		String loc = "/";
		
		Manager mg = as.selectOneManager(managerId);
		
		
		//Member m = ms.selectOneMember(memberId);
		if(mg!=null) {
			if(bcryptPasswordEncoder.matches(pw, mg.getPw())) {
				logger.debug("로그인 성공");
				mav.addObject("managerLoggedIn", mg);
				msg="로그인 성공";
				loc="/manager/manager";
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
	
	
	@RequestMapping("/manager/manager")
	public String moveManager() {
		return "manager/manager";
	}
	
	@RequestMapping("/manager/movie")
	public String moveManagerMovie() {
		return "manager/movie";
	}
	
	/*************** Manager Movie *****************************/
	@RequestMapping("/manager/movieEnroll.do")
	public ModelAndView insertMovie(Movie m, @RequestParam(value="posterImg") MultipartFile posterImg, @RequestParam(value="upFile") MultipartFile[] upfiles) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("$$$$$$movie정보="+m);
		
		mav.setViewName("manager/movie");
		return mav;
		
		
	}

}
