package ru.medoedoed.services;

import ru.medoedoed.utils.ConnectionDB;

import java.sql.*;

public class WhooshService {

  public void showAllOrders() throws SQLException {
    Connection connection = ConnectionDB.getConnection();
    PreparedStatement statement = connection.prepareStatement("select * from Orders");
    ResultSet resultSet = statement.executeQuery();

    while (resultSet.next()) {
      int orderId = resultSet.getInt("OrderId");
      int userId = resultSet.getInt("UserId");

      System.out.println(orderId + "\t\t" + userId);
    }
  }
  public void showAllUsers() throws SQLException {
    Connection connection = ConnectionDB.getConnection();
    PreparedStatement statement = connection.prepareStatement("select * from Users");
    ResultSet resultSet = statement.executeQuery();


    System.out.println("id\t\tname\t\temail");

    while (resultSet.next()) {
      int id = resultSet.getInt("UserId");
      String name = resultSet.getString("Name");
      String email = resultSet.getString("Email");
      String phone = resultSet.getString("PhoneNumber");
      int walletId = resultSet.getInt("WalletId");
      int subscribeTypeId = resultSet.getInt("SubscribeTypeID");
      System.out.println(id + "\t\t" + name + "\t\t" + email + "\t\t" + phone + "\t\t" + walletId + "\t\t" + subscribeTypeId);
    }
  }

  public void showAllOrdersByUser(Long userId) throws SQLException {
    Connection connection = ConnectionDB.getConnection();
    PreparedStatement statement = connection.prepareStatement("select * from Orders where UserId = ?");
    statement.setLong(1, userId);
    ResultSet resultSet = statement.executeQuery();
    System.out.println(userId);

    while (resultSet.next()) {
      int orderId = resultSet.getInt("UserId");
      String name = resultSet.getString("Name");
      System.out.println(orderId + "\t\t" + name);
    }
  }
}
