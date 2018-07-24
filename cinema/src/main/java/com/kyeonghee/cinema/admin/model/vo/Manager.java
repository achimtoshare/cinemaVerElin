package com.kyeonghee.cinema.admin.model.vo;

public class Manager {
	private int nno;
	private int tno;
	private String mgname;
	private String photo;
	private String managerId;
	private String pw;
	public Manager() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Manager(int nno, int tno, String mgname, String photo, String managerId, String pw) {
		super();
		this.nno = nno;
		this.tno = tno;
		this.mgname = mgname;
		this.photo = photo;
		this.managerId = managerId;
		this.pw = pw;
	}
	@Override
	public String toString() {
		return "Manager [nno=" + nno + ", tno=" + tno + ", mgname=" + mgname + ", photo=" + photo + ", managerId="
				+ managerId + ", pw=" + pw + "]";
	}
	public int getNno() {
		return nno;
	}
	public void setNno(int nno) {
		this.nno = nno;
	}
	public int getTno() {
		return tno;
	}
	public void setTno(int tno) {
		this.tno = tno;
	}
	public String getMgname() {
		return mgname;
	}
	public void setMgname(String mgname) {
		this.mgname = mgname;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getManagerId() {
		return managerId;
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	
	

}
