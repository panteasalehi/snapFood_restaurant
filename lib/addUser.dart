import 'package:flutter/material.dart';
import 'package:snap/signUp.dart';
import 'package:snap/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

                onSaved: (String value) {
                  name= value;
                },

              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText:"enter your address",
                ),
                onSaved: (String value) {
                  address= value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText:"enter the type of food",
                ),
                onSaved: (String value) {

                  type= value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText:"enter your phone number",
                ),
                onSaved: (String value) {
                  phoneNumber= value;
                },
                validator: (String value){
                  for(int i =0 ; i < users.myUsers.length ; i++){
                    if(value == users.myUsers[i].phoneNumber)
                      return "enter another phone number";
                  }
                  return null;
                },

              ),
              TextFormField(
                onSaved: (String value) {
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
                      _formKey.currentState.save();
                      users.addUser(signUp(name, address, type, phoneNumber, password));
                      Navigator.pop(context);//ba botton shit msl ye safhe barkhord mikone
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
}

