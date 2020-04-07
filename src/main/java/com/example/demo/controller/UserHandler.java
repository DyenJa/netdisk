package com.example.demo.controller;

import com.example.demo.entity.Notice;
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
import org.springframework.web.servlet.ModelAndView;
import tools.LogConfig;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class UserHandler {

	@Autowired
	private UserServiceBean us;
	
	@Autowired
	private ResourceServiceBean rs;


	@RequestMapping("/login")
	public String index() {
		return "login";
	}


	@RequestMapping(value="/loginhanle")
	@ResponseBody
	public String uploadajax(String name,String pwd,HttpServletRequest request) throws Exception{

		User u=us.selectUserByName(name);
		if(u==null)
			return "{\"result\":false}";
	
		if(u.getPassword().equals(pwd)) {
			HttpSession s=request.getSession();
			s.setAttribute("uid",u.getuID());
		
	
			return "{\"result\":true}";
		}
		else {
		
			return "{\"result\":false}";
		}
			
		
	}
	
	
	
	@RequestMapping(value="/registerhanle")
	@ResponseBody
	public String uploadajax(String name,String password,String email,HttpServletRequest request) throws Exception{
	
		User u=us.selectUserByName(name);
	
	
		if(u!=null) {
		
			return  "{\"result\":false}";
		}
			
		boolean result=us.createNewUser(name,password,email);
		if(result==false) {
			return  "{\"result\":false}";
		}
		u=us.selectUserByName(name);
		HttpSession s=request.getSession();
		s.setAttribute("uid",u.getuID());

		File file=new File("/root/webapp/upload/"+u.getuID());

		System.out.println(file.exists()+"?????????"+file.getPath());
		if(!file.exists()){//如果文件夹不存在
			file.mkdir();//创建文件夹
		}
		return "{\"result\":"+result+"}";
	}
	
	   @RequestMapping(value="/changepwd",produces = "text/html;charset=UTF-8")
		@ResponseBody
		public String changepwd(String old_password,String password,HttpServletRequest request) throws Exception{

			int uid=(int) request.getSession().getAttribute("uid");
			User u=us.selectUserByID(uid);
			if(!u.getPassword().equals(old_password)) {
				return  "{\"result\":false}";
			}
			else {
				if(!us.changepwd(uid,password))
					return  "{\"result\":false}";
				else
					return  "{\"result\":true}";
			}
		
		}
	
	  @RequestMapping("/UserBoard")  
      public String down(HttpServletRequest request,HttpServletResponse response) throws Exception{
		  int uid=(int) request.getSession().getAttribute("uid");
		  User u=us.selectUserByID(uid);
		  request.setAttribute("name", u.getuName());
		  request.setAttribute("picture_url", u.getPicurl());
		  request.setAttribute("space", u.getAvaliable_space());
		
		  System.out.println(u.getAvaliable_space());
		  //通知类消息 to-do
		  List<Notice> three_notice=rs.loadThreeNotice(u.getuName());
		  request.setAttribute("three_notice", three_notice);
	
		  int unread=rs.getUnreadNotice(u.getuName());

		  request.setAttribute("unread", unread);
		  request.setAttribute("lv", "Lv."+(1+u.getPoints()/5));

		  return "forward:/main.jsp";

      } 
	  
	  @RequestMapping(value = "/uploadhead.do", method = RequestMethod.POST)
		public String upload(HttpServletRequest request,@RequestParam("file") MultipartFile[] file, ModelMap model) throws Exception {

			int uid=(int) request.getSession().getAttribute("uid");
	//		String parentid=request.getParameter("current_position")==null? "none":request.getParameter("current_position");

//		  	String currentPath="C://Users//18379//Desktop//mysqldemo//src//main";
//		  	String path = currentPath+"//webapp//upload//"+uid;//获取当前项目下的upload,社会主义改造期间改为..//upload//username//
		  String path ="/root/webapp/upload/"+uid;


				SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
				String fileName = df.format(new Date())+file[0].getOriginalFilename();//获取文件名

				File targetFile = new File(path, fileName);//判断文件是否存在，不存在则创建，可创建文件夹
				System.out.println(path);
		 		 if (!targetFile.exists()) {

					 boolean r=	targetFile.createNewFile();
					 if(!r){
						 throw new Exception("创建失败");
					 }
				}
				try {
					file[0].transferTo(targetFile);//此方法在上传完成后才开始上传


					us.changeheadpic("/upload/"+uid+"/"+fileName,uid);
				} catch (Exception e) {

					LogConfig.getLOG().error("错误信息", e);
				}

			return path+fileName;
		}
	  
	   @RequestMapping(value="/refreshHead",produces = "text/html;charset=UTF-8")
		@ResponseBody
		public String refreshHead(HttpServletRequest request) throws Exception{
		
			int uid=(int) request.getSession().getAttribute("uid");
			User u=us.selectUserByID(uid);
		
			return "{\"result\":\""+u.getPicurl()+"\"}";
		}
	   
	   @RequestMapping(value="/refreshSpace",produces = "text/html;charset=UTF-8")
	 		@ResponseBody
	 		public String refreshSpace(HttpServletRequest request) throws Exception{
	 	
	 			int uid=(int) request.getSession().getAttribute("uid");
	 			User u=us.selectUserByID(uid);
	 		
	 			return "{\"space\":\""+u.getAvaliable_space()+"\"}";
	 		}
	   
	   
	   
}
