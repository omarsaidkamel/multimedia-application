import 'dart:math';
import 'package:flutter/material.dart';
import 'package:multimedia/Music_Page.dart';
import 'package:multimedia/Photo_Page.dart';
import 'package:multimedia/Video_Page.dart';

class Makeyourchoice extends StatefulWidget {
  const Makeyourchoice({Key key}) : super(key: key);

  @override
  _MakeyourchoiceState createState() => _MakeyourchoiceState();
}

class _MakeyourchoiceState extends State<Makeyourchoice> {
  Random rand = new Random();
  int x=0;
  List<Color> cx1 =[Colors.pinkAccent,Colors.pink,Colors.yellowAccent,Colors.yellow,];
  List<Color> cx2 =[Colors.red,Colors.redAccent,Colors.amber,Colors.indigoAccent];
  List<Color> cx3 =[Colors.cyan,Colors.indigo,Colors.blue,Colors.orangeAccent];
  List<Color> cx4 =[Colors.purple,Colors.purpleAccent,Colors.green[300],Colors.lightGreen];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: MediaQuery.of(context).size.width/2,
                height:MediaQuery.of(context).size.height/2,
                color: cx1[x],
                alignment: Alignment.center,
                child: Builder(builder:(ctx)=>TextButton(child:Hero(tag:'photo_page',child: Icon(Icons.photo,size: 70,color: Colors.black,),) ,onPressed: () {
                  Navigator.push(ctx,MaterialPageRoute(builder: (_)=> Photo_Page(cs: cx1[x],)),);
                }),),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: MediaQuery.of(context).size.width/2,
                height:MediaQuery.of(context).size.height/2,
                color: cx2[x],
                alignment: Alignment.center,
                child:Builder(builder:(ctx)=>TextButton(child:Hero(tag:'video_page',child: Icon(Icons.video_collection,size: 70,color: Colors.black,),) ,onPressed: () {
                    Navigator.push(ctx,MaterialPageRoute(builder: (_)=> Video_Page(cs: cx2[x],)),);
                  }),),
              ),
            ],
          ),
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: MediaQuery.of(context).size.width/2,
                height:MediaQuery.of(context).size.height/2,
                color: cx3[x],
                alignment: Alignment.center,
                child:Builder(builder:(ctx)=>TextButton(child:Hero(tag:'music_page',child: Icon(Icons.music_note,size: 70,color: Colors.black,),) ,onPressed: () {
                  Navigator.push(ctx,MaterialPageRoute(builder: (_)=> Music_Page(cs:cx3[x])),);
                }),),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: MediaQuery.of(context).size.width/2,
                height:MediaQuery.of(context).size.height/2,
                color: cx4[x],
                alignment: Alignment.center,
                child: IconButton(iconSize:70,icon: Icon(Icons.color_lens), onPressed: () {
                  setState(() {
                    x = rand.nextInt(4);
                  });
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
