package ru.medoedoed;

import ru.medoedoed.charts.ChartMaker;

import java.io.IOException;
import java.sql.SQLException;

public class Main {
  public static void main(String[] args) throws SQLException, IOException {
    var chartMaker = new ChartMaker();
    chartMaker.showAllOrdersByUserChart();
    chartMaker.showAllActiveUserForFiveYearsChart();
    chartMaker.showAllUserResponsesChart();
    chartMaker.showALlScootersInAreaChart();
    chartMaker.showTop100UsersChart();
  }
}