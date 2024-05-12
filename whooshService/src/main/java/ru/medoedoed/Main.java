package ru.medoedoed;

import ru.medoedoed.services.WhooshService;

import java.sql.SQLException;

public class Main {
  public static void main(String[] args) throws SQLException {
    var service = new WhooshService();
//    service.showAllOrders();
    service.showAllUsers();
//    service.showAllOrdersByUser(190539L);
  }
}