package com.kyeonghee.cinema.admin.model.dao;

import com.kyeonghee.cinema.admin.model.vo.Manager;

public interface ManagerDAO {

	Manager selectOneManager(String managerId);

}
