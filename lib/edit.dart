import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap/SearchDemo.dart';
import 'package:snap/addPhoto.dart';
import 'package:snap/foodS.dart';
import 'package:snap/menu.dart';
import 'package:snap/details.dart';
import 'package:http/http.dart' as http;
import 'Remove.dart';
class editing extends StatefulWidget {
  @override
  _editingState createState() => _editingState();
}

class _editingState extends State<editing> {
  @override
  bool isSwitched = false;
  final picker = ImagePicker();
  Future getImage(int num) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        foodS.getFoods().elementAt(num).image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }

    });
  }

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
                  Navigator.pushNamed(context,"hell",arguments: index);//adding food
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

              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.greenAccent,
                ),
                onPressed: () {
                  Navigator.push(context,new MaterialPageRoute(builder: (context) => menu()));//deleting food
                },

              ),
            ],
          ),


        ],

      ),

      body: Container(
          child: ListView(
            children: List.generate(
                foodS.getFoods().length,
                    (index) {
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

                      trailing:Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child:  Container(
                              height: MediaQuery.of(context).size.height/30,
                              width: MediaQuery.of(context).size.width/12,
                              child: Center(
                                child: Text("pic"),
                              ),
                            ),
                            onTap: (){
                              setState(() {


                                Navigator.push(context, new MaterialPageRoute(builder: (context) => addPhoto(getImage,index)));
                              });

                            },
                          ),
                          GestureDetector(
                            child:  Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purpleAccent,

                                  width: 3,
                                ),
                              ),

                              height: MediaQuery.of(context).size.height/24,
                              width: MediaQuery.of(context).size.width/6,
                              child: Center(
                                child: Text("جزئیات"),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => details(change,index)));//this will pass the number of the food we want to change as index
                              });
                            },
                          ),
                          Switch(
                            value: foodS.getFoods().elementAt(index).state,
                            onChanged: (value) {
                              setState(() {
                               foodS.getFoods().elementAt(index).state = value;
                              });
                            },
                            activeTrackColor: Colors.greenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                      leading: foodS.getFoods().elementAt(index).image == null
                        ? Image.asset("snapfoodPic/images (3).jpeg")
                        : Image.file(foodS.getFoods().elementAt(index).image),
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