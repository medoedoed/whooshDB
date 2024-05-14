package ru.medoedoed;

import ru.medoedoed.services.WhooshService;
import ru.medoedoed.utils.ExplainHandler;

import java.sql.SQLException;

public class Main {
  public static void main(String[] args) throws SQLException {
    var service = new WhooshService();
    System.out.println("-----");
//    service.showAllActiveUserForFiveYears();
//    service.showAllOrdersByUser(368L);
    String res = service.showAllActiveUserForFiveYears();
    System.out.println(res);
    var time = ExplainHandler.getTime(res);
    System.out.println(time);

   System.out.println("-----");
  }
}