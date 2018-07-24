package com.kyeonghee.cinema.member.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kyeonghee.cinema.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public int insertMember(Member m) {
		// TODO Auto-generated method stub
		return session.insert("member.insertMember",m);
	}

	@Override
	public Member selectOneMember(String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectOneMember", memberId);
	}

}
