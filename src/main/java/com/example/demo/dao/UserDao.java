package com.example.demo.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.User;


@Mapper
@Repository
public interface UserDao {
	ArrayList<User>  selectUser();
    int deleteUser(String name);
}