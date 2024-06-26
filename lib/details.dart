import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snap/edit.dart';
import 'package:snap/foodS.dart';

import 'edit.dart';
//page 2
class details extends StatefulWidget {
  Function change;
  int num;
  details(this.change,this.num);
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
String Nname,Nprice,Ndescription;//the new names that we want have
  var _formKey;
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Container(
              child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(context: context,
                      builder: (context) =>
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                children: [
                                  TextFormField(
                                    onChanged: (String value) {//onchanged helps to save the entry
                                       Nname = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "enter your new name",
                                    ),
                                  ),
                                  TextFormField(
                                    onChanged: (String value) {
                                       Nprice = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "enter your new price",
                                    ),
                                  ),
                                  TextFormField(
                                    onChanged: (String value) {
                                       Ndescription = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "enter your new description",
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: Text("add"),
                                    onPressed: () {
                                      setState(() {
                                        widget.change(widget.num,Nname,Nprice,Ndescription);//when we call this function it will made the changes we want in the editing menu
                                       Navigator.push(context, new MaterialPageRoute(builder: (context) => editing()));//going back and seeing result
                                      });
                                    },
                                  ),

                                ],
                              ),
                              //listview chon do ta chiz mikhaiim
                            ),

                          ),
                    );
                  }
              ),),
          ],
        ),

      ),
    );
  }
}