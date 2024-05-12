package ru.medoedoed.utils;

import java.sql.DriverManager;
import java.sql.SQLException;

public class Connection {
  Connection con = null;

  public static Connection connectDB() {

    try {
      Connection con = DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/hotelman",
              "root", "1234");
      // here,root is the username and 1234 is the
      // password,you can set your own username and
      // password.
      return con;
    } catch (SQLException | ClassNotFoundException e) {

      System.out.println(e);
    }
  }
}
