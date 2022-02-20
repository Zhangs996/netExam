package util;

import java.util.Comparator;

import model.Lesson;

@SuppressWarnings("rawtypes")
public class SortLesson implements Comparator {
	public int compare(Object o1, Object o2) {
		Lesson s1 = (Lesson) o1;
		Lesson s2 = (Lesson) o2;
		if (s1.getId() > s2.getId()) {
			return 1;
		}
		return -1;
	}
}