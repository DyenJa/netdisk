package com.example.demo.controller;


import com.example.demo.entity.Notice;
import com.example.demo.entity.NoticeVo;
import com.example.demo.entity.Resource;
import com.example.demo.entity.User;
import com.example.demo.service.ResourceServiceBean;
import com.example.demo.service.UserServiceBean;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import tools.LogConfig;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
public class ResourceHandler {

	@Autowired
	private UserServiceBean us;
	
	@Autowired
	private ResourceServiceBean rs;
	
	@RequestMapping(value="/loadSourceList")
	public String getSourceList(HttpServletRequest request) throws Exception{

		int uid=(int) request.getSession().getAttribute("uid");
		String parentid=request.getParameter("current_position");
	
		List<Resource> resource_list;
		List<Resource> folder_path = new ArrayList<>();
		if("none".equals(parentid)||"null".equals(parentid)||parentid==null) {
		
			resource_list=rs.getResource(uid,"none");
		}
		else {
			resource_list=rs.getResource(uid,parentid);
			Resource current_resource=rs.getResourceBySrcID(parentid);
			request.setAttribute("current_name", current_resource.getName());
			
			while(!current_resource.getParentid().equals("none")) {
				current_resource=rs.getResourceBySrcID(current_resource.getParentid());
				folder_path.add(0,current_resource);
		
		
			}
		}
		
		for(Resource r:resource_list) {
		
			r.setSize(transferUnit(r.getSize()));
		}
		
		if(!"none".equals(parentid)&&!"null".equals(parentid)&&parentid!=null) {
			request.setAttribute("folder_path", folder_path);
		
			request.setAttribute("path", rs.getResourceBySrcID(parentid).getSrcurl());
		}
			
		request.setAttribute("resource_list", resource_list);
	
	
		
		return "forward:/table.jsp";
	}
	
	@RequestMapping(value="/loadByType")
	public String loadByType(HttpServletRequest request) throws Exception{
	
		int uid=(int) request.getSession().getAttribute("uid");
		String type=request.getParameter("type");
		List<Resource> resource_list;
		resource_list=rs.loadByType(uid,type);
		for(Resource r:resource_list) {
		
			r.setSize(transferUnit(r.getSize()));
		}
		request.setAttribute("resource_list", resource_list);
		
		return "forward:/table.jsp";
	}
	
	@RequestMapping(value="/reName")
	@ResponseBody
	public String reName(String srcID,String newName,HttpServletRequest request) throws Exception{
		
		

		
		boolean result=rs.reName(srcID,newName);
		
			return "{\"result\":"+result+"}";
	}
	
	@RequestMapping(value="/loadTrash")
	public String getTrashList(HttpServletRequest request) throws Exception{

		int uid=(int) request.getSession().getAttribute("uid");
		
		List<Resource> Trash_list;

		Trash_list=rs.getTrashList(uid);

		for(Resource r:Trash_list) {
			r.setSize(transferUnit(r.getSize()));
		}
		request.setAttribute("Trash_list", Trash_list);
		return "forward:/trash.jsp";
	}
	
	
	@RequestMapping(value="/createFolder")
	public String createFolder(HttpServletRequest request) throws Exception{
	
		int uid=(int) request.getSession().getAttribute("uid");
		
		String parentid=request.getParameter("current_position")==null? "none":request.getParameter("current_position");
		String folder_name=request.getParameter("name");
		
		Resource r=new Resource();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		r.setSrcID(uid+(df.format(new Date())).toString()+(int)(1+Math.random()*10));
		r.setName(folder_name);
		r.setType("folder");
		r.setSize("--");
		r.setEdit_time(new Date());
		r.setState(1);
		
		Resource parent_folder;
		if(!parentid.equals("none")) {
			parent_folder=rs.getResourceBySrcID(parentid);
			rs.switchToFolders(parentid);
			r.setParentid(parentid);
			r.setSrcurl(parent_folder.getSrcurl()+"//"+r.getName());
	
		}	
		else{
			r.setParentid("none");
			r.setSrcurl(r.getName());
		
		}
		r.setUserid(uid);
		rs.addReource(r);
		//创建文件夹（即只需要插入一条记录，并不需要本地创建）
		//文件类型设置为folder
		return "forward:/loadSourceList?current_position="+parentid;
	}
	
	@RequestMapping(value = "/upload.do", method = RequestMethod.POST)
	public String upload(HttpServletRequest request,@RequestParam("file") MultipartFile[] file, ModelMap model) throws Exception {
		
		int uid=(int) request.getSession().getAttribute("uid");
	
		User u=us.selectUserByID(uid);
		String parentid=request.getParameter("current_position")==null? "none":request.getParameter("current_position");

		String path = "/root/webapp/upload/"+uid;//获取当前项目下的upload,社会主义改造期间改为..//upload//username//
		for (int i = 0; i < file.length; i++) {
			
			String fileName = file[i].getOriginalFilename();//获取文件名

			File targetFile = new File(path, fileName);//判断文件是否存在，不存在则创建，可创建文件夹

			if (!targetFile.exists()) {
				boolean r=targetFile.createNewFile();
				if(!r){
					throw new Exception("创建失败");
				}
			}
		
			// 保存
			try {
				if((int)file[i].getSize()/1024>u.getAvaliable_space())
					return "space_not_enough";
				
				//使用transferTo（dest）方法将上传文件写到服务器上指定的文件。
				file[i].transferTo(targetFile);//此方法在上传完成后才开始上传
			
				Resource r=new Resource();
				SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
				r.setSrcID(uid+(df.format(new Date())).toString()+i+""+(int)(1+Math.random()*10));
				r.setName(file[i].getOriginalFilename());
				r.setType(getFileType(file[i].getOriginalFilename()));
				
				r.setSize((int)file[i].getSize()/1024+"");
				r.setEdit_time(new Date());
				r.setState(1);
				r.setSrcurl("/upload/"+uid+"/"+file[i].getOriginalFilename());
				r.setParentid(parentid);
				r.setUserid(uid);
			
				rs.addReource(r);
			} catch (Exception e) {

				LogConfig.getLOG().error("错误信息", e);
			}
		}
//		model.addAttribute("fileUrl", request.getContextPath() + "/upload/"
//				+ fileName);
		return "nothing";
	}
	public static String getFileType(String fileName) {
		String suffix=fileName.substring(fileName.lastIndexOf(".") + 1);
		String type;
		switch(suffix) {
		case "doc":
		case "docx":
			type="word";
			break;
		case "xls":
		case "xlsx":
			type="excel";
			break;
		case "pdf":
			type="pdf";
			break;
		case "mp4":
		case "rmvb":
			type="video";
			break;
		case "mp3":
			type="audio";
			break;
		case "png":
		case "jpg":
			type="picture";
			break;
		case "zip":
		case "rar":
			type="archive";
			break;
		default:
			type="other";
			break;
		}
		return type;
	}
	public static String transferUnit(String s) {
		if(s.equals("--"))
			return s;
		int sizeInKB=Integer.parseInt(s);
		int size=0;
		if(sizeInKB>1024&&sizeInKB<1048576) {
			size=sizeInKB/1024;
			return size+"M";
		}
		else if(sizeInKB>1048576) {
			size=sizeInKB/1048576;
			return size+"G";
		}
			
		else {
			size=sizeInKB;
			return size+"K";
		}
					
	}

	/**
	 * 如果是批量下载，那就多次访问这个handler就OK拉
	 */
	  @RequestMapping("/down")  
      public void down(HttpServletRequest request,HttpServletResponse response) throws Exception{    
		
		  String srcID=request.getParameter("srcID");
		   Resource r=rs.getResourceBySrcID(srcID);

		  String filePath = "/root/webapp"+r.getSrcurl();
		  String fileName=r.getName();
		  response.setContentType("text/html;charset=utf-8");
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				LogConfig.getLOG().error("错误信息", e1);
			}
					
			BufferedInputStream bis = null;
			BufferedOutputStream bos = null;
		
			String downLoadPath = filePath;  //注意不同系统的分隔符
		
		
			
			try {
				long fileLength = new File(downLoadPath).length();
				response.setContentType("application/x-msdownload;");
				response.setHeader("Content-disposition", "attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
				response.setHeader("Content-Length", String.valueOf(fileLength));
				bis = new BufferedInputStream(new FileInputStream(downLoadPath));
				bos = new BufferedOutputStream(response.getOutputStream());
				byte[] buff = new byte[2048];
				int bytesRead;
				while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
					bos.write(buff, 0, bytesRead);
				}
			} catch (Exception e) {
				LogConfig.getLOG().error("错误信息", e);
			} finally {
				if (bis != null)
					try {
						bis.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						LogConfig.getLOG().error("错误信息", e);
					}
				if (bos != null)
					try {
						bos.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						LogConfig.getLOG().error("错误信息", e);
					}
			}
			
      }  
	
	  
	  @RequestMapping("/delete")  
      public String delete(HttpServletRequest request,HttpServletResponse response) throws Exception{    
		
		  String srcID=request.getParameter("srcID");
		  rs.deleteReource(srcID);
		  
		  return "forward:/loadSourceList";
      }  
	  
	  @RequestMapping("/undo")  
      public String undo(HttpServletRequest request,HttpServletResponse response) throws Exception{    
		
		  String srcID=request.getParameter("srcID");
		  rs.undo(Arrays.asList(srcID));
		  
		  return "forward:/loadTrash";
      } 
	  
		@RequestMapping(value="/batchUndo")
		@ResponseBody
		public String batchUndo(String[] resources,HttpServletRequest request) throws Exception{
		
	
			
			List<String> list=Arrays.asList(resources);
	
			 rs.undo(list);
			 return  "{\"result\":true}";
		}
	  
	  
	  
	  @RequestMapping("/realDelete")  
      public String realDelete(HttpServletRequest request,HttpServletResponse response) throws Exception{    
		
		  String srcID=request.getParameter("srcID");
		  rs.realDelete(Arrays.asList(srcID));
		  
		  return "forward:/loadTrash";
      } 
	  
	  @RequestMapping(value="/batchRealDelete")
		@ResponseBody
		public String batchRealDelete(String[] resources,HttpServletRequest request) throws Exception{

			 rs.realDelete(Arrays.asList(resources));
			 return  "{\"result\":true}";
		}
	  
	  	@RequestMapping(value="/batchDelete")
		@ResponseBody
		public String batchDelete(String [] resources,HttpServletRequest request) throws Exception{
	
			
			for(String s:resources) {
		
				rs.deleteReource(s);
				
			}
			
			return "{\"result\":true}";
		}
	  
	  	@RequestMapping(value="/batchShare")
		@ResponseBody
		public String batchShare(String [] resources,String receiver,HttpServletRequest request) throws Exception{
	  		User u=us.selectUserByName(receiver);
	  		if(u==null)
	  			return "{\"result\":false}";
	
			int uid=(int) request.getSession().getAttribute("uid");
		
			rs.share(resources,receiver,uid);
			
			
			return "{\"result\":true}";
		}
	  	
		  @RequestMapping("/loadNotice")  
	      public String loadNotice(HttpServletRequest request) throws Exception{    
		
			 int uid=(int) request.getSession().getAttribute("uid");
			 User u=us.selectUserByID(uid);
			 String page=request.getParameter("page");
			 String type=request.getParameter("type");
			 List<Notice> notices;
		
			 notices=rs.loadNotice(u.getuName(), Integer.parseInt(type), Integer.parseInt(page));
			
			 
			 List<NoticeVo> noticesVo = new ArrayList<>();
			 for(Notice n:notices) {
			
				 NoticeVo nvo=new NoticeVo();
				 nvo.setNid(n.getNid());
				 nvo.setSrcID(n.getSrcID());
				 nvo.setSize(transferUnit(n.getSrcSize()));
				 
				 if(u.getuName().equals(n.getGiver())&&n.getClassification()==3) {
					 continue;//我评论的，不显示
				 }
				 else if(u.getuName().equals(n.getGiver())&&n.getClassification()==1) {
					 nvo.setClassification(0);						//0代表 我分享给别人的消息
					 nvo.setCommunicater(n.getReceiver());
				 }
					
				 else if(u.getuName().equals(n.getReceiver())&&n.getClassification()==1) {
					 nvo.setClassification(1);						//1代表别人分享给我的
					 nvo.setCommunicater(n.getGiver());
				 }
					
				
				 else if(u.getuName().equals(n.getReceiver())&&n.getClassification()==2) {
					 nvo.setClassification(2);						//2下载
					 nvo.setCommunicater(n.getGiver());
				 }
				 
				 else if(u.getuName().equals(n.getReceiver())&&n.getClassification()==3) {
					 nvo.setClassification(3);						//3评论
					 nvo.setCommunicater(n.getGiver());
				 }
				 else if(u.getuName().equals(n.getReceiver())&&n.getClassification()==4) {
					 nvo.setClassification(4);						//4点赞
					 nvo.setCommunicater(n.getGiver());
				 }
				 else {
					
				 }
				 nvo.setSrcName(n.getSrcName());
				 nvo.setTime(n.getTime());
				 noticesVo.add(nvo);
			}
			 request.setAttribute("type", type);
			 request.setAttribute("noticesVo", noticesVo);
			 int total_notice=rs.countNotice(u.getuName(), Integer.parseInt(type));
			 int count_page=(total_notice/10)*10==total_notice? (total_notice/10):(total_notice/10)+1;
			 request.setAttribute("count", count_page);
			 request.setAttribute("current_page", page);
			 return "forward:/notice.jsp";
	      } 
		  
		  @RequestMapping(value="/deleteNotice")
			@ResponseBody
			public String deleteNotice(String nid,HttpServletRequest request) throws Exception{
			
				boolean result=rs.deleteNotice(nid);
				if(result)
					return "{\"result\":true}";
				else
					return "{\"result\":false}";
			}
		  
		  
		@RequestMapping(value="/getDirectory")
		@ResponseBody
		public List<Resource> getDirectory(String parentid,HttpServletRequest request) throws Exception{
		
			 int uid=(int) request.getSession().getAttribute("uid");
			if("".equals(parentid)) {
				parentid="none";
			}
		
			List<Resource> result=rs.getDirectory(parentid);
			return result;
		}
		
		@RequestMapping(value="/getRootDirectory")
		@ResponseBody
		public List<Resource> getRootDirectory(HttpServletRequest request) throws Exception{
			
			 int uid=(int) request.getSession().getAttribute("uid");
			List<Resource> result=rs.getRootDirectory(uid);
			return result;
		}
		  
		@RequestMapping(value="/changeFolder")
		@ResponseBody
		public String changeFolder(String moved_src,String target_folder,HttpServletRequest request) throws Exception{
		
			
			 boolean result=rs.changeFolder(moved_src,target_folder);
			 return "{\"result\":"+result+"}";
		}	
		
		@RequestMapping(value="/share_copy")
		@ResponseBody
		public String copy(String target_resource,String target_folder,HttpServletRequest request) throws Exception{
		
			int uid=(int)request.getSession().getAttribute("uid");
			try{
				Resource r=rs.getResourceBySrcID(target_resource);
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
				rs.addReource(r_copy);
			}
			catch( Exception e) {
				return  "{\"result\":false}";
			}
			return  "{\"result\":true}";
		}
}
