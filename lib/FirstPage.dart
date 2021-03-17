import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scratch_and_win/home_page.dart';
import 'package:flutter_scratch_and_win/rules_page.dart';
import 'package:transparent_image/transparent_image.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  static AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(fixedPlayer: advancedPlayer);

  @override
  void initState() {
    super.initState();
    audioCache.play('2.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch And Win"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 256,
              width: 256,
              child: Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Center(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          "https://lotto.bclc.com/content/bclc/en/lotto/scratch-and-win/set-for-life/_jcr_content/sw-logo/image.img.png/1500572552242.png",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 94,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text("Play Game"),
                  color: Colors.red[400],
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  onPressed: () {
                    setState(() {
                      advancedPlayer.pause();
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text("Rules"),
                  color: Colors.red[400],
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  onPressed: () {
                    setState(() {
                      advancedPlayer.stop();
                      //TODO add dice.wav
                      audioCache.play("dice.wav");
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RulesPage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
