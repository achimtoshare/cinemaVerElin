package com.kyeonghee.cinema.member.model.dao;

import com.kyeonghee.cinema.member.model.vo.Member;

public interface MemberDAO {

	int insertMember(Member m);

	Member selectOneMember(String memberId);

}
