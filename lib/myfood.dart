import 'dart:io';

import 'package:flutter/cupertino.dart';

class myfood{
  String name;
  String price;
  String description;
  bool state = false;
  File image = null;
  myfood( String name , String price,String description){
    this.name =  name;
    this.price = price;
    this.description = description;
  }
  String getname (){
    return name;
  }
  String getprice (){
    return price;
  }
  String getdescription (){
    return description;
  }

}