import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snap/edit.dart';
import 'package:snap/myfood.dart';
import 'foodS.dart';
import 'package:snap/users.dart';
class addFood extends StatefulWidget {
  @override
  _addFoodState createState() => _addFoodState();
}

class _addFoodState extends State<addFood> {
  String name;
  String price;
  String description;
  bool isFastFood = false;
  bool isSeaFood = false;
  bool home = false;

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute
        .of(context)
        .settings
        .arguments as int;

    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                onChanged: (String value) {
                  description = value;
                },
                decoration: InputDecoration(
                  hintText: "enter your food`s description",
                ),
              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "enter your food name",
                ),
                onChanged: (String value) {
                  name = value;
                },


              ),
              TextFormField(
                onChanged: (String value) {
                  price = value;
                },
                decoration: InputDecoration(
                  hintText: "enter your food`s price",
                ),
              ),
              Row(
                children: [
                  Text("choose your food type"),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.fastfood_rounded,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      isFastFood = true;
                    },

                  ),
                  IconButton(
                    icon: Icon(
                      Icons.beach_access,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      isSeaFood = true;
                    },

                  ),
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      home = true;
                    },

                  ),
                  Spacer(),

                ],
              ),
              ElevatedButton(
                child: Text("save!"),
                onPressed: () {
                  String type;
                  if(users.getUsers().elementAt(index).isFastFood)
                    type = "fastfood";
                  else if(users.getUsers().elementAt(index).isSeaFood)
                    type = "seafood";
                  else
                    type = "home";
                  String str = "the String isR:add food" + "the String is" +
                      name + "the String is" + price + "the String is" +
                      description + "the String is" + users
                      .getUsers()
                      .elementAt(index)
                      .phoneNumber + "the String is"
                      +"the String istype:"+type;
                  if (_formKey.currentState.validate()) {
                    foodS.addFood(new myfood(name, price, description), index);
                    SendFood(str);
                    setState(() {
                      _formKey.currentState.save();
                    });
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => editing()));
                  }
                },
              ),
            ],


          ),

        ),
      ),


    );
  }

  void SendFood(String str) async {
    await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
      print('connected');
      serverSocket.writeln(str);
    });
  }
}