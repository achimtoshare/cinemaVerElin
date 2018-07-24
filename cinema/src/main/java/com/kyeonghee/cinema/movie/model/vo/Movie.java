package com.kyeonghee.cinema.movie.model.vo;

import java.sql.Date;

public class Movie {
	private int mvno;
	private String mvname;
	private String ename;
	private String grade;
	private int runtime;
	private String director;
	private String actor;
	private String genre;
	private String poster;
	private String story;
	private String subImg;
	private String trailer;
	private String status;
	private Date relDate;
	private Date regDate;
	public Movie() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Movie(int mvno, String mvname, String ename, String grade, int runtime, String director, String actor,
			String genre, String poster, String story, String subImg, String trailer, String status, Date relDate,
			Date regDate) {
		super();
		this.mvno = mvno;
		this.mvname = mvname;
		this.ename = ename;
		this.grade = grade;
		this.runtime = runtime;
		this.director = director;
		this.actor = actor;
		this.genre = genre;
		this.poster = poster;
		this.story = story;
		this.subImg = subImg;
		this.trailer = trailer;
		this.status = status;
		this.relDate = relDate;
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "Movie [mvno=" + mvno + ", mvname=" + mvname + ", ename=" + ename + ", grade=" + grade + ", runtime="
				+ runtime + ", director=" + director + ", actor=" + actor + ", genre=" + genre + ", poster=" + poster
				+ ", story=" + story + ", subImg=" + subImg + ", trailer=" + trailer + ", status=" + status
				+ ", relDate=" + relDate + ", regDate=" + regDate + "]";
	}
	public int getMvno() {
		return mvno;
	}
	public void setMvno(int mvno) {
		this.mvno = mvno;
	}
	public String getMvname() {
		return mvname;
	}
	public void setMvname(String mvname) {
		this.mvname = mvname;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getRuntime() {
		return runtime;
	}
	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getStory() {
		return story;
	}
	public void setStory(String story) {
		this.story = story;
	}
	public String getSubImg() {
		return subImg;
	}
	public void setSubImg(String subImg) {
		this.subImg = subImg;
	}
	public String getTrailer() {
		return trailer;
	}
	public void setTrailer(String trailer) {
		this.trailer = trailer;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getRelDate() {
		return relDate;
	}
	public void setRelDate(Date relDate) {
		this.relDate = relDate;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	
	
	

}
