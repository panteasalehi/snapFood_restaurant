import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:snap/menu.dart';
import 'package:snap/users.dart';
class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  final controller = MapController(
    location: LatLng(35.68, 51.41),
  );

  void _gotoDefault() {
    controller.center = LatLng(35.68, 51.41);
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
  }

  Offset _dragStart;
  double _scaleStart = 1.0;

  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    //controller.tileSize = 256 / devicePixelRatio;
    int index = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Demo'),
      ),
      body: GestureDetector(
        onDoubleTap: _onDoubleTap,
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: (details) {
          print(
              "Location: ${controller.center.latitude}, ${controller.center
                  .longitude}");
        },
        child: Stack(
          children: [
            Map(
              controller: controller,
              builder: (context, x, y, z) {
                final url =
                    'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                return CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                );
              },
            ),
            Center(
              child: Icon(Icons.close, color: Colors.red),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

         users.getUsers().elementAt(index).longitude = controller.center.longitude;
          users.getUsers().elementAt(index).latitude = controller.center.latitude;
          String str = "the String is"+users.getUsers().elementAt(index).longitude.toString()+
              "the String is"+users.getUsers().elementAt(index).latitude.toString();
          showAlertDialog(context , str , index);

          //here the address of the user is added
        },
        tooltip: 'add location',
        child: Icon(Icons.check_circle_outline_sharp),
      ),
    );
  }
}
void Send(String str) async{
  await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
    print('connected');
    String location = "the String is:R:adding location";
    location+=str;
    serverSocket.writeln(location);
  });
}
showAlertDialog(BuildContext context , String str , int index) {

  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {

      String str2 = "the String is"+users.getUsers().elementAt(index).distance+"the String is"+
          users.getUsers().elementAt(index).phoneNumber+"the String is"+ users.getUsers().elementAt(index).password;
      str += str2;
      Send(str);
      Navigator.push(context, new MaterialPageRoute(builder: (context) => menu()));
    },

  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("محدوده سفارش را انتخاب کنید"),
    content: TextFormField(
      onChanged: (String value){
        users.getUsers().elementAt(index).distance = value;
      },
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}