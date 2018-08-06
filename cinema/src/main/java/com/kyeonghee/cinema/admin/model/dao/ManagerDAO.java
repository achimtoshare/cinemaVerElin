package com.kyeonghee.cinema.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kyeonghee.cinema.admin.model.vo.Manager;
import com.kyeonghee.cinema.movie.model.vo.Movie;

public interface ManagerDAO {

	Manager selectOneManager(String managerId);

	int insertMovie(Movie m);

	int updateSubImg(Movie m);

	List<Map<String, Object>> selectSchedule(Map<String, Object> map);

	Map<String, Object> selectTheaterMG(int nno);

	String selectManagerTheaterName(int tno);

	List<Map<String, Object>> searchMovie(String searchName);

	List<Map<String, Object>> selectRoomByTheater(int tno);

	int insertSchedule(Map<String, Object> map);

	Map<String, Object> selectSeatInfo(int rno);

	int updateSchedule(Map<String, Object> map);

	int deleteSchedule(int shno);

	List<Map<String, Object>> selectMovieAll();

	int updateMovie(Movie m);

	int deleteMovie(int mvno);

}
