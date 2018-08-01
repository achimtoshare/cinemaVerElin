package com.kyeonghee.cinema.admin.model.dao;

import java.util.List;
import java.util.Map;

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

	@Override
	public List<Map<String, Object>> selectSchedule(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("manager.selectSchedule", map);
	}

	@Override
	public Map<String, Object> selectTheaterMG(int nno) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("manager.selectTheaterMG", nno);
	}

	@Override
	public String selectManagerTheaterName(int tno) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("manager.selectManagerTheaterName",tno);
	}

	@Override
	public List<Map<String, Object>> searchMovie(String searchName) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("manager.searchMovie", searchName);
	}

	@Override
	public List<Map<String, Object>> selectRoomByTheater(int tno) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("manager.selectRoomByTheater", tno);
	}

	@Override
	public int insertSchedule(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("manager.insertSchedule", map);
	}

	@Override
	public Map<String, Object> selectSeatInfo(int sno) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("manager.selectSeatInfo", sno);
	}

	@Override
	public int updateSchedule(Map<String, Object> map) {
		return sqlSession.update("manager.updateSchedule",map);
	}

	@Override
	public int deleteSchedule(int shno) {
		// TODO Auto-generated method stub
		return sqlSession.delete("manager.deleteSchedule", shno);
	}

}
