package org.enebakkif.draw;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

public class Draw {
	public static List<String> draw(int playerCount) {
		Random random = new Random();
		List<String> result = new ArrayList<String>();
		Set<Integer> used = new HashSet<Integer>();
		Set<Integer> usedInMatch = new HashSet<Integer>();

		for (int match = 0; match < 8; match++) {
			usedInMatch.clear();
			result.add("");
			result.add("Match " + (match + 1));

			for (int team = 0; team < 2; team++) {
				result.add("");
				result.add("Team " + (team + 1));

				for (int i = 0; i < 7; i++) {
					int playerNo;
					do {
						playerNo = random.nextInt(playerCount) + 1;
					} while (used.contains(playerNo)
							|| usedInMatch.contains(playerNo));

					result.add("" + playerNo);

					if (used.size() == playerCount - 1) {
						used.clear();
						result.add("  <");
					} else {
						used.add(playerNo);
					}
					usedInMatch.add(playerNo);
				}
			}
		}
		return result;
	}

	public static void main(String[] args) {
		for (String s : Draw.draw(21)) {
			System.out.println(s);
		}
	}
}
