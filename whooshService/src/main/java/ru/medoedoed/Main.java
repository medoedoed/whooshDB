package ru.medoedoed;

import ru.medoedoed.services.WhooshService;

import java.sql.SQLException;

public class Main {
  public static void main(String[] args) throws SQLException {
    var service = new WhooshService();
    System.out.println("-----");
//    service.showAllActiveUserForFiveYears();
    service.showAllOrdersByUser(368L);
    System.out.println("-----");
  }
}