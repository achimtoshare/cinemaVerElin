package com.kyeonghee.cinema.member.model.service;

import com.kyeonghee.cinema.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member m);

	Member selectOneMember(String memberId);

}
