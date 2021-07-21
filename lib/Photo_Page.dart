import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';

class Photo_Page extends StatefulWidget {
  final Color cs;
  const Photo_Page({Key key, this.cs}) : super(key: key);

  @override
  _Photo_PageState createState() => _Photo_PageState();
}

class _Photo_PageState extends State<Photo_Page> {
  final GlobalKey<ScaffoldState> _x = GlobalKey<ScaffoldState>();
  File imageFile;
  final img = ImagePicker();
  _openGallery() async {
    final picture = await img.getImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else if ((picture == null && imageFile != null) ||
          (picture == null && imageFile == null)) {
        final sBar = SnackBar(
          content: Text('No Image selected.'),
        );
        // ignore: deprecated_member_use
        _x.currentState.showSnackBar(sBar);
      }
    });
  }

  _openCamera() async {
    final picture = await img.getImage(source: ImageSource.camera);
    setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else if ((picture == null && imageFile != null) ||
          (picture == null && imageFile == null)) {
        final sBar = SnackBar(
          content: Text('No Image selected.'),
        );
        // ignore: deprecated_member_use
        _x.currentState.showSnackBar(sBar);
      }
    });
  }

  _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.2))),
            backgroundColor: widget.cs,
            title: Text('Choose To Get Image'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Row(
                      children: [
                        Icon(Icons.photo_album),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          'Gallery',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      _openGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(
                    height: 40,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          'Camera',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      _openCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _x,
      backgroundColor: widget.cs,
      body: Center(
        child: Hero(
            tag: 'photo_page',
            child: imageFile == null
                ? Icon(
                    Icons.photo,
                    size: 50,
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(imageFile))),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () => _showChoiceDialog(context),
      ),
    );
  }
}
