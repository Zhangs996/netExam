package model;

public class AnalysisGrade {
	private Exam exam;
	private String examNum;
	private String passRate;
	private String maxScore;
	private String minScore;
	private String averageScore;
	private String averageSingle;
	private String averageMore;
	private String averageJudge;
	
	public AnalysisGrade() {
		super();
	}
	
	public AnalysisGrade(String examNum, String passRate, String maxScore, String minScore, String averageScore,
			String averageSingle, String averageMore, String averageJudge) {
		super();
		this.examNum = examNum;
		this.passRate = passRate;
		this.maxScore = maxScore;
		this.minScore = minScore;
		this.averageScore = averageScore;
		this.averageSingle = averageSingle;
		this.averageMore = averageMore;
		this.averageJudge = averageJudge;
	}
	
	public AnalysisGrade(Exam exam, String examNum, String passRate, String maxScore, String minScore,
			String averageScore, String averageSingle, String averageMore, String averageJudge) {
		super();
		this.exam = exam;
		this.examNum = examNum;
		this.passRate = passRate;
		this.maxScore = maxScore;
		this.minScore = minScore;
		this.averageScore = averageScore;
		this.averageSingle = averageSingle;
		this.averageMore = averageMore;
		this.averageJudge = averageJudge;
	}

	public Exam getExam() {
		return exam;
	}

	public void setExam(Exam exam) {
		this.exam = exam;
	}

	public String getExamNum() {
		return examNum;
	}

	public void setExamNum(String examNum) {
		this.examNum = examNum;
	}

	public String getPassRate() {
		return passRate;
	}

	public void setPassRate(String passRate) {
		this.passRate = passRate;
	}

	public String getMaxScore() {
		return maxScore;
	}

	public void setMaxScore(String maxScore) {
		this.maxScore = maxScore;
	}

	public String getMinScore() {
		return minScore;
	}

	public void setMinScore(String minScore) {
		this.minScore = minScore;
	}

	public String getAverageScore() {
		return averageScore;
	}

	public void setAverageScore(String averageScore) {
		this.averageScore = averageScore;
	}

	public String getAverageSingle() {
		return averageSingle;
	}

	public void setAverageSingle(String averageSingle) {
		this.averageSingle = averageSingle;
	}

	public String getAverageMore() {
		return averageMore;
	}

	public void setAverageMore(String averageMore) {
		this.averageMore = averageMore;
	}

	public String getAverageJudge() {
		return averageJudge;
	}

	public void setAverageJudge(String averageJudge) {
		this.averageJudge = averageJudge;
	}

}