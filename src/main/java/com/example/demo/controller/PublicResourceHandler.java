package com.example.demo.controller;

import com.example.demo.entity.Comment;
import com.example.demo.entity.Notice;
import com.example.demo.entity.PublicResourceVo;
import com.example.demo.entity.User;

import com.example.demo.service.PublicResourceServiceBean;
import com.example.demo.service.ResourceServiceBean;
import com.example.demo.service.UserService;

import com.example.demo.service.UserServiceBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tools.ResourceTool;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
public class PublicResourceHandler {

	@Autowired
	private UserServiceBean us;
	
	@Autowired
	private ResourceServiceBean rs;
	
	@Autowired
	private PublicResourceServiceBean ps;

	@RequestMapping(value="/public_share")
	@ResponseBody
	public String public_share(String srcID,HttpServletRequest request) throws Exception{
		
		try {
			ps.addPublicReource(srcID);
			return  "{\"result\":true}";
		}
		catch(Exception e){
			return  "{\"result\":false}";
		}
	}
	
	@RequestMapping(value="/search")
	public String search(HttpServletRequest request) throws Exception{
		
		String name=request.getParameter("name");
		String type=request.getParameter("type");
		if(type==null)
			type="all";
		int page=Integer.parseInt(request.getParameter("page"));
		request.setAttribute("count", ps.countSearchResult(name, type)/12+1);
		request.setAttribute("current_page", page);
		request.setAttribute("type", type);
		List<PublicResourceVo> list=ps.searchPublicResource(name, type, page);

		for(PublicResourceVo r:list) {
		
			r.setSize(ResourceTool.transferUnit(r.getSize()));
		}
		request.setAttribute("search_result", list);
		return "forward:/search_result.jsp?name="+name+"&type="+type+"&page="+page;
	}
	
	@RequestMapping(value="/srcInfo")
	public String srcInfo(HttpServletRequest request) throws Exception{

		return "";
	}

	@RequestMapping(value="/comment")
	@ResponseBody
	public String comment(String srcID,String text,HttpServletRequest request) throws Exception{

			return  "{\"result\":true}";

	}
	
	@RequestMapping(value="/evaluate")
	@ResponseBody
	public String evaluate(String srcID,String attitude,HttpServletRequest request) throws Exception{
	

				return  "{\"result\":true}";
	}
	
	@RequestMapping(value="/download/public")
	@ResponseBody
	public String downloadPublic(String srcID,HttpServletRequest request) throws Exception{
		

			return  "{\"result\":true}";

	}
	
	@RequestMapping(value="/copy")
	@ResponseBody
	public String copy(String target_resource,String target_folder,HttpServletRequest request) throws Exception{

		return  "{\"result\":true}";
	}
}
