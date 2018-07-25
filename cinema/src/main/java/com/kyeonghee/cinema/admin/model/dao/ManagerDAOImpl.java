package com.kyeonghee.cinema.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kyeonghee.cinema.admin.model.vo.Manager;
import com.kyeonghee.cinema.movie.model.vo.Movie;

@Repository
public class ManagerDAOImpl implements ManagerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Manager selectOneManager(String managerId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("manager.selectOneManager", managerId);
	}

	@Override
	public int insertMovie(Movie m) {
		// TODO Auto-generated method stub
		return sqlSession.insert("manager.inserMovie", m);
	}

	@Override
	public int updateSubImg(Movie m) {
		// TODO Auto-generated method stub
		return sqlSession.update("manager.updateSubImg", m);
	}

}
