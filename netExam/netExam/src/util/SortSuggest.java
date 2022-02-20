package util;

import java.util.Comparator;

import model.Suggest;

@SuppressWarnings("rawtypes")
public class SortSuggest implements Comparator {
	public int compare(Object o1, Object o2) {
		Suggest s1 = (Suggest) o1;
		Suggest s2 = (Suggest) o2;
		if (s1.getId() > s2.getId()) {
			return 1;
		}
		return -1;
	}
}