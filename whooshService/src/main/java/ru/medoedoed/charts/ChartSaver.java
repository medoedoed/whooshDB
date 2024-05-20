package ru.medoedoed.charts;

import org.knowm.xchart.BitmapEncoder;
import org.knowm.xchart.internal.chartpart.Chart;

import java.io.File;
import java.io.IOException;

public class ChartSaver {
  public void save(Chart chart, String name) throws IOException {
    String baseFileName = "./charts/" + name + ".png";
    String newFileName = baseFileName;

    int version = 1;
    while (new File(newFileName).exists()) {
      newFileName = baseFileName.replace(".png", version + ".png");
      version++;

    }
    BitmapEncoder.saveBitmapWithDPI(chart, newFileName, BitmapEncoder.BitmapFormat.PNG, 300);
  }
}
