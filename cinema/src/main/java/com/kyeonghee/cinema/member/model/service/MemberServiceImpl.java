package com.kyeonghee.cinema.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kyeonghee.cinema.member.model.dao.MemberDAO;
import com.kyeonghee.cinema.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO md;
	
	@Override
	public int insertMember(Member m) {
		// TODO Auto-generated method stub
		return md.insertMember(m);
	}

	@Override
	public Member selectOneMember(String memberId) {
		// TODO Auto-generated method stub
		return md.selectOneMember(memberId);
	}

}
