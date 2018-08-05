package com.kyeonghee.cinema.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kyeonghee.cinema.admin.model.dao.ManagerDAO;
import com.kyeonghee.cinema.admin.model.vo.Manager;
import com.kyeonghee.cinema.movie.model.vo.Movie;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	private ManagerDAO mgd;
	@Override
	public Manager selectOneManager(String managerId) {
		// TODO Auto-generated method stub
		return mgd.selectOneManager(managerId);
	}
	@Override
	public int insertMovie(Movie m) {
		// TODO Auto-generated method stub
		return mgd.insertMovie(m);
	}
	@Override
	public int updateSugImg(Movie m) {
		// TODO Auto-generated method stub
		return mgd.updateSubImg(m);
	}
	@Override
	public List<Map<String, Object>> selectSchedule(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mgd.selectSchedule(map);
	}
	@Override
	public Map<String, Object> selectTheaterMG(int nno) {
		// TODO Auto-generated method stub
		return mgd.selectTheaterMG(nno);
	}
	@Override
	public String selectManagerTheaterName(int tno) {
		// TODO Auto-generated method stub
		return mgd.selectManagerTheaterName(tno);
	}
	@Override
	public List<Map<String, Object>> searchMovie(String searchName) {
		// TODO Auto-generated method stub
		return mgd.searchMovie(searchName);
	}
	@Override
	public List<Map<String, Object>> selectRoomByTheater(int tno) {
		// TODO Auto-generated method stub
		return mgd.selectRoomByTheater(tno);
	}
	@Override
	public int insertSchedule(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mgd.insertSchedule(map);
	}
	@Override
	public Map<String, Object> selectSeatInfo(int sno) {
		// TODO Auto-generated method stub
		return mgd.selectSeatInfo(sno);
	}
	@Override
	public int updateSchedule(Map<String, Object> map) {
		return mgd.updateSchedule(map);
	}
	@Override
	public int deleteSchedule(int shno) {
		return mgd.deleteSchedule(shno);
	}
	@Override
	public List<Map<String, Object>> selectMovieAll() {
		return mgd.selectMovieAll();
	}
	@Override
	public int updateMovie(Movie m) {
		// TODO Auto-generated method stub
		return mgd.updateMovie(m);
	}

}
