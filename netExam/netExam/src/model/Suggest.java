package model;

import java.sql.Timestamp;

/**
 * Suggeset entity. @author MyEclipse Persistence Tools
 */

public class Suggest implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	//private String sno;
	private Student student;
	private String title;
	private String content;
	private Timestamp time;

	// Constructors

	/** default constructor */
	public Suggest() {
	}

	/** full constructor */
	public Suggest(Integer id, Student student, String title, String content, Timestamp time) {
		this.id = id;
		//this.sno = sno;
		this.student = student;
		this.title = title;
		this.content = content;
		this.time = time;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}
	
	/*public String getSno() {
		return this.sno;
	}

	public void setSno(String sno) {
		this.sno = sno;
	}*/
	

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

}