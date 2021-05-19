
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snap/Remove.dart';
import 'package:snap/addUser.dart';
import 'package:snap/clientList.dart';
import 'package:snap/details.dart';
import 'package:snap/edit.dart';
import 'package:snap/foodS.dart';
import 'package:snap/myfood.dart';
import 'customer.dart';
import 'logIn.dart';
String foodName;
String code;
String customerName;
String date;
bool State;
int cost;
void main() {

  clientList.addCustomer(Customer(
    "pizza",
    "23456",
    "user1",
    "12/12/1400",
    false,
    120,
  ));
  clientList.addCustomer(Customer(
    "rice",
    "23456",
    "user2",
    "12/12/1400",
    true,
    78,
  ));
 runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        "main": (context) => addUser(),
        "/menu": (context) => editing(),
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

