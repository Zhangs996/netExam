package model;

import java.sql.Timestamp;

/**
 * Optionalquestion entity. @author MyEclipse Persistence Tools
 */

public class Optionalquestion implements java.io.Serializable {
	private static final long serialVersionUID = 5952689219411916553L;
	// Fields

	private Long id;
	//private Long lessonId;
	private Lesson lesson;
	private String question;
	private String type;
	private String level;
	private String optionA;
	private String optionB;
	private String optionC;
	private String optionD;
	private String answer;
	private Timestamp joinTime;

	// Constructors

	/** default constructor */
	public Optionalquestion() {
	}

	/** full constructor */
	public Optionalquestion(Lesson lesson, String question, String type, String level, String optionA, String optionB,
			String optionC, String optionD, String answer, Timestamp joinTime) {
		//this.lessonId = lessonId;
		this.lesson = lesson;
		this.question = question;
		this.type = type;
		this.level = level;
		this.optionA = optionA;
		this.optionB = optionB;
		this.optionC = optionC;
		this.optionD = optionD;
		this.answer = answer;
		this.joinTime = joinTime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	/*
	public Long getLessonId() {
		return this.lessonId;
	}

	public void setLessonId(Long lessonId) {
		this.lessonId = lessonId;
	}*/
	public Lesson getLesson() {
		return lesson;
	}

	public void setLesson(Lesson lesson) {
		this.lesson = lesson;
	}

	public String getQuestion() {
		return this.question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLevel() {
		return this.level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getOptionA() {
		return this.optionA;
	}

	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}

	public String getOptionB() {
		return this.optionB;
	}

	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}

	public String getOptionC() {
		return this.optionC;
	}

	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}

	public String getOptionD() {
		return this.optionD;
	}

	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}

	public String getAnswer() {
		return this.answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Timestamp getJoinTime() {
		return this.joinTime;
	}

	public void setJoinTime(Timestamp joinTime) {
		this.joinTime = joinTime;
	}

}