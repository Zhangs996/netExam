package model;

import java.sql.Timestamp;

/**
 * Lesson entity. @author MyEclipse Persistence Tools
 */


public class Lesson implements java.io.Serializable {
	private static final long serialVersionUID = 5952689219411916553L;
	
	// Fields

	private Long id;
	private String name;
	private Timestamp joinTime;

	// Constructors

	/** default constructor */
	public Lesson() {
	}

	/** full constructor */
	public Lesson(String name, Timestamp joinTime) {
		this.name = name;
		this.joinTime = joinTime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getJoinTime() {
		return this.joinTime;
	}

	public void setJoinTime(Timestamp joinTime) {
		this.joinTime = joinTime;
	}

}