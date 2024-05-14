package ru.medoedoed.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ExplainHandler {
  public static double getTime(String result) {
//    String patternCost = "GroupAggregate  \\(cost=\\d+.\\d+..(\\d+.\\d+)";
    String patternTime = "Execution Time: (\\d+.\\d+) ms";

    Pattern r = Pattern.compile(patternTime);
    Matcher m = r.matcher(result);
    if (m.find()) {
      return Double.parseDouble(m.group(1));
    } else {
      return -1;
    }
  }
}
