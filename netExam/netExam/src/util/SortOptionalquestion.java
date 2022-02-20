package util;

import java.util.Comparator;

import model.Optionalquestion;

@SuppressWarnings("rawtypes")
public class SortOptionalquestion implements Comparator {
	public int compare(Object o1, Object o2) {
		Optionalquestion s1 = (Optionalquestion) o1;
		Optionalquestion s2 = (Optionalquestion) o2;
		if (s1.getId() > s2.getId()) {
			return 1;
		}
		return -1;
	}
}