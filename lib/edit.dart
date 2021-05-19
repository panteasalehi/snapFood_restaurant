import 'package:flutter/material.dart';
import 'package:snap/SearchDemo.dart';
import 'package:snap/foodS.dart';
import 'package:snap/myfood.dart';
import 'package:snap/details.dart';

import 'Remove.dart';
import 'addFood.dart';
class editing extends StatefulWidget {
  @override
  _editingState createState() => _editingState();
}

class _editingState extends State<editing> {
  @override
  bool isSwitched = false;
  change(int number,String name , String p, String d){//this is the function for changing the food
    foodS.getFoods().elementAt(number).description=d;
    foodS.getFoods().elementAt(number).price=p;
    foodS.getFoods().elementAt(number).name=name;
  }
  delete(String name){
    for(int i = 0 ; i< foodS.getFoods().length;i++){
      if(name == foodS.getFoods().elementAt(i).name)
        foodS.removeFood(foodS.getFoods().elementAt(i));
    }
    var value = isSwitched;
    setState(() {
      isSwitched = value;//the food could not be deleted until the switch was not change :|
    });
  }
  @override

  Widget build(BuildContext context) {

    int index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(

      appBar: AppBar(
        title: Text('My App'),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.local_pizza_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => addFood()));//adding food
                },

              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.greenAccent,
                ),
                onPressed: () {
                  Navigator.push(context,new MaterialPageRoute(builder: (context) => Remove(delete)));//deleting food
                },

              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.greenAccent,
                ),
                onPressed: () {
                  Navigator.push(context,new MaterialPageRoute(builder: (context) => MyHomePage1()));//deleting food
                },

              )
            ],
          ),


        ],

      ),

      body: Container(
          child: ListView(
            children: List.generate(
                foodS.getFoods().length,
                    (index) {
                  bool switched=false;
                  bool l = false;
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,

                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(//showing list of foods
                      title: Text(foodS.getFoods().elementAt(index).getname(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(foodS.getFoods().elementAt(index).getdescription()+"\n"+"قیمت: "+foodS.getFoods().elementAt(index).getprice(),
                        style: TextStyle(
                          color: Colors.blueGrey,

                          fontSize: 14,
                        ),),
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                          minHeight: 100,//changing size of the image
                          maxWidth: 200,
                          maxHeight: 200,
                        ),

                        child: Image.asset(_showPic(foodS.getFoods().elementAt(index)), fit: BoxFit.cover),
                      ),
                      trailing:Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child:  Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purpleAccent,

                                  width: 3,
                                ),
                              ),

                              height: MediaQuery.of(context).size.height/20,
                              width: MediaQuery.of(context).size.width/4,
                              child: Center(
                                child: Text("مشاهده جزئیات"),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => details(change,index)));//this will pass the number of the food we want to change as index
                              });
                            },
                          ),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                            activeTrackColor: Colors.greenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                      //icon hay zaheri ye widget migigre


                    ),


                  );

                }
            ),

          )
      ),

    );
  }
}
String _showPic(myfood f){
  //if(!f.hasPic)
  return "snapfoodPic/images (3).jpeg";
  return f.picAdd;
}
