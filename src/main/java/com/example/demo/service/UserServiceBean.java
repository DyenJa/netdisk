package com.example.demo.service;

import com.example.demo.dao.UserMapper;
import com.example.demo.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserServiceBean  {
	@Autowired
	UserMapper um;


	public User selectUserByName(String name) throws Exception {
		// TODO Auto-generated method stub
		return um.findUserByName(name);
	}


	public boolean createNewUser(String name, String password, String email) throws Exception {
		User u =new User();
		u.setuName(name);
		u.setEmail(email);
		u.setPassword(password);
		u.setPicurl("assets/img/user01.jpg");
		u.setAvaliable_space(102400);

		boolean result=false;
		try {
			result = um.createNewUser(u);
		}
		catch(Exception e) {
			return false;
		}
		if(result){
			result=true;
		}else{
			result=false;
		}
		return result;
	}




	public User selectUserByID(int id) throws Exception {
		// TODO Auto-generated method stub
		return um.findUserByID(id);
	}




	public User getUserBySrcID(String srcID) throws Exception {
		// TODO Auto-generated method stub
		return um.getUserBySrcID(srcID);
	}




	public boolean changeheadpic(String url,int uid) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();

		return um.changeheadpic(map);
	}




	public boolean changepwd(int uid, String password) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uid", uid);
		map.put("password",password);
		return um.changepwd(map);
	}
}
