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
    int turn;
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
                    while(true){
                      for(int i = 0 ; i<users.getUsers().length ; i++){
                        if(users.getUsers().elementAt(i).password == password && users.getUsers().elementAt(i).phoneNumber == phoneNumber) {
                          turn = i;
                          break;
                        }
                      }
                      break;
                    }

                    String str = "";
                  str+="the String is"+phoneNumber+"the String is"+password;

                    if (_formKey.currentState.validate()) {
                      Send(str , turn);
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
    }while(!flag);

  }
  void Send(String str , int turn) async{
    await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
      print('connected');
      String logIn = "the String islogin";
      logIn+=str;
      serverSocket.writeln(logIn);
      serverSocket.listen((socket) {
        String s = String.fromCharCodes(socket).trim();
     if(s.contains("user")){
       flag = false;
          showAlertDialog(context);
     }
     else{
       flag = true;
       print("the turn is "+turn.toString());
          Navigator.pushNamed(context,"/go",arguments: turn);
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