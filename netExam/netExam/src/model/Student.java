package model;

import java.sql.Timestamp;

/**
 * Student entity. @author MyEclipse Persistence Tools
 */

public class Student implements java.io.Serializable {
	private static final long serialVersionUID = 5952689219411916553L;

	// Fields

	private String id;
	private String name;
	private String pwd;
	private String sex;
	private String profession;
	private String cardNo;
	private String tel;
	private String status;
	private Timestamp joinTime;

	// Constructors

	/** default constructor */
	public Student() {
	}

	/** full constructor */
	public Student(String id, String name, String pwd, String sex, String profession, String cardNo, String tel,
			String status, Timestamp joinTime) {
		this.id = id;
		this.name = name;
		this.pwd = pwd;
		this.sex = sex;
		this.profession = profession;
		this.cardNo = cardNo;
		this.tel = tel;
		this.status = status;
		this.joinTime = joinTime;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getProfession() {
		return this.profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getTel() {
		return this.tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getJoinTime() {
		return this.joinTime;
	}

	public void setJoinTime(Timestamp joinTime) {
		this.joinTime = joinTime;
	}

}