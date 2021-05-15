import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snap/addFood.dart';
import 'package:snap/choosePhoto.dart';
import 'package:snap/details.dart';
import 'foodS.dart';
import 'myfood.dart';
import 'package:snap/main.dart';
//first page
class editingMenu extends StatefulWidget {

  @override
  _editingMenuState createState() => _editingMenuState();
}

class _editingMenuState extends State<editingMenu> {

change(int number,String name , String p, String d){
  foodS.getFoods().elementAt(number).description=d;
  foodS.getFoods().elementAt(number).price=p;
  foodS.getFoods().elementAt(number).name=name;
}
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
                          trailing:GestureDetector(
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
                               Navigator.push(context, new MaterialPageRoute(builder: (context) => details(change,index)));
                              });
                            },
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
