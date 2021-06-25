import 'dart:io';
import 'package:snap/users.dart';
import 'package:flutter/material.dart';
class Code extends StatefulWidget {
  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context).settings.arguments as int;
    String newCode;
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText:" enter code",
                ),
                onChanged: (String value) {
                   newCode= value;
                },
              ),

            ElevatedButton(
              child: Text("add code!"),
              onPressed: (){

                  String  str = "the String is"+newCode + "the String is"+users.getUsers().elementAt(index).phoneNumber + "the String is"+users.getUsers().elementAt(index).password;
                  Send(str);
                Navigator.pop(context);
              },
            ),
          ],

        ),
      ),
    );
  }
}
void Send(String str) async{
  await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
    print('connected');
    String code = "the String isR:add code";
    code+=str;
    serverSocket.writeln(code);
  });
}