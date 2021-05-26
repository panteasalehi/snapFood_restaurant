import 'package:flutter/material.dart';
import 'package:snap/mySuggestion.dart';
class suggest extends StatefulWidget {
  @override
  _suggestState createState() => _suggestState();
}

class _suggestState extends State<suggest> {
  @override
  Widget build(BuildContext context) {
    String ans;
    return Scaffold(
      appBar: AppBar(
        title: Text("comments"),
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
            subtitle: TextFormField(
              decoration: InputDecoration(
                hintText:"enter your answer",
              ),
              onSaved: (String value) {
               ans=value;
              },


            ),
             leading: FlatButton(onPressed: (){
               mySuggestoin.answerList.add(ans);

             },child: Text("send"),color: Colors.greenAccent)
          ),
        ),

      );
    }
    ),

    ),
    );
  }
}

