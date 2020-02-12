package com.example.demo.dao;

import com.example.demo.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.Map;
@Mapper
@Repository
public interface UserMapper {
	public User findUserByName(String name) throws Exception;
	public boolean createNewUser(User u) throws Exception;

	public User findUserByID(int id)throws Exception;
	
	public boolean changeSpace(Map<String, Object> map) throws Exception;
	
	public User getUserBySrcID(String srcID) throws Exception;
	
	public boolean changeheadpic(Map<String, Object> map) throws Exception;
	
	public boolean addPoints(int uid) throws Exception;
	
	public boolean changepwd(Map<String, Object> map) throws Exception;
}
