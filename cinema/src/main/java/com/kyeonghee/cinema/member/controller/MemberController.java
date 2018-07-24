package com.kyeonghee.cinema.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kyeonghee.cinema.member.model.service.MemberService;
import com.kyeonghee.cinema.member.model.service.MemberServiceImpl;
import com.kyeonghee.cinema.member.model.vo.Member;

@SessionAttributes({ "memberLoggedIn","managerLoggedIn" })

@Controller
public class MemberController {
	
	@Autowired
	private MemberService ms;
	
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@RequestMapping("/member/memberEnroll")
	public String memberEnroll() {
		return "member/memberEnroll";
	}
	
	/* 회원 가입 */
	@RequestMapping("/member/memberEnrollEnd.do")
	public ModelAndView memberEnrollEnd(Member m, @RequestParam(value="upFile") MultipartFile f,HttpServletRequest request ) {
		
		ModelAndView mav= new ModelAndView();
		
		/* 비밀번호 암호화 */
		String encodepwd = bcryptPasswordEncoder.encode(m.getPw());
		m.setPw(encodepwd);
		
		System.out.println("암호화된 비번"+encodepwd);
		
		String saveDirectory="";
		String renamedFileName="";
		
		
		try { 
			//1. 파일 업로드 처리 
			saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/member");		
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
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				m.setProfileImg(renamedFileName);
				
			}
		
		}catch(Exception e) {
			throw new RuntimeException("이미지 등록 오류");
		}
		System.out.println("member"+m);
		
		int result = ms.insertMember(m);
		
		
		
		
		if(result>0) {
			mav.addObject("username",m.getMname());
		
			mav.setViewName("member/memberEnrollComplete");
		}else {
			mav.addObject("msg","회원 가입 실패했습니다");
			mav.addObject("loc","/");
			mav.setViewName("common/msg");
		}
		
		return mav;
	}
	
	//로그인
	@RequestMapping("/member/memberLogin.do")
	public ModelAndView memberLogin(@RequestParam(value="memberId") String memberId, @RequestParam(value="pw") String pw) {
		ModelAndView mav = new ModelAndView();
		String msg = "";
		String loc = "/";
		
		
		Member m = ms.selectOneMember(memberId);
		if(m!=null) {
			if(bcryptPasswordEncoder.matches(pw, m.getPw())) {
				logger.debug("로그인 성공");
				mav.addObject("memberLoggedIn", m);
				msg="로그인 성공";
			}else {
				msg="비밀번호가 틀렸습니다.";
			}
		}else {
			msg="존재하지 않는 회원입니다.";
		}
		
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");

		return mav;
	}
	
	//로그 아웃
	@RequestMapping("/member/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus, HttpServletRequest request) {
		if (!sessionStatus.isComplete())
			sessionStatus.setComplete();

		return "redirect:/";
	}

}
