import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snap/Code.dart';
import 'package:snap/addFood.dart';
import 'package:snap/addUser.dart';
import 'package:snap/signUp.dart';
import 'package:snap/users.dart';
import 'package:snap/clientList.dart';
import 'package:snap/edit.dart';
import 'package:snap/menu.dart';
import 'package:snap/suggestions.dart';
import 'customer.dart';
import 'location.dart';
import 'logIn.dart';
String foodName;
String code;
String customerName;
String date;
bool State;
int cost;
void main() {
//making some users to show in history
  clientList.addCustomer(Customer(
    "pizza",
    "23456",
    "user1",
    "12/12/1400",
    false,
    120,
  ));
//making some users to show in history
  clientList.addCustomer(Customer(
    "rice",
    "23456",
    "user2",
    "12/12/1400",
    true,
    78,
  ));
Send();
 runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        //navigating to a page
        "main": (context) => addUser(),
        "/menu": (context) => editing(),
        "/earth": (context) => Location(),
        "/go": (context) => menu(),
        "hell": (context) => addFood(),
        "/code": (context) => Code(),
        "/suggestions": (context) => suggestions(),
      },
      title: 'Snap food!',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}
Widget welcome(context,String text,double height){
  return Container(
    margin: EdgeInsets.fromLTRB(0, height/2, 0, 0),
  width: 100,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Theme.of(context).primaryColor,
    ),
    child: Center(
        child: Text(text),
    ),

  );
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context).settings.arguments as int;
double height = MediaQuery.of(context).size.height;

return Scaffold(
  backgroundColor: const Color.fromARGB(244,255, 248, 246 ),
      body: SingleChildScrollView(
          child: Column(

        children: [
          GestureDetector(
            child: Row(
              children: [
                Spacer(),
                GestureDetector(
                  child: welcome(context, "sign up",height),
                  onTap: (

                  ){
                    Navigator.pushNamed(context, "main" , arguments: index);//go to sign up page
                  },
                ),
                Spacer(),
                GestureDetector(
                  child: welcome(context, "log in",height),
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => logIn()));//go to log in page
                  },
                ),
                Spacer(),
              ],
            ),

          ),


            ],
          ),



      ),
        

    );
  }
 
  
}
void Send() async{
  await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
    print('connected');
    serverSocket.writeln("the String is:start");
    serverSocket.listen((socket) {
      String show = String.fromCharCodes(socket).trim();
       List<String> user = List.empty(growable: true);
       user = show.split("\n");
       for(int i = 0; i< user.length ;i+5) {
         bool Fastfood , SeaFood , Home;
         String name = user.elementAt(i);
         String address = user.elementAt(i+1);
         String foodType = user.elementAt(i+2);
         String phone = user.elementAt(i+3);
         String password = user.elementAt(i+4);
         if(foodType.contains("fastfood"))
           Fastfood = true;
         else if(foodType.contains("seafood"))
           SeaFood = true;
         else
           Home = true;
           users.addUser(signUp(name, address, SeaFood, Home,Fastfood,phone,password));
       }
      //
    //  print(show);
    });

  });
}