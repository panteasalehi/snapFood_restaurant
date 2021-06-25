import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snap/signUp.dart';
import 'package:snap/users.dart';
import 'package:flutter/cupertino.dart';

import 'menu.dart';
class logIn extends StatefulWidget {
  @override
  _logInState createState() => _logInState()
  ;
}

class _logInState extends State<logIn> {
  var _formKey = GlobalKey<FormState>();

  String phoneNumber;
  String password;
  int index;
  bool flag = true;
  bool Wait = false;
  Future<String> ans ;
  @override
  Widget build(BuildContext context) {
    do{
      return Scaffold(
        body: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [

                TextFormField(
                  decoration: InputDecoration(
                    hintText:"enter your phone number",
                  ),
                  onChanged: (String value) {
                    phoneNumber= value;
                  },


                ),
                TextFormField(
                  onChanged: (String value) {
                    password= value;
                  },
                  decoration: InputDecoration(
                    hintText:"enter your password",
                  ),
                ),
                ElevatedButton(
                  child: Text("log in!"),

                  onPressed: (){
                    String str = "";
                  str+="the String is"+phoneNumber+"the String is"+password;
                    if (_formKey.currentState.validate()) {
                      SendLog(str);
                        setState(() {
                          _formKey.currentState.save();
                        });

                    }
                  },
                ),

              ],


            ),

          ),
        ),

      );
    }while(flag);

  }
  void SendLog(String str) async{
    await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
      print('connected');
      String logIn = "the String isR:login";
      logIn+=str;
      serverSocket.writeln(logIn);
      serverSocket.listen((socket) {
        String s = new String.fromCharCodes(socket).trim();
        if(s.contains("user")){
       flag = false;
          showAlertDialog(context);
        }
        else{
          List<String> logInUser = List.empty(growable: true);
          logInUser = s.split("the string is");
          bool sea = false, home= false , fast= false;

            if(logInUser.elementAt(0).isNotEmpty)
              print('not empty');
          if(logInUser.elementAt(2)=="seafood")
            sea = true;
          if(logInUser.elementAt(2)=="fastfood")
            fast = true;
          if(logInUser.elementAt(2)=="home")
            home = true;
          signUp sign = new signUp(logInUser.elementAt(0), logInUser.elementAt(1), sea, home, fast, logInUser.elementAt(3), logInUser.elementAt(4));
          users.removeUser(sign);
          users.addUser(sign);
          Navigator.pushNamed(context,"/go",arguments: users.getUsers().length-1);
     }
      });
    });
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },

  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("log in Alert"),
    content: Text("no such a user exist."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}