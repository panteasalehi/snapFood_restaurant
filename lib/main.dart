
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snap/addUser.dart';

import 'logIn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "main": (context) => addUser(),

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
