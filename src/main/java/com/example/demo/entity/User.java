package com.example.demo.entity;

public class User {
	private int uID;
	private String uName;
	private String password;
	private String email;
	private String picurl;
	private int avaliable_space;
	private int points  ;
	
	
	public int getPoints() {
		return points;
	}
	public void setPoints(int points) {
		this.points = points;
	}
	public int getuID() {
		return uID;
	}
	public void setuID(int uID) {
		this.uID = uID;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public int getAvaliable_space() {
		return avaliable_space;
	}
	public void setAvaliable_space(int avaliable_space) {
		this.avaliable_space = avaliable_space;
	}
	
	

}
