package com.example.demo.service;

import com.example.demo.dao.PublicResourceMapper;
import com.example.demo.dao.ResourceMapper;
import com.example.demo.dao.UserMapper;
import com.example.demo.entity.Comment;
import com.example.demo.entity.PublicResourceVo;
import com.example.demo.entity.Resource;
import com.example.demo.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class PublicResourceServiceBean  {

	@Autowired
	private ResourceMapper rm;
	
	@Autowired
	private UserMapper um;

	@Autowired
	private PublicResourceMapper pm;
	
	 
	public boolean addPublicReource(String srcID) throws Exception {
		// TODO Auto-generated method stub
		return pm.addPublicResource(srcID);
	}

	 
	public List<PublicResourceVo> searchPublicResource(String name, String type,int page) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		List<String> list=new ArrayList<>();
		map.put("name", name);
		
		if("all".equals(type)) {
			list.add("video");
			list.add("audio");
			list.add("word");
			list.add("excel");
			list.add("pdf");
			list.add("picture");
			list.add("archive");
			list.add("other");
		}
		else if("video".equals(type)) {
			list.add("video");
		}
			
		else if("audio".equals(type)) {
			list.add("audio");
		}
			
		else if("file".equals(type)) {
			list.add("pdf");
			list.add("word");
			list.add("excel");
		}
			
		else {
			list.add("picture");
			list.add("archive");
			list.add("other");
		}
		map.put("list", list);
		map.put("from",(page-1)*12);
		map.put("count",12);
		try {
			return pm.searchPublicResource(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return null;
		}
	}

	 
	public int countSearchResult(String name, String type) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		List<String> list=new ArrayList<>();
		map.put("name", name);
		
		if("all".equals(type)) {
			list.add("video");
			list.add("audio");
			list.add("word");
			list.add("excel");
			list.add("pdf");
			list.add("picture");
			list.add("archive");
			list.add("other");
		}
		else if("video".equals(type)) {
			list.add("video");
		}
			
		else if("audio".equals(type)) {
			list.add("audio");
		}
			
		else if("file".equals(type)) {
			list.add("pdf");
			list.add("word");
			list.add("excel");
		}
			
		else {
			list.add("picture");
			list.add("archive");
			list.add("other");
		}
		map.put("list", list);
		try {
			return pm.countSearchResult(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return -1;
		}
		
	}

	 
	public PublicResourceVo getPublicResourceByID(String srcID) {
		// TODO Auto-generated method stub
		try {
			return pm.getPublicResourceByID(srcID);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return null;
		}
	}

	

	 
	public boolean comment(int uid,String text,String srcID) throws Exception {
		// TODO Auto-generated method stub
		User u=um.findUserByID(uid);
		Comment c=new Comment();
		c.setCommenter_id(uid);
		c.setCommenter_name(u.getuName());
		c.setCommenter_pic(u.getPicurl());
		c.setContent(text);
		c.setSrcID(srcID);
		c.setTime(new Date());
		return pm.comment(c);
	}


	public List<Comment> getCommentsBysrcID(String srcID, int page) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("srcID", srcID);
		map.put("from", (page-1)*4);
		map.put("count", 4);

		return pm.getCommentBysrcID(map);
	}

	 
	public int countComments(String srcID) throws Exception {
		// TODO Auto-generated method stub
		return pm.countCommentsBysrcID(srcID);
	}

	 
	public boolean evaluate(String srcID, int uid, String attitude) throws Exception {
		// TODO Auto-generated method stub



		Map<String,Object> map = new HashMap<String,Object>();
		map.put("srcID", srcID);
		map.put("uid",uid);
		int attitu;
		if("good".equals(attitude))
			attitu=1;
		else
			attitu=0;
		try {

			map.put("attitude",attitu);
			pm.evaluate(map);
			pm.addAttitude(map);
		}
		catch (Exception e) {
			return false;
		}
		return true;
	}

	 
	public int getEvaluation(String srcID, int uid) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("srcID", srcID);
		map.put("uid",uid);
		int a;
		try {
			a=pm.getEvaluation(map);
		}
		catch(Exception e) {
			return -2;
		}
		return a;
	}
	
	 
	public boolean publicDownload(String srcID,int sharer,int downloader) throws Exception {
		try {

			Map<String,Object> map = new HashMap<String,Object>();
			map.put("srcID", srcID);
			map.put("uid",downloader);
			pm.insertAttitude(map);				//插入新的attitude
		}
		catch(Exception e) {

			return false;
		}


		try {

			pm.publicDownload(srcID);	//增加下载次数

		}
		catch(Exception e) {

			return false;
		}


		try {
			um.addPoints(sharer);				//增加积分

		}
		catch(Exception e) {

			return false;
		}
		// TODO Auto-generated method stub
		return true;
	}

	 
	public boolean saveToMySpace(String target_resource, String target_folder,int uid) throws Exception {
		Resource r=rm.getResourceBySrcID(target_resource);
		Resource r_copy=new Resource();
		r_copy.setEdit_time(new Date());
		r_copy.setName(r.getName());
		r_copy.setParentid(target_folder);
		r_copy.setSize(r.getSize());

		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		r_copy.setSrcID(uid+(df.format(new Date())).toString()+(int)(1+Math.random()*10));

		r_copy.setSrcurl(r.getSrcurl());
		r_copy.setState(1);
		r_copy.setType(r.getType());
		r_copy.setUserid(uid);

		try {
			rm.addReource(r_copy);

			Map<String,Object> map = new HashMap<String,Object>();
			map.put("uid", uid);
			map.put("change",0-Integer.parseInt(r.getSize()));
			um.changeSpace(map);

		}
		catch(Exception e) {
			return false;
		}
		return true;
		
	}


}
