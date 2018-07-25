package com.kyeonghee.cinema.admin.model.dao;

import com.kyeonghee.cinema.admin.model.vo.Manager;
import com.kyeonghee.cinema.movie.model.vo.Movie;

public interface ManagerDAO {

	Manager selectOneManager(String managerId);

	int insertMovie(Movie m);

	int updateSubImg(Movie m);

}
