package com.kyeonghee.cinema.admin.model.service;

import com.kyeonghee.cinema.admin.model.vo.Manager;
import com.kyeonghee.cinema.movie.model.vo.Movie;

public interface ManagerService {

	Manager selectOneManager(String managerId);

	int insertMovie(Movie m);

	int updateSugImg(Movie m);

}
