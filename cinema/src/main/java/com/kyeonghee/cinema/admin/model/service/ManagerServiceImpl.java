package com.kyeonghee.cinema.admin.model.service;

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

}
