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

		return true;
	}



	 
	public int countComments(String srcID) throws Exception {
		// TODO Auto-generated method stub
		return pm.countCommentsBysrcID(srcID);
	}

	 
	public boolean evaluate(String srcID, int uid, String attitude) throws Exception {
		// TODO Auto-generated method stub

		return true;
	}

	 
	public int getEvaluation(String srcID, int uid) throws Exception {

		return 0;
	}
	
	 
	public boolean publicDownload(String srcID,int sharer,int downloader) throws Exception {

		// TODO Auto-generated method stub
		return true;
	}

	 
	public boolean saveToMySpace(String target_resource, String target_folder,int uid) throws Exception {

		return true;
		
	}


}
