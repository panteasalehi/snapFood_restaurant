import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snap/report.dart';
import 'package:snap/suggestions.dart';
class menu extends StatefulWidget {
  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {

    int index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
    body: Container(
      child: ListView(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 70, 0, 0)),

          Row(
            children: [
              Spacer(),
              GestureDetector(
                child: _choice(context, "snapfoodPic/images.jfif", "editing menu"),
                onTap: (){
                  Navigator.pushNamed(context, "/menu" , arguments: index);
                },
              ),

              Spacer(),
              GestureDetector(
                child: _choice(context, "snapfoodPic/download.jfif", "adding photo"),
                onTap: (){

                },
              ),
              Spacer(),
            ],
          ),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                child:  _choice(context, "snapfoodPic/download (1).jfif", "suggestions"),
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => MyStatefulWidget()));
                },
              ),
              Spacer(),
              GestureDetector(
                child:  _choice(context, "snapfoodPic/images (2).jfif", "History"),
                onTap: (){

                },
              ),

              Spacer(),
            ],
          ),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                child: _choice(context, "snapfoodPic/images (1).jfif", "accounting"),
                onTap: (){

                },
              ),

              Spacer(),
            ],
          ),

        ],
      ),
    ),
    );

  }
}
Widget _choice(context,String picAdd , String name){
  Size size =  MediaQuery.of(context).size;
  return Container(
   child:Column(
     children: [
       Container(
         height: size.height/6,
         width: size.width/3,
         child: Image.asset(picAdd),
       ),
       Text(name),
     ],
   ),
  );
}