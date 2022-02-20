package util;

import java.util.Comparator;

import model.Judgequestion;

@SuppressWarnings("rawtypes")
public class SortJudgequestion implements Comparator {
	public int compare(Object o1, Object o2) {
		Judgequestion s1 = (Judgequestion) o1;
		Judgequestion s2 = (Judgequestion) o2;
		if (s1.getId() > s2.getId()) {
			return 1;
		}
		return -1;
	}
}