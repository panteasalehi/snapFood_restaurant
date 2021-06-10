import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snap/menu.dart';
import 'package:snap/signUp.dart';
import 'package:snap/users.dart';
import 'package:flutter/cupertino.dart';
class addUser extends StatefulWidget {
  @override
  _addUserState createState() => _addUserState();
}

class _addUserState extends State<addUser> {
  var _formKey = GlobalKey<FormState>();
  String name;
  String address;
  String type;
  String phoneNumber;
  String password;
  bool isSeaFood;
  bool isFastFood;
  bool home;
  List<String> saver = List.empty(growable: true);
  String user = "";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "enter your name",
                ),

                onChanged: (String value) {
                  name= value;
                },

              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText:"enter your address",
                ),
                onChanged: (String value) {
                  address= value;
                },
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
              TextFormField(
                decoration: InputDecoration(
                  hintText:"enter your phone number",
                ),
                onChanged: (String value) {
                  phoneNumber= value;
                },
                validator: (String value){
                  for(int i =0 ; i < users.myUsers.length ; i++){
                    if(value == users.myUsers[i].phoneNumber)
                      return "enter another phone number";
                  }
                  if(value.length<3)
                    return "your phone number is not true";
                  return null;
                },

              ),
              TextFormField(
                onChanged: (String value) {
                  saver.add("the String is:"+value);
                  password= value;

                },

                validator: (String value){
                  if(value.length < 6) 
                    return "choose a longer password";
                  return null;
                },
                decoration: InputDecoration(
                  hintText:"enter your password",
                ),
              ),
              ElevatedButton(
                child: Text("add user!"),
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      user+="the String is" + name;
                      user+="the String is" + address;
                      user+="the String is" + isFastFood.toString();
                      user+="the String is" + isSeaFood.toString();
                      user+="the String is" + home.toString();
                      user+="the String is" + phoneNumber;
                      user+="the String is" + password;
                      _formKey.currentState.save();
                      Send(user);
                      users.addUser(signUp(name, address, phoneNumber, password,isSeaFood,home,isFastFood));
                      Navigator.pushNamed(context,"/go",arguments: users.getUsers().length-1);//ba botton shit msl ye safhe barkhord mikone
                    });

                  }
                },
              ),

            ],


          ),

        ),
      ),

    );

  }

  void Send(String str) async{
    await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
      print('connected');
      String signUp = "the String is:signup";
      signUp+=str;
      serverSocket.writeln(signUp);
      serverSocket.listen((socket) {
        String show = String.fromCharCodes(socket).trim();
        print(show);
        setState(() {
        });
      });

    });
  }
}