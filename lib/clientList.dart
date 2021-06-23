import 'package:flutter/cupertino.dart';
import 'package:snap/customer.dart';

/*
  String foodName;
  String code;
  String customerName;
  String date;
  bool State;
  int cost;
 */
class clientList{
  static List<Customer> myCustomers= List.empty(growable: true);
  static List<String> persons = List.empty(growable: true);
  static List<String> foodName = List.empty(growable: true);
  static List<int> money = List.empty(growable: true);
  static void addCustomer(Customer s){
    myCustomers.add(s);
    persons.add(s.customerName);
    foodName.add(s.foodName);
    money.add(s.cost);
  }
  static List<Customer> getCustomer(){
    return myCustomers;
  }
  static List<String> getpersons(){
    return persons;
  }
  static List<String> getfoodnames(){
    return foodName;
  }
  static List<int> getCost(){
    return money;

  }








}