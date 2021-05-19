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
  static List<String> codes = List.empty(growable: true);
  static List<String> dates = List.empty(growable: true);
  static List<String> foodName = List.empty(growable: true);
  static List<bool> states = List.empty(growable: true);
  static List<int> money = List.empty(growable: true);
  static void addCustomer(Customer s){
    myCustomers.add(s);
    persons.add(s.customerName);
    codes.add(s.code);
    dates.add(s.date);
    foodName.add(s.foodName);
    states.add(s.State);
    money.add(s.cost);
  }
  static List<Customer> getCustomer(){
    return myCustomers;
  }
  static List<String> getpersons(){
    return persons;
  }
  static List<String> getcodes(){
    return codes;
  }
  static List<String> getfoodnames(){
    return foodName;
  }
  static List<String> getDate(){
    return dates;
  }
  static List<bool> getState(){
    return states;
  }
  static List<int> getCost(){
    return money;

  }








}