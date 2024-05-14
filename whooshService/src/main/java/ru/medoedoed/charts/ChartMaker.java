package ru.medoedoed.charts;

import org.knowm.xchart.XYChart;
import org.knowm.xchart.XYChartBuilder;
import ru.medoedoed.services.WhooshService;
import ru.medoedoed.utils.ExplainHandler;
import ru.medoedoed.utils.arrayMethods;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

public class ChartMaker {
  private void makeChart(ArrayList<Double> times) throws IOException {
    var index = new ArrayList<Integer>();

    for (int i = 0; i < times.size(); i++) {
      index.add(i);
    }

    double min = arrayMethods.getMin(times);
    double max = arrayMethods.getMax(times);
    double mid = arrayMethods.getMiddle(times);

    XYChart chart = new XYChartBuilder().width(800).height(600).xAxisTitle("index").yAxisTitle("Time, ms").build();

    chart.addSeries("Active user query", index, times);

    chart.addSeries("Lowest time: " + min, Collections.singletonList(0), Collections.singletonList(min));
    chart.addSeries("Highest time: " + max, Collections.singletonList(0), Collections.singletonList(max));
    chart.addSeries("Middle time: " + String.format("%.2f", mid), Collections.singletonList(0), Collections.singletonList(mid));

    new ChartSaver().save(chart);
  }

  public void showAllOrdersByUserChart(int userId) throws SQLException, IOException {
    WhooshService service = new WhooshService();
    var times = new ArrayList<Double>();
    for (int i = 0; i < 100; i++) {
      times.add(ExplainHandler.getTime(service.showAllOrdersByUser(userId)));
    }

    makeChart(times);
  }

  public void showAllActiveUserForFiveYearsChart() throws IOException, SQLException {
    WhooshService service = new WhooshService();
    var times = new ArrayList<Double>();
    for (int i = 0; i < 100; i++) {
      times.add(ExplainHandler.getTime(service.showAllActiveUserForFiveYears()));
    }

    makeChart(times);
  }


}
