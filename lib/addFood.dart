import 'package:flutter/material.dart';
import 'package:snap/edit.dart';
import 'package:snap/myfood.dart';

import 'foodS.dart';
class addFood extends StatefulWidget {
  @override
  _addFoodState createState() => _addFoodState();
}

class _addFoodState extends State<addFood> {
  String name;
  String price;
  String description;
  bool hasPic=false;
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

              ElevatedButton(
                child: Text("save!"),
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _formKey.currentState.save();
                      setState(() {
                        foodS.addFood(new myfood(name, price, description, hasPic));
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => editing()));
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
