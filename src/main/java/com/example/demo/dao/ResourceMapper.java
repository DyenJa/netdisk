package com.example.demo.dao;



import com.example.demo.entity.Notice;
import com.example.demo.entity.Resource;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface ResourceMapper {
	//添加新的资源
	public boolean addReource(Resource r) throws Exception;
	
	

	
	public List<Resource> getResourceList(Map<String, Object> map) throws Exception;
	
	public List<String> getDeletedResourceIDList(String parentid) throws Exception;
	
	//重命名
	public boolean rename(Map<String, Object> map) throws Exception;




	public Resource getResourceBySrcID(String srcID) throws Exception;




	public boolean deleteResourceBySrcID(String srcID) throws Exception;
	
	
	public boolean deleteSonResource(String parentid) throws Exception;
	
	public boolean batchDelete(List<Resource> resources) throws Exception;
	
	public  List<Resource> getTrashList(int uid) throws Exception;




	public boolean undo(List<String> resources) throws Exception;




	public boolean realDelete(List<String> resources) throws Exception;

	public boolean realDeleteSonResource(String parentid) throws Exception;


	public List<Resource> loadByType(Map<String, Object> map) throws Exception;




	public boolean share(List<Notice> list) throws Exception;

	
	public List<Notice> loadNotice(Map<String, Object> map) throws Exception;
	
	public int totalNotice(String username) throws Exception;
	
	public List<Notice> loadNoticeByType(Map<String, Object> map) throws Exception;
	
	public int totalNoticeByType(Map<String, Object> map) throws Exception;

	public boolean switchToFolders(String srcID) throws Exception;
	
	public boolean switchToFolder(String srcID) throws Exception;
	
	public List<Resource> getDirectory(String parentid) throws Exception;

	public List<Resource> getRootDirectory(int uid) throws Exception;
	
	public List<String> getForcedDirectory(String parentid) throws Exception;
	
	public boolean changeFolder(Map<String, Object> map) throws Exception;

	public boolean addNotice(Notice n)  throws Exception;
	
	public boolean setAllUnread(String uname)  throws Exception;
	
	public List<Notice> loadThreeNotice(String username) throws Exception;




	public int getUnreadNotice(String receiver)  throws Exception;




	public boolean deleteNotice(String nid) throws Exception;




	
}
