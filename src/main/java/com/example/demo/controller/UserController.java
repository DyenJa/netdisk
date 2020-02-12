package com.example.demo.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import net.sf.json.JSONArray;



@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserService userService;

	@ResponseBody
	@RequestMapping("/select")
    public String select(HttpServletRequest request,HttpServletResponse response){
		ArrayList<User> ls=new ArrayList<User>();
		ls=userService.selectUser();
		JSONArray result = JSONArray.fromObject(ls);
        return result.toString();
    }
	
	@ResponseBody
	@RequestMapping("/delete")
    public String delete(HttpServletRequest request,HttpServletResponse response){
		String name = (String)request.getParameter("uid");
		int rn=userService.deleteUser(name);
		System.out.println(rn);
		if(rn>0) {
			return "成功删除"+name;
		}else {
			return "删除失败";
		}
        
    }
}
