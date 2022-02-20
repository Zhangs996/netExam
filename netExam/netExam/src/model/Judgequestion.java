package model;

import java.sql.Timestamp;

/**
 * Judgequestion entity. @author MyEclipse Persistence Tools
 */

public class Judgequestion implements java.io.Serializable {
	private static final long serialVersionUID = 5952689219411916553L;

	// Fields

	private Long id;
//	private Long lessonId;
	private Lesson lesson;
	private String question;
	private String level;
	private String answer;
	private Timestamp joinTime;

	// Constructors

	/** default constructor */
	public Judgequestion() {
	}

	/** full constructor */
	public Judgequestion(Lesson lesson, String question, String level, String answer, Timestamp joinTime) {
//		this.lessonId = lessonId;
		this.lesson = lesson;
		this.question = question;
		this.level = level;
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

	/*public Long getLessonId() {
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

	public String getLevel() {
		return this.level;
	}

	public void setLevel(String level) {
		this.level = level;
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