package com.example.demo.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.UserDao;
import com.example.demo.entity.User;

@Service
public class UserService {
	@Autowired
	UserDao userDao;
	
	public ArrayList<User>  selectUser(){
		ArrayList<User> ls=userDao.selectUser();
		return ls;
	}
	public int deleteUser(String name) {
		int n=userDao.deleteUser(name);
		return n;
	}
}
