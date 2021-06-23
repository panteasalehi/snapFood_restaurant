import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snap/mySuggestion.dart';
import 'package:snap/users.dart';
class suggestions extends StatefulWidget {
  @override
  _suggestionsState createState() => _suggestionsState();
}

class _suggestionsState extends State<suggestions> {
  @override
  Widget build(BuildContext context) {
    int number = ModalRoute.of(context).settings.arguments as int;
    String ans;
    return Scaffold(
      appBar: AppBar(
        title: Text("comments"),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  String command = "the String isget suggestion" +"the String is"+users.getUsers().elementAt(number).phoneNumber;
                 getSuggestions(command);
                },

              ),
            ],
          ),
        ],
      ),
      body:  ListView(
        children: List.generate(
            mySuggestoin.SuggestionList.length,
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
                child: Form(

                  child: ListTile(
                      title: Text(mySuggestoin.SuggestionList.elementAt(index)),
                      //a simple textform field for answering
                      subtitle: TextFormField(
                        decoration: InputDecoration(
                          hintText:"enter your answer",
                        ),
                        onChanged: (String value) {
                          ans=value;
                        },
                        //onchanged will save the answer later we will use to send it
                      ),
                      leading: FlatButton(onPressed: (){
                        mySuggestoin.answerList.add(ans);
                        SendAns("str", index , number);
                      },child: Text("send"),color: Colors.greenAccent)
                  ),
                ),

              );
            }
        ),

      ),
    );
  }
  void getSuggestions(String command) async{
    await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
      serverSocket.writeln(command);
      serverSocket.listen((socket) {
        String show = String.fromCharCodes(socket).trim();
        List s = show.split("\n");
        for(int i = 0 ; i< s.length ; i++) {
          if(!mySuggestoin.SuggestionList.contains(s.elementAt(i)))
          mySuggestoin.SuggestionList.add(s.elementAt(i));
        }
        setState(() {
        });
      });
    });
  }
}



void SendAns(String str , int num , int number) async{
  await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
    print('connected');
    String suggestions = "the String isR:answer the suggestions";
    suggestions+=str;
    suggestions += "the String is:"+num.toString()+"the String is:"+users.getUsers().elementAt(number).phoneNumber +users.getUsers().elementAt(number).password ;
    serverSocket.writeln(suggestions);
  });
}

