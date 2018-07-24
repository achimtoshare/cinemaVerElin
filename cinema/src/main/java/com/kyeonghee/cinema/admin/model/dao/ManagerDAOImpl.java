package com.kyeonghee.cinema.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kyeonghee.cinema.admin.model.vo.Manager;

@Repository
public class ManagerDAOImpl implements ManagerDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Manager selectOneManager(String managerId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("manager.selectOneManager", managerId);
	}

}
