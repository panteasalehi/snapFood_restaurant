import 'package:flutter/material.dart';
import 'myfood.dart';
import 'foodS.dart';
class Remove extends StatefulWidget {
  Function remove;
Remove(this.remove);
  @override
  _RemoveState createState() => _RemoveState();
}

class _RemoveState extends State<Remove> {

  String n;
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      body: Center(
        child: ListView(
            children:[
              TextFormField(
                onChanged: (String value){
                  n = value;
                },
              ),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                widget.remove(n);
                foodS.removeFood(foodS.getFoods().elementAt(index));
              }, child: Text("remove!"))
            ]
        ),

      ),
    );
  }
}
