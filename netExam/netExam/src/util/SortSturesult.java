package util;

import java.util.Comparator;

import model.Sturesult;

@SuppressWarnings("rawtypes")
public class SortSturesult implements Comparator {
	public int compare(Object o1, Object o2) {
		Sturesult s1 = (Sturesult) o1;
		Sturesult s2 = (Sturesult) o2;
		if (s1.getId() > s2.getId()) {
			return 1;
		}
		return -1;
	}
}