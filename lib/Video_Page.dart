import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Video_Page extends StatefulWidget {
  final Color cs;
  const Video_Page({Key key, this.cs}) : super(key: key);

  @override
  _Video_PageState createState() => _Video_PageState();
}

class _Video_PageState extends State<Video_Page> {
  BetterPlayerController _betterPlayerController;
  BetterPlayerDataSource betterPlayerDataSource;
  final GlobalKey<ScaffoldState>_x = GlobalKey<ScaffoldState>();
  File videoFile;
  final img = ImagePicker();
  _openGallery() async {
    final picture = await img.getVideo(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        if(videoFile!=null)_betterPlayerController.pause();
        videoFile = File(picture.path);
        betterPlayerDataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.file,videoFile.path);
        _betterPlayerController = BetterPlayerController(
            BetterPlayerConfiguration(),
            betterPlayerDataSource: betterPlayerDataSource);
      } else if((picture==null&&videoFile!=null)||(picture==null&&videoFile==null)){
        final sBar = SnackBar(content: Text('No Video selected.'),);
        // ignore: deprecated_member_use
        _x.currentState.showSnackBar(sBar);
      }
    });
  }

  _openCamera() async {
    final picture = await img.getVideo(source:ImageSource.camera);
    setState(() {
      if (picture != null) {
        if(videoFile!=null)_betterPlayerController.pause();
        videoFile = File(picture.path);
        betterPlayerDataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.file,videoFile.path);
        _betterPlayerController = BetterPlayerController(
            BetterPlayerConfiguration(),
            betterPlayerDataSource: betterPlayerDataSource);
      } else if((picture==null&&videoFile!=null)||(picture==null&&videoFile==null)){
        final sBar = SnackBar(content: Text('No Video selected.'),);
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
            title: Text('Choose To Get Video'),
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
    return Scaffold(key: _x,
      backgroundColor: widget.cs,
      body: Center(
        child: Hero(
            tag: 'video_page',
            child: videoFile != null
                ? BetterPlayer(controller: _betterPlayerController,)
                : Icon(
                    Icons.video_collection,
                    size: 50,
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () => _showChoiceDialog(context),
      ),
    );
  }
}
