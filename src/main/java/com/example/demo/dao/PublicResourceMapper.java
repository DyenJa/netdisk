package com.example.demo.dao;

import com.example.demo.entity.Comment;
import com.example.demo.entity.PublicResourceVo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface PublicResourceMapper {
	public boolean addPublicResource(String srcID) throws Exception;
	
	public List<PublicResourceVo> searchPublicResource(Map<String, Object> map) throws Exception;

	public int countSearchResult(Map<String, Object> map) throws Exception;
	
	public PublicResourceVo getPublicResourceByID(String srcID) throws Exception;
	
	public List<Comment> getCommentBysrcID(Map<String, Object> map) throws Exception;
	
	public int countCommentsBysrcID(String srcID) throws Exception;
	
	public boolean insertAttitude(Map<String, Object> map)  throws Exception;
	
	public boolean evaluate(Map<String, Object> map)  throws Exception;
	
	public int getEvaluation(Map<String, Object> map)  throws Exception;
	
	public boolean addAttitude(Map<String, Object> map) throws Exception;
	
	public boolean comment(Comment c) throws Exception;
	
	public boolean publicDownload(String srcID) throws Exception;
}
