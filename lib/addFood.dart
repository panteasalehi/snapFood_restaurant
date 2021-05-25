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
  bool isFastFood=false;
  bool isSeaFood=false;
  bool home=false;
  static List<myfood> seaFoodS = List.empty(growable: true);
  static List<myfood> fastFoodS = List.empty(growable: true);
  static List<myfood> homeFoodS = List.empty(growable: true);
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
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _formKey.currentState.save();
                      setState(() {
                        if(isSeaFood)
                          seaFoodS.add(new myfood(name, price, description));
                        if(isFastFood)
                          fastFoodS.add(new myfood(name, price, description));
                        if(home)
                          homeFoodS.add(new myfood(name, price, description));

                          foodS.addFood(new myfood(name, price, description));
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
