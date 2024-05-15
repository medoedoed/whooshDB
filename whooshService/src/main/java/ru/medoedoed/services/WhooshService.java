package ru.medoedoed.services;

import ru.medoedoed.utils.ConnectionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WhooshService {
  private String executeQuery(String query, Object... args) throws SQLException {
    Connection connection = ConnectionDB.getConnection();
    PreparedStatement explanationStatement = connection.prepareStatement(query);

    for (int i = 0; i < args.length; i++) {
      explanationStatement.setObject(i + 1, args[i]);
    }

    ResultSet explanationResult = explanationStatement.executeQuery();
    StringBuilder output = new StringBuilder();

    while (explanationResult.next()) {
      output.append(explanationResult.getString(1)).append("\n");
    }

    explanationResult.close();
    explanationStatement.close();
    connection.close();

    return output.toString();
  }

  /**
   * 1. Показать все заказы определенноо пользователя (пользователь - параметр)
   * @param userId
   * @return Explain String
   * @throws SQLException
   */
  public String showAllOrdersByUser(int userId) throws SQLException {
    String query = (
            "EXPLAIN ANALYZE " +
                    "SELECT " +
                    "* " +
                    "FROM Orders " +
                    "WHERE UserId = ?");
    return executeQuery(query, userId);
  }


  /**
   * 2. Показать количество активных пользвоателей за месяц в течение 5 лет
   * @return Explain String
   * @throws SQLException
   */

  public String showAllActiveUserForFiveYears() throws SQLException {
    String query = (
            "EXPLAIN ANALYZE " +
                    "SELECT" +
                    "    DATE_TRUNC('month', r.startdate) AS month_year," +
                    "    COUNT(DISTINCT o.UserID) AS active_users " +
                    "FROM " +
                    "    Orders o " +
                    "    JOIN Routes r ON o.RouteID = r.RouteID " +
                    "WHERE " +
                    "    r.startdate >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '5 year' " +
                    "GROUP BY " +
                    "    DATE_TRUNC('month', r.startdate), r.startdate " +
                    "ORDER BY" +
                    "    month_year;");

    return executeQuery(query);
  }

  /**
   * 3. Вывести все сообщения из определеного респонса и отсортировать по времени
   * @param userId
   * @return Explain String
   * @throws SQLException
   */

  public String showAllUserResponses(int userId) throws SQLException {
    String query = (
            "EXPLAIN ANALYZE " +
                    "SELECT " +
                    "sr.RequestID, " +
                    "sr.Header AS RequestHeader, " +
                    "sr.Body AS RequestBody, " +
                    "sr.Date AS RequestDate, " +
                    "sr.Solved, " +
                    "srs.ResponseID, " +
                    "srs.Header AS ResponseHeader, " +
                    "srs.Body AS ResponseBody, " +
                    "srs.Date AS ResponseDate " +
                    "FROM SupportRequests sr " +
                    "LEFT JOIN SupportResponses srs ON sr.RequestID = srs.RequestID " +
                    "WHERE sr.UserID = ? " +
                    "ORDER BY sr.Date, srs.Date;"
    );

    return executeQuery(query, userId);
  }

  /**
   * 4. вывести все самокаты в определенной области
   * @param longitude
   * @param latitude
   * @param radius (in km)
   * @return Explain String
   * @throws SQLException
   */

  public String showALlScootersInArea(double longitude, double latitude, int radius) throws SQLException {
    String query = (
            "EXPLAIN ANALYZE " +
                    "SELECT " +
                    "ScooterID, " +
                    "ScooterNumber, " +
                    "Longitude, " +
                    "Latitude, " +
                    "Available, " +
                    "CurrentCharge " +
                    "FROM Scooters " +
                    "WHERE " +
                    "SQRT(POW(Longitude - ?, 2) + POW(Latitude - ?, 2)) <= ? ");
    var angle = radius / 111;
    return executeQuery(query, longitude, latitude, angle);
  }

  /**
   * 5. вывести топ 100 пользваотелей потартивших наибольшее кол-во денег
   * @return Explain String
   * @throws SQLException
   */

  public String showTop100Users() throws SQLException {
    String query =
            ("EXPLAIN ANALYZE " +
                    "SELECT " +
                    "    u.UserID, " +
                    "    u.Name, " +
                    "    SUM(o.Cost) AS TotalSpent " +
                    "FROM Orders o " +
                    "JOIN Users u ON o.UserID = u.UserID " +
                    "GROUP BY u.UserID, u.Name " +
                    "ORDER BY TotalSpent DESC " +
                    "LIMIT 100;");
    return executeQuery(query);
  }

}

