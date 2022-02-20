package model;

/**
 * Manager entity. @author MyEclipse Persistence Tools
 */

public class Manager implements java.io.Serializable {
	private static final long serialVersionUID = 5952689219411916553L;

	// Fields

	private String id;
	private String name;
	private String pwd;

	// Constructors

	/** default constructor */
	public Manager() {
	}

	/** full constructor */
	public Manager(String id, String name, String pwd) {
		this.id = id;
		this.name = name;
		this.pwd = pwd;
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

}