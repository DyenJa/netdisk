package com.example.demo.service;

import com.example.demo.dao.PublicResourceMapper;
import com.example.demo.dao.ResourceMapper;
import com.example.demo.dao.UserMapper;
import com.example.demo.entity.Notice;
import com.example.demo.entity.Resource;
import com.example.demo.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ResourceServiceBean {

	@Autowired
	private ResourceMapper rm;
	
	@Autowired
	private UserMapper um;
	
	@Autowired
	private PublicResourceMapper pm;
	
	 
	public boolean addReource(Resource rs) throws Exception{
		try{
			if(!rs.getSize().equals("--")) {
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("uid", rs.getUserid());
				map.put("change",0-Integer.parseInt(rs.getSize()));	
				um.changeSpace(map);
				
			}
			System.out.println(rm.addReource(rs));

		}
		catch (Exception e){
			e.printStackTrace();
			return false;
		}
		return true;	
	}

	 
	public List<Resource> getResource(int uid, String parentid) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", uid);
		map.put("parentid",parentid);	
		return rm.getResourceList(map);
	}
	
	 
	public Resource getResourceBySrcID(String srcID) throws Exception {
		
		return rm.getResourceBySrcID(srcID);
	}

	 
	public boolean deleteReource(String srcID) throws Exception {
		// TODO Auto-generated method stub
		
		Resource r=rm.getResourceBySrcID(srcID);
		
		if("folders".equals(r.getType())||"folder".equals(r.getType())){
			try{
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("userid", r.getUserid());
				map.put("parentid",srcID);
				List<Resource> delete_list=rm.getResourceList(map);	//delete those son folders of the folder that to be deleted
				List<Resource> son_folders=rm.getDirectory(srcID);
				
				rm.deleteResourceBySrcID(srcID);
		
				if(rm.getDirectory(r.getParentid()).size()==0) {	//1表示这是仅存的一个子文件夹
					rm.switchToFolder(r.getParentid());				//如果parentid是none，不会执行SQL，但是这里会执行一次java调用
				
				}
				
			
				/*
				 * 遍历删除文件夹内部的资源，广度优先遍历，sonfolders相当于一个队列
				 */
				while(son_folders.size()!=0) {
					Resource queue_head=son_folders.get(0);
					map.put("parentid", queue_head.getSrcID());
					delete_list.addAll(rm.getResourceList(map));
					son_folders.addAll(rm.getDirectory(queue_head.getSrcID()));
					son_folders.remove(0);
				}
			
				rm.batchDelete(delete_list);
			}
			catch (Exception e){
				return false;
			}
			return true;
		}
		else
			return rm.deleteResourceBySrcID(srcID);
	}

	 
	public  List<Resource> getTrashList(int uid) throws Exception {
		// TODO Auto-generated method stub
		return rm.getTrashList(uid);
	}

	 
	public boolean undo(List<String> resources) throws Exception {
		rm.undo(resources);
		List<String> deleted_son_id=new ArrayList<>();
		for(String s:resources) {
			Resource r=rm.getResourceBySrcID(s);
		
			if(r.getType().equals("folders")||r.getType().equals("folder")) {
				rm.switchToFolders(r.getParentid());
				
			
				deleted_son_id.addAll(rm.getDeletedResourceIDList(s));
				List<String> deleted_son_folders=rm.getForcedDirectory(s);
				while(deleted_son_folders.size()!=0) {
					String head_folder_id=deleted_son_folders.get(0);
					deleted_son_id.addAll(rm.getDeletedResourceIDList(head_folder_id));
					deleted_son_folders.addAll(rm.getForcedDirectory(head_folder_id));
					deleted_son_folders.remove(0);
					
				}
			
			}
		}
		if(deleted_son_id.size()>0)
			rm.undo(deleted_son_id);
		return true;
	}

	 
	public boolean realDelete(List<String> resources) throws Exception {
		// TODO Auto-generated method stub

		return true;
	}

	 
	public List<Resource> loadByType(int uid, String type) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", uid);
	
		List<String> list=new ArrayList<>();
		if("other".equals(type)) {
			list.add("archive");
			list.add("other");
		}
		else if("file".equals(type)) {
			list.add("pdf");
			list.add("word");
			list.add("excel");
			
		}
		else if("folder".equals(type)) {
			list.add("folder");
			list.add("folders");
		}
		else {
			list.add(type);
		}
		map.put("list", list);
		return rm.loadByType(map);
	}

	 
	public boolean reName(String srcID, String newName) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("srcID", srcID);
		map.put("newName", newName);
		
		if(newName.equals(""))
			return false;
		else if(newName.contains("."))
			return false;
		else {
			String oldname=rm.getResourceBySrcID(srcID).getName();
			if(!oldname.contains(".")){
				map.put("newName", newName);
			}
			else {
				map.put("newName", newName+"."+oldname.substring(oldname.lastIndexOf(".") + 1));
			}
			
		}
			return rm.rename(map);
	}

	 
	public boolean share(String[] resources, String receiver_name,int uid) throws Exception {
		List<Notice> list=new ArrayList<>();
		User giver=um.findUserByID(uid);
		int i=0;
		try{
			for(String s:resources) {
				Notice n=new Notice();
			
				n.setNid(""+giver.getuName()+new Date()+receiver_name+(i++));
				n.setGiver(giver.getuName());
				n.setReceiver(receiver_name);
				n.setClassification(1);
				n.setSrcID(s);
				Resource r=rm.getResourceBySrcID(s);
				n.setSrcSize(r.getSize());
				n.setSrcName(r.getName());
				n.setTime(new Date());
				
				list.add(n);
			}
			rm.share(list);	
		}
		catch(Exception e) {
			return false;
		}
		return true;
		
	}

	 
	public List<Notice> loadNotice(String username, int type, int page) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		if(type==0) {
			map.put("username", username);
			map.put("from", (page-1)*10);
			map.put("count",10);
			rm.setAllUnread(username);
			return rm.loadNotice(map);
		}
		else {
			map.put("username", username);
			map.put("from", (page-1)*10);
			map.put("count",10);
			map.put("type",type);
			
			return rm.loadNoticeByType(map);
		}
	
	}

	 
	public int countNotice(String username, int type) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		if(type==0) {
			
			return rm.totalNotice(username);
		}
		else {
			map.put("username", username);
			map.put("type",type);
	
			return rm.totalNoticeByType(map);
		}
	
	}
	
	 
	public boolean switchToFolders(String srcID) throws Exception {
		// TODO Auto-generated method stub
		return rm.switchToFolders(srcID);
	}

	 
	public List<Resource> getDirectory(String parentid) throws Exception {
		// TODO Auto-generated method stub
		
		return rm.getDirectory(parentid);
	}
	
	 
	public List<Resource> getRootDirectory(int uid) throws Exception {
		// TODO Auto-generated method stub
		return rm.getRootDirectory( uid);
	}
	
	 
	public boolean changeFolder(String moved_src, String target_folder) throws Exception {
		// TODO Auto-generated method stub
		if(moved_src.equals(target_folder))
			return false;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("moved_src", moved_src);
		map.put("target_folder", target_folder);
		Resource moved_resource=rm.getResourceBySrcID(moved_src);
		//移动的是文件夹！
		if(moved_resource.getSize().equals("--")) {
			try {
				if(!target_folder.equals("none")) {
						rm.switchToFolders(target_folder);
				}
				
				if(!moved_resource.getParentid().equals("none")) {
					int folders=rm.getDirectory(moved_resource.getParentid()).size();
					if(folders==1)
						rm.switchToFolder(moved_resource.getParentid());
				}
			}
			catch(Exception e) {
				return false;
			}
		}
	
		
		rm.changeFolder(map);

		return true;
	}

	 
	public List<Notice> loadThreeNotice(String username) throws Exception {
		// TODO Auto-generated method stub
		
		return rm.loadThreeNotice(username);
	}

	 
	public boolean addNotice(Notice n) throws Exception {
		// TODO Auto-generated method stub
		return rm.addNotice(n);
	}

	 
	public int getUnreadNotice(String receiver) throws Exception {
		// TODO Auto-generated method stub
		return rm.getUnreadNotice(receiver);
	}

	 
	public boolean deleteNotice(String nid) throws Exception {
		// TODO Auto-generated method stub
		return rm.deleteNotice(nid);
	}


}
