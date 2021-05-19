
import 'package:flutter/material.dart';
import 'package:snap/clientList.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
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
                  label: Text('food code'),
                ),
              ],
              rows:  clientList.getcodes().map((e) => DataRow(cells: <DataCell>[DataCell(Text(' $e'))])).toList()
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
                  label: Text('food date'),
                ),
              ],
              rows:  clientList.getDate().map((e) => DataRow(cells: <DataCell>[DataCell(Text(' $e'))])).toList()
          ),
          DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('food price'),
                ),
              ],
              rows:  clientList.getCost().map((e) => DataRow(cells: <DataCell>[DataCell(Text(' $e'))])).toList()
          ),
          DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('food is ready?'),
                ),
              ],
              rows:  clientList.getState().map((e) => DataRow(cells: <DataCell>[DataCell(Text(' $e'))])).toList()
          ),
        ],
      ),
    );
  }
}