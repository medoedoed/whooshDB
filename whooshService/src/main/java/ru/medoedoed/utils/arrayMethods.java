package ru.medoedoed.utils;

import java.util.List;

public class arrayMethods {
  public static double getMax(List<Double> array) {
    var max = array.getFirst();
    for (int i = 1; i < array.size(); i++) {
      if (array.get(i) > max) {
        max = array.get(i);
      }
    }
    return max;
  }

  public static double getMin(List<Double> array) {
    var min = array.getFirst();
    for (int i = 1; i < array.size(); i++) {
      if (array.get(i) < min) {
        min = array.get(i);
      }
    }
    return min;
  }

  public static double getMiddle(List<Double> array) {
    Double sum = 0d;
    for (Double aDouble : array) {
      sum += aDouble;
    }
    return sum / array.size();

  }

}
