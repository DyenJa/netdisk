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
		String srcID=request.getParameter("srcID");
		String page=request.getParameter("page");
		int current_page;
		if(page!=null)
			current_page=Integer.parseInt(page);
		else
			current_page=1;
		PublicResourceVo p=ps.getPublicResourceByID(srcID);
		p.setSize(ResourceTool.transferUnit(p.getSize()));
		request.setAttribute("p",p);

		List<Comment> list=ps.getCommentsBysrcID(srcID, current_page);
		int total_comments=ps.countComments(srcID);
		int count=(total_comments/4)*4==total_comments? (total_comments/4):(total_comments/4)+1;
		request.setAttribute("comments",list);
		request.setAttribute("count",count);

		request.setAttribute("current_page",current_page);
		request.setAttribute("srcID",srcID);
		return "forward:/info.jsp?srcID="+srcID+"&page="+current_page;
	}

	@RequestMapping(value="/comment")
	@ResponseBody
	public String comment(String srcID,String text,HttpServletRequest request) throws Exception{

		int uid=(int) request.getSession().getAttribute("uid");
		Notice n=new Notice();


		User receiver=us.getUserBySrcID(srcID);
		User giver=us.selectUserByID(uid);
		n.setClassification(3);
		n.setGiver(giver.getuName());
		n.setReceiver(receiver.getuName());
		n.setSrcID(srcID);
		n.setSrcName(rs.getResourceBySrcID(srcID).getName());
		n.setTime(new Date());
		n.setSrcSize("--");
		n.setNid(""+giver.getuName()+new Date()+receiver.getuName()+srcID);
		try{
			rs.addNotice(n);
			ps.comment(uid, text, srcID);
			return  "{\"result\":true}";
		}
		catch( Exception e) {
			return  "{\"result\":false}";
		}
	}
	
	@RequestMapping(value="/evaluate")
	@ResponseBody
	public String evaluate(String srcID,String attitude,HttpServletRequest request) throws Exception{
	
		int uid=(int) request.getSession().getAttribute("uid");
		Notice n=new Notice();

		n.setClassification(4);
		n.setGiver(attitude);
		User u=us.getUserBySrcID(srcID);
		n.setReceiver(u.getuName());
		n.setSrcID(srcID);
		n.setSrcName(rs.getResourceBySrcID(srcID).getName());
		n.setTime(new Date());
		n.setSrcSize("--");
		n.setNid(""+n.getGiver()+new Date()+u.getuName()+srcID);

		int evalution=ps.getEvaluation(srcID, uid);
			if(evalution==-1) {
				ps.evaluate(srcID, uid, attitude);
				rs.addNotice(n);
				return  "{\"result\":true}";
			}
			else if(evalution==-2) {
				return  "{\"result\":\"您尚未使用过此资源\"}";
			}
			else
				return  "{\"result\":false}";
	}
	
	@RequestMapping(value="/download/public")
	@ResponseBody
	public String downloadPublic(String srcID,HttpServletRequest request) throws Exception{
		
		int uid=(int)request.getSession().getAttribute("uid");

		Notice n=new Notice();

		User receiver=us.getUserBySrcID(srcID);

		User giver=us.selectUserByID(uid);

		n.setClassification(2);
		n.setReceiver(receiver.getuName());
		n.setSrcID(srcID);
		n.setSrcName(rs.getResourceBySrcID(srcID).getName());
		n.setTime(new Date());
		n.setSrcSize("--");
		n.setNid(""+giver.getuName()+new Date()+receiver.getuName()+srcID);


		boolean neverDownloadBefore=ps.publicDownload(srcID,receiver.getuID(),uid);	//增加积分、生成attitude、下载量加一

		if(neverDownloadBefore) {
			rs.addNotice(n);    //告知贡献者被下载啦！
			return  "{\"result\":true}";
		}
		else {
			return  "{\"result\":false}";
		}

	}
	
	@RequestMapping(value="/copy")
	@ResponseBody
	public String copy(String target_resource,String target_folder,HttpServletRequest request) throws Exception{

		int uid=(int)request.getSession().getAttribute("uid");
		try{
			ps.saveToMySpace(target_resource,target_folder,uid);
		}
		catch( Exception e) {
			return  "{\"result\":false}";
		}
		return  "{\"result\":true}";
	}
}
