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

  // 1. Показать все заказы определенноо пользователя (пользователь - параметр)

  public String showAllOrdersByUser(Long userId) throws SQLException {
    String query = "EXPLAIN ANALYZE select * from Orders where UserId = ?";
    return executeQuery(query, userId);
  }


  // 2. Показать количество активных пользвоателей за месяц в течение 5 лет

  public void showAllActiveUserForFiveYears() throws SQLException {
    String query = (
            "EXPLAIN ANALYZE SELECT" +
                    "    DATE_TRUNC('month', r.startdate) AS month_year," +
                    "    COUNT(DISTINCT o.UserID) AS active_users " +
                    "FROM " +
                    "    Orders o " +
                    "    JOIN Routes r ON o.RouteID = r.RouteID " +
                    "WHERE " +
                    "    r.startdate >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '5 year' " +
                    "GROUP BY " +
                    "    DATE_TRUNC('month', r.startdate), r.startdate " +
                    "ORDER BY \n" +
                    "    month_year;");

    System.out.println(executeQuery(query));
  }
}
