import 'package:flutter/material.dart';
class addPhoto extends StatefulWidget {
  Function getImage;
  int num;
  addPhoto(this.getImage,this.num);

  @override
  _addPhotoState createState() => _addPhotoState();
}

class _addPhotoState extends State<addPhoto> {
  @override


    @override
    Widget build(BuildContext context) {

      return Container(

        child: FloatingActionButton(
          onPressed: (){
            widget.getImage(widget.num);
            Navigator.pop(context);
          },
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
      );
    }
  }
