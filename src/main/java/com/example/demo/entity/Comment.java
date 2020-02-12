package com.example.demo.entity;

import java.util.Date;

public class Comment {
	private String srcID;
	private Date time;
	private int commenter_id;
	private String commenter_name;
	private String content;
	private String commenter_pic;
	
	public String getCommenter_pic() {
		return commenter_pic;
	}
	public void setCommenter_pic(String commenter_pic) {
		this.commenter_pic = commenter_pic;
	}
	public String getSrcID() {
		return srcID;
	}
	public void setSrcID(String srcID) {
		this.srcID = srcID;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public int getCommenter_id() {
		return commenter_id;
	}
	public void setCommenter_id(int commenter_id) {
		this.commenter_id = commenter_id;
	}
	public String getCommenter_name() {
		return commenter_name;
	}
	public void setCommenter_name(String commenter_name) {
		this.commenter_name = commenter_name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

}
