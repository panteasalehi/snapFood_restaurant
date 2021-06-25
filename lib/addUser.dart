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
  String open , close;
  bool isSeaFood;
  bool isFastFood;
  bool home;
  bool flag = true;
  String distance;
  List<String> saver = List.empty(growable: true);
  String user = "";
  bool _obscureText = true;

  String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
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
              ],
            ),
                TextFormField(
                  onChanged: (String value) {
                    open= value;
                  },
                  decoration: InputDecoration(
                    hintText:"enter opening hour",
                  ),
                ),
                TextFormField(
                  onChanged: (String value) {
                    close= value;
                  },
                  decoration: InputDecoration(
                    hintText:"enter closing hour",
                  ),
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
              obscureText: _obscureText,
              validator: (String value){
                if(value.length < 6)
                  return "choose a longer password";
                int c = 0 ,  n = 0;
                for(int i =0 ; i < value.length; i++){
                  String s = value.substring(i , i+1);
                 if(s=='1' || s=='2' || s=='3' || s=='4' || s=='5' || s=='6' || s=='7' || s=='8' || s=='9')
                   n++;
                 else
                   c++;
                 if(n>0 && c>0)
                   return null;
                }
                if(n<=0 || c<=0)
                  return "password should contain at least one character and one number";
                return null;
              },
              decoration: InputDecoration(
                hintText:"enter your password",
              ),

            ),
            new FlatButton(
                onPressed: _toggle,
                child: new Text(_obscureText ? "Show" : "Hide")),
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
                    user+="the String is" + open;
                    user+="the String is" + close;
                    _formKey.currentState.save();
                    SendSignUp(user);
                    signUp s = signUp(name, address,isSeaFood,home,isFastFood, phoneNumber, password);
                    users.addUser(s);
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

  void SendSignUp(String str) async{
    await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
      print('connected');
      String signUp = "the String isR:signup";
      signUp+=str;
      serverSocket.writeln(signUp);
      serverSocket.listen((socket) {
        String s = new String.fromCharCodes(socket).trim();
        if(s.contains("user")){
          flag = false;
          showAlertDialog(context);
        }
        else{
          Navigator.pushNamed(context,"/go",arguments: users.getUsers().length-1);//ba botton shit msl ye safhe barkhord mikone
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
    title: Text("sign up Alert"),
    content: Text("error"),
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