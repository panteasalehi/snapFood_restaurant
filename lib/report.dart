
import 'dart:io';
import 'package:snap/customer.dart';
import 'package:snap/users.dart';
import 'package:flutter/material.dart';
import 'package:snap/clientList.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.greenAccent,
            ),
            onPressed: () {
              getHistory(index);
            },


          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //showing them in a row caused bug so they have been shown in two row
              //should be corrected
              Row(
                children: [
                  DataTable(//several datatable is used in order to have several column and rows
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('food name'),
                        ),
                      ],
                      rows:  clientList.getfoodnames().map((e) => DataRow(cells: <DataCell>[DataCell(Text(' $e'))])).toList()//going throw the list
                  ),
                  DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('persons name'),
                        ),
                      ],
                      rows:  clientList.getpersons().map((e) => DataRow(cells: <DataCell>[DataCell(Text(' $e'))])).toList()
                  ),
                  DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('food price'),
                        ),
                      ],
                      rows:  clientList.getCost().map((e) => DataRow(cells: <DataCell>[DataCell(Text(' $e'))])).toList()
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void getHistory(int n) async{
  await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
    print('connected');
    String code = "the String is R:get history"+"the String is"+users.getUsers().elementAt(n).phoneNumber+"the String is "+users.getUsers().elementAt(n).password;
    serverSocket.writeln(code);

    serverSocket.listen((socket) {
      String s = new String.fromCharCodes(socket).trim();
      List list = s.split("\n");
      for(int i = 0 ; i < list.length ; i += 3)
        clientList.addCustomer(Customer(list.elementAt(i),list.elementAt(i+1),list.elementAt(i+2)));
    });

  });
}