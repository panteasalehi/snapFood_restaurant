import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snap/signUp.dart';
import 'package:snap/users.dart';

class sign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(users.getUsers().elementAt(index).getName()),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14),//hal moshkel nazdik boodan boaeder b neveshte
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.deepPurple,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child:  Text(users.getUsers().elementAt(index).getName()),
            ),
            Container(
              padding: EdgeInsets.all(14),//hal moshkel nazdik boodan boaeder b neveshte
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.deepPurple,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child:  Text(users.getUsers().elementAt(index).getAddress()),
            ),
            Container(
              padding: EdgeInsets.all(14),//hal moshkel nazdik boodan boaeder b neveshte
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.deepPurple,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child:  Text(users.getUsers().elementAt(index).getpassword()),
            ),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.deepPurple,
                ),
                borderRadius: BorderRadius.circular(14),
              ),

            )
          ],
        ),
      ),
    );
  }
}
