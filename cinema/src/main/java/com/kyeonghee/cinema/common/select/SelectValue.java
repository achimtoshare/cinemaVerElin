package com.kyeonghee.cinema.common.select;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SelectValue {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Map<String,Object>> selectLocal(){
		return sqlSession.selectList("common.selectLocal");
	}

	public List<Map<String, Object>> selectTheater(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("common.selectTheater", map);
	}

}
