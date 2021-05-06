import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class menu extends StatefulWidget {
  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: Container(
      child: ListView(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 70, 0, 0)),

          Row(
            children: [
              Spacer(),
              _choice(context, "snapfoodPic/images.jfif", "editing menu"),
              Spacer(),
              _choice(context, "snapfoodPic/download.jfif", "adding photo"),
              Spacer(),
            ],
          ),
          Row(
            children: [
              Spacer(),
              _choice(context, "snapfoodPic/download (1).jfif", "suggestions"),
              Spacer(),
              _choice(context, "snapfoodPic/images (2).jfif", "History"),
              Spacer(),
            ],
          ),
          Row(
            children: [
              Spacer(),
              _choice(context, "snapfoodPic/images (1).jfif", "accounting"),
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