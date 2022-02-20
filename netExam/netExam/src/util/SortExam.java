package util;

import java.util.Comparator;

import model.Exam;

@SuppressWarnings("rawtypes")
public class SortExam implements Comparator {
	public int compare(Object o1, Object o2) {
		Exam s1 = (Exam) o1;
		Exam s2 = (Exam) o2;
		if (s1.getId() > s2.getId()) {
			return 1;
		}
		return -1;
	}
}