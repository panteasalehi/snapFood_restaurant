import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snap/addFood.dart';

import 'foodS.dart';
import 'myfood.dart';


class editingMenu extends StatefulWidget {
  @override
  _editingMenuState createState() => _editingMenuState();
}

class _editingMenuState extends State<editingMenu> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.local_pizza_outlined,
              color: Colors.white,
            ),
            onPressed: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => addFood()));
            },
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: List.generate(
            foodS.getFoods().length,
                (index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration:  BoxDecoration(
                      border: Border.all(
                      color: Colors.purple,
                      width: 2,

                    ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(foodS.getFoods().elementAt(index).getname()),
                        leading: GestureDetector(
                          child: Icon(Icons.local_pizza_outlined),
                          onTap: () {
                            setState(() {

                            });
                          },
                          //icon hay zaheri ye widget migigre
                        )
                    ),


                  );

                }
          ),
        )
      ),

    );
  }
}
Widget _showFoods(int index){

  return Container(

  );
}