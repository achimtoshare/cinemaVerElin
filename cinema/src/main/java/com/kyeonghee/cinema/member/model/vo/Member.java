package com.kyeonghee.cinema.member.model.vo;

import java.sql.Date;

public class Member {
	private int mno;
	private String memberId;
	private String pw;
	private String mname;
	private String email;
	private String phone;
	private String gender;
	private String profileImg;
	private Date birth;
	private Date regDate;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(int mno, String memberId, String pw, String mname, String email, String phone, String gender,
			String profileImg, Date birth, Date regDate) {
		super();
		this.mno = mno;
		this.memberId = memberId;
		this.pw = pw;
		this.mname = mname;
		this.email = email;
		this.phone = phone;
		this.gender = gender;
		this.profileImg = profileImg;
		this.birth = birth;
		this.regDate = regDate;
	}

	
	public Member(String memberId, String pw, String profileImg) {
		super();
		this.memberId = memberId;
		this.pw = pw;
		this.profileImg = profileImg;
	}

	@Override
	public String toString() {
		return "Member [mno=" + mno + ", memberId=" + memberId + ", pw=" + pw + ", mname=" + mname + ", email=" + email
				+ ", phone=" + phone + ", gender=" + gender + ", profileImg=" + profileImg + ", birth=" + birth
				+ ", regDate=" + regDate + "]";
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	



}
