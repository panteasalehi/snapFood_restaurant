import 'package:flutter/material.dart';
import 'package:snap/editingMenu.dart';
import 'package:snap/myfood.dart';

import 'foodS.dart';
class addFood extends StatefulWidget {
  @override
  _addFoodState createState() => _addFoodState();
}

class _addFoodState extends State<addFood> {
  String name;
  String price;
  bool state;
  String description;
  bool hasPic;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                onSaved: (String value) {
                  description= value;
                },
                decoration: InputDecoration(
                  hintText:"enter your food`s description",
                ),
              ),

              TextFormField(
                onSaved: (String value) {
                  price= value;
                },
                decoration: InputDecoration(
                  hintText:"enter your food`s photo address",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText:"enter your food name",
                ),
                onSaved: (String value) {
                  name= value;
                },


              ),
              TextFormField(
                onSaved: (String value) {
                  price= value;
                },
                decoration: InputDecoration(
                  hintText:"enter your food`s price",
                ),
              ),
              TextFormField(
                onSaved: (String value) {
                  if(value=="1")
                    state = true;
                  else
                    state = false;
                },
                validator: (String value){
                  if(value != "1" && value != "2")
                    return "enter 1 or 2 please";
                    return null;

                },
                decoration: InputDecoration(
                  hintText:"is your food available? 1_yes 2_no",
                ),
              ),
              ElevatedButton(
                child: Text("save!"),
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _formKey.currentState.save();
                      setState(() {
                        foodS.addFood(new myfood(name, price, state, description, hasPic));
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => editingMenu()));
                      },
                      );

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
