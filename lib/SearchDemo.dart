import 'package:flutter/material.dart';
import 'package:snap/foodS.dart';
import 'package:snap/myfood.dart';



class MyHomePage1 extends StatefulWidget {
  MyHomePage1({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePage1State createState() => new _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  TextEditingController editingController = TextEditingController();
//making the list first element is the length of the list and the second is the function we use for searching
  //here searching is based on the names so "getname" is used
  final duplicateItems = List<String>.generate(foodS.getFoods().length, (i) => foodS.getFoods().elementAt(i).getname() );
  var items = List<String>();//a new list above list will be added to it
  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    print('filterresult');
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        //here is where the search filter happens it cheak and add only items that contains query
        //for example if the query be  h, only items which have h would be added
        //later in setstate this change will be shown
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
     //   title: new Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                //here is where you type what you want and it would be filtered
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}