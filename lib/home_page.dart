import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  AssetImage blank = AssetImage("images/blank.png");
  AssetImage unlucky = AssetImage("images/sad.png");
  AssetImage lucky = AssetImage("images/money.png");

  List<String> itemarray;
  int luckynumber;
  int count = 0;
  String message = "";

  genraterandomnumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckynumber = random;
      print(luckynumber);
    });
  }

  @override
  void initState() {
    super.initState();
    itemarray = List<String>.generate(25, (index) => "empty");
    genraterandomnumber();
  }

  displayMessaage() {
    setState(() {
      message = "You have reached maximum no of trials";
      Delay();
    });
  }

  Delay() {
    Future.delayed(Duration(milliseconds: 1600), () {
      setState(() {
        this.resetgame();
        count = 0;
      });
    });
  }

  resetgame() {
    setState(() {
      itemarray = List<String>.filled(25, "empty");
      this.message = "";
      this.count = 0;
    });
    genraterandomnumber();
  }

  AssetImage getimage(int index) {
    String currentstate = itemarray[index];
    switch (currentstate) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return blank;
  }

  playgame(int index) {
    if (luckynumber == index) {
      setState(() {
        itemarray[index] = "lucky";
        audioCache.play('cash.wav');
        this.message = "Yay! you got it";
        Delay();
      });
    } else if (luckynumber != index && count <= 5) {
      setState(() {
        itemarray[index] = "unlucky";
        count++;
      });
    }
    if (count == 5) {
      audioCache.play("aww.mp3");
      displayMessaage();
    }
    if (count == 4) {
      this.message = "last one and you are gone";
    }
    if (count == 3) {
      this.message = "two more left";
    }
    if (count == 2) {
      this.message = "Yes you can win";
    }
    if (count == 1) {
      this.message = "There is a long way to go";
    }
  }

  showall() {
    setState(() {
      itemarray = List<String>.filled(25, "unlucky");
      itemarray[luckynumber] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              itemCount: 25,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 5,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, i) => SizedBox(
                height: 50,
                width: 50,
                child: RaisedButton(
                  padding: EdgeInsets.all(1),
                  onPressed: () {
                    playgame(i);
                  },
                  child: Image(
                    image: this.getimage(i),
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(100, 12, 100, 12),
                color: Colors.red[400],
                child: Text(this.message),
              )
            ],
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    color: Colors.black,
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      "Reset Game",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      this.resetgame();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    color: Colors.black,
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      "Show All",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      this.showall();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
