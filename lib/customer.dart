import 'dart:math';

class Customer{
  String foodName;
  String code;
  String customerName;
  String date;
  bool State;
  int cost;
  static int sells=0;

Customer(String foodName,String code,String customerName,String date,bool State,int cost){
  this.foodName = foodName;
  this.customerName = customerName;
  this.code = code;
  this.date = date;
  this.State = State;
  this.cost = cost;
  sells+=cost;
}

}