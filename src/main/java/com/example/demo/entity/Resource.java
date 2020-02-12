package com.example.demo.entity;

import java.util.Date;

public class Resource {
	private String srcID; /* 组成为uid+时间+随机数 */
	private String name;
	private String type; /* folder,video,audio,picture,archive,file */
	private String size; /* none或者一个数字，以kb为单位 */
	private Date edit_time;
	private String srcurl;  //下载时才用到
	private String parentid;
	private int userid;
	private int state;
	
	

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getSrcID() {
		return srcID;
	}

	public void setSrcID(String srcID) {
		this.srcID = srcID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public Date getEdit_time() {
		return edit_time;
	}

	public void setEdit_time(Date date) {
		this.edit_time = (Date) date;
	}

	public String getSrcurl() {
		return srcurl;
	}

	public void setSrcurl(String srcurl) {
		this.srcurl = srcurl;
	}

	public String getParentid() {
		return parentid;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

}
