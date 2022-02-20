package util;

import java.util.Comparator;

import model.AnalysisGrade;

@SuppressWarnings("rawtypes")
public class SortExamStuResult implements Comparator {
	public int compare(Object o1, Object o2) {
		AnalysisGrade s1 = (AnalysisGrade) o1;
		AnalysisGrade s2 = (AnalysisGrade) o2;
		if (s1.getExam().getId() > s2.getExam().getId()) {
			return 1;
		}
		return -1;
	}
}
