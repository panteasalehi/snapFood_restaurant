import 'package:flutter/material.dart';
import 'package:snap/signUp.dart';
import 'package:snap/users.dart';
import 'package:flutter/cupertino.dart';
class logIn extends StatefulWidget {
  @override
  _addUserState createState() => _addUserState();
}

class _addUserState extends State<logIn> {
  var _formKey = GlobalKey<FormState>();

  String phoneNumber;
  String password;
  int index;
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
                  hintText:"enter your phone number",
                ),
                onSaved: (String value) {
                  phoneNumber= value;
                },
                validator: (String value){
                  for(int i =0 ; i < users.myUsers.length ; i++){
                    if(value == users.myUsers[i].phoneNumber){
                      index = 1;
                      return null;
                    }
                  }
                  return "this user does not exist";
                },

              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText:"enter your password",
                ),
                onSaved: (String value) {
                  password= value;
                },
                validator: (String value){
                  if(users.myUsers[index].password==value)
                    return null;
                  return "the password is wrong";
                },


              ),

              ElevatedButton(

                child: Text("log in!"),
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _formKey.currentState.save();
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

