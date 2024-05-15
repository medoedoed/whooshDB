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
  private void makeChart(ArrayList<Double> times, String name) throws IOException {
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

    new ChartSaver().save(chart, name);
  }

  public void showAllOrdersByUserChart() throws SQLException, IOException {
    WhooshService service = new WhooshService();
    int userId = 123;
    String name = "1task";
    var times = new ArrayList<Double>();
    for (int i = 0; i < 100; i++) {
      times.add(ExplainHandler.getTime(service.showAllOrdersByUser(userId)));
    }

    makeChart(times, name);
  }

  public void showAllActiveUserForFiveYearsChart() throws IOException, SQLException {
    WhooshService service = new WhooshService();
    String name = "2task";
    var times = new ArrayList<Double>();
    for (int i = 0; i < 100; i++) {
      times.add(ExplainHandler.getTime(service.showAllActiveUserForFiveYears()));
    }

    makeChart(times, name);
  }

  public void showAllUserResponsesChart() throws IOException, SQLException {
    WhooshService service = new WhooshService();
    String name = "3task";
    int userId = 3245;
    var times = new ArrayList<Double>();
    for (int i = 0; i < 100; i++) {
      times.add(ExplainHandler.getTime(service.showAllUserResponses(userId)));
    }

    makeChart(times, name);
  }

  public void showALlScootersInAreaChart() throws IOException, SQLException {
    WhooshService service = new WhooshService();
    String name = "4task";
    double longitude = 45;
    double latitude = 45;
    int radius = 5000;
    var times = new ArrayList<Double>();
    for (int i = 0; i < 100; i++) {
      times.add(ExplainHandler.getTime(service.showALlScootersInArea(longitude, latitude, radius)));
    }

    makeChart(times, name);
  }

  public void showTop100UsersChart() throws IOException, SQLException {
    WhooshService service = new WhooshService();
    String name = "5task";
    var times = new ArrayList<Double>();
    for (int i = 0; i < 100; i++) {
      times.add(ExplainHandler.getTime(service.showTop100Users()));
    }

    makeChart(times, name);
  }


}
