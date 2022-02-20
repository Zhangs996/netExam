package action;

import java.util.ArrayList;

import dao.StuResultDao;
import model.*;

public class StuResultAction {
	//学生成绩dao对象
	private StuResultDao sturesultdao;

	public StuResultDao getSturesultdao() {
		return sturesultdao;
	}

	public void setSturesultdao(StuResultDao sturesultdao) {
		this.sturesultdao = sturesultdao;
	}
	
	//要分析的考试对象
	private Exam exam;
	
	
	public Exam getExam() {
		return exam;
	}

	public void setExam(Exam exam) {
		this.exam = exam;
	}
	
	//学生成绩集合
	private ArrayList<Sturesult> sturesults;
	
	public ArrayList<Sturesult> getSturesults() {
		return sturesults;
	}

	public void setSturesults(ArrayList<Sturesult> sturesults) {
		this.sturesults = sturesults;
	}
	
	//课程成绩分数统计对象
	private AnalysisGrade analysisGrade;

	public AnalysisGrade getAnalysisGrade() {
		return analysisGrade;
	}

	public void setAnalysisGrade(AnalysisGrade analysisGrade) {
		this.analysisGrade = analysisGrade;
	}

	//成绩分析
	public String analysis_grade() {
		exam = sturesultdao.total_by_exam_id(exam);
		sturesults = sturesultdao.anlysis_grade_hibernate(exam);
		analysisGrade = sturesultdao.analysis_sturesult(sturesults);
		
		return "success";
	}
	
}
