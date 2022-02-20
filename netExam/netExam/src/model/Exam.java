package model;

import java.sql.Timestamp;

/**
 * Exam entity. @author MyEclipse Persistence Tools
 */

public class Exam implements java.io.Serializable {
	private static final long serialVersionUID = 5952689219411916553L;

	// Fields

	private Long id;
	//private Long lessonId;
	private Lesson lesson;
	private Double singleScore;
	private Integer singleNum;
	private Double moreScore;
	private Integer moreNum;
	private Double judgeScore;
	private Integer judgeNum;
	private String level;
	private Long duration;
	private String status;
	private Timestamp joinTime;

	// Constructors

	/** default constructor */
	public Exam() {
	}

	/** full constructor */
	public Exam(Lesson lesson, Double singleScore, Integer singleNum, Double moreScore, Integer moreNum,
			Double judgeScore, Integer judgeNum, String level, Long duration, String status, Timestamp joinTime) {
		//this.lessonId = lessonId;
		this.lesson = lesson;
		this.singleScore = singleScore;
		this.singleNum = singleNum;
		this.moreScore = moreScore;
		this.moreNum = moreNum;
		this.judgeScore = judgeScore;
		this.judgeNum = judgeNum;
		this.level = level;
		this.duration = duration;
		this.status = status;
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

	public Double getSingleScore() {
		return this.singleScore;
	}

	public void setSingleScore(Double singleScore) {
		this.singleScore = singleScore;
	}

	public Integer getSingleNum() {
		return this.singleNum;
	}

	public void setSingleNum(Integer singleNum) {
		this.singleNum = singleNum;
	}

	public Double getMoreScore() {
		return this.moreScore;
	}

	public void setMoreScore(Double moreScore) {
		this.moreScore = moreScore;
	}

	public Integer getMoreNum() {
		return this.moreNum;
	}

	public void setMoreNum(Integer moreNum) {
		this.moreNum = moreNum;
	}

	public Double getJudgeScore() {
		return this.judgeScore;
	}

	public void setJudgeScore(Double judgeScore) {
		this.judgeScore = judgeScore;
	}

	public Integer getJudgeNum() {
		return this.judgeNum;
	}

	public void setJudgeNum(Integer judgeNum) {
		this.judgeNum = judgeNum;
	}

	public String getLevel() {
		return this.level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public Long getDuration() {
		return this.duration;
	}

	public void setDuration(Long duration) {
		this.duration = duration;
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