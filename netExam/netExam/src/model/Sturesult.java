package model;

import java.sql.Timestamp;

/**
 * Sturesult entity. @author MyEclipse Persistence Tools
 */

public class Sturesult implements java.io.Serializable {
	private static final long serialVersionUID = 5952689219411916553L;

	// Fields

	private Long id;
//	private Long stuId;
//	private Long examId;
	private Student student;
	private Exam exam;
	private Double resSingle;
	private Double resMore;
	private Double resJudge;
	private Double resTotal;
	private Timestamp joinTime;

	// Constructors

	/** default constructor */
	public Sturesult() {
	}

	/** full constructor */
	public Sturesult(Student student, Exam exam, Double resSingle, Double resMore, Double resJudge, Double resTotal,
			Timestamp joinTime) {
//		this.stuId = stuId;
//		this.examId = examId;
		this.student = student;
		this.exam = exam;
		this.resSingle = resSingle;
		this.resMore = resMore;
		this.resJudge = resJudge;
		this.resTotal = resTotal;
		this.joinTime = joinTime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	/*public Long getStuId() {
		return this.stuId;
	}

	public void setStuId(Long stuId) {
		this.stuId = stuId;
	}

	public Long getExamId() {
		return this.examId;
	}

	public void setExamId(Long examId) {
		this.examId = examId;
	}*/
	
	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public Exam getExam() {
		return exam;
	}

	public void setExam(Exam exam) {
		this.exam = exam;
	}

	public Double getResSingle() {
		return this.resSingle;
	}

	public void setResSingle(Double resSingle) {
		this.resSingle = resSingle;
	}

	public Double getResMore() {
		return this.resMore;
	}

	public void setResMore(Double resMore) {
		this.resMore = resMore;
	}

	public Double getResJudge() {
		return this.resJudge;
	}

	public void setResJudge(Double resJudge) {
		this.resJudge = resJudge;
	}

	public Double getResTotal() {
		return this.resTotal;
	}

	public void setResTotal(Double resTotal) {
		this.resTotal = resTotal;
	}

	public Timestamp getJoinTime() {
		return this.joinTime;
	}

	public void setJoinTime(Timestamp joinTime) {
		this.joinTime = joinTime;
	}

}