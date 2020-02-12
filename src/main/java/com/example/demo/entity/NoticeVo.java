package com.example.demo.entity;

import java.util.Date;

public class NoticeVo {
	private String nid;
	private int classification;
	private String communicater;
	private String size;
	private String srcID;
	private String srcName;
	private Date time;
	
	
	
	public String getNid() {
		return nid;
	}
	public void setNid(String nid) {
		this.nid = nid;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public int getClassification() {
		return classification;
	}
	public void setClassification(int classification) {
		this.classification = classification;
	}
	public String getCommunicater() {
		return communicater;
	}
	public void setCommunicater(String communicater) {
		this.communicater = communicater;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getSrcID() {
		return srcID;
	}
	public void setSrcID(String srcID) {
		this.srcID = srcID;
	}
	public String getSrcName() {
		return srcName;
	}
	public void setSrcName(String srcName) {
		this.srcName = srcName;
	}
	
	
	
	
	

}
