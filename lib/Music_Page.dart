import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';

class Music_Page extends StatefulWidget {
  final Color cs;
  const Music_Page({Key key,this.cs}) : super(key: key);

  @override
    _Music_PageState createState() => _Music_PageState();
}

class _Music_PageState extends State<Music_Page> {
  var files;bool isPress = false;
  void getFiles() async { //asyn function to get list of files
    await Permission.storage.request();
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["mp3"] //optional, to filter files, list only mp3 files
    );
    setState(() {}); //update the UI
  }
  AudioPlayer _player = new AudioPlayer();
  List<bool> playing;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _player.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.cs,
      body: Center(
        child: Hero(tag:'music_page',
          child: files == null? (isPress==false?Icon(Icons.music_note,size: 50,):
          SpinKitFadingCircle(itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),
                color:Colors.black,
              ),
            );
          },)):
            ListView.builder(  //if file/folder list is grabbed, then show here
              itemCount: files?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                    child:ListTile(
                      title: Text(files[index].path.split('/').last),
                      trailing: playing[index] != false ? Icon(Icons.pause,size: 30,):Icon(Icons.play_arrow,size: 30,),
                      leading: Icon(Icons.audiotrack,size: 50,color: widget.cs),
                      onTap: () async{
                        await _player.play(files[index].path,isLocal: true);
                        if(playing[index] == false){
                          setState(() {
                            for(int i=0;i<playing.length;i++) playing[i] = false;
                            playing[index] = true;
                          });
                        }
                        else {
                          _player.pause();
                          setState(() {
                            playing[index] = false;
                          });
                        }
                      },
                    )
                );
              },
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: (){
          setState(() {
            isPress  = true;
          });
          getFiles();
          // ignore: deprecated_member_use
          playing = new List<bool>(1000);
          setState(() {
            for(int i=0;i<playing.length;i++) playing[i] = false;
          });
        }
      ),
    );
  }
}
