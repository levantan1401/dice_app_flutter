import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Application',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dice App"),
          backgroundColor: Colors.blue,
        ),
        body: DiceApp(),
      ),
    );
  }
}

class DiceApp extends StatefulWidget {
  const DiceApp({super.key});

  @override
  State<DiceApp> createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  Random random = Random();
  int currentIndex = 0;
  int currentIndex1 = 1;
  int currentIndex2 = 2;
  int counter = 1;
  int sum = 0;
  String ketqua = "";
  List<String> diceImg = [
    'assets/images/dice_1.png',
    'assets/images/dice_2.png',
    'assets/images/dice_3.png',
    'assets/images/dice_4.png',
    'assets/images/dice_5.png',
    'assets/images/dice_6.png',
  ];

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$sum là $ketqua",
          style: TextStyle(fontSize: 60),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              diceImg[currentIndex],
              height: 100,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              diceImg[currentIndex1],
              height: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Image.asset(
              diceImg[currentIndex2],
              height: 100,
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(200, 40), //////// HERE
            ),
            onPressed: () async {
              // Play audio

              await audioPlayer.setAsset("assets/audio/rolling-dice.mp3");
              audioPlayer.play();

              // Roll Dice
              Timer.periodic(const Duration(milliseconds: 80), (timer) {
                counter++;
                setState(() {
                  currentIndex = random.nextInt(6);
                  currentIndex1 = random.nextInt(6);
                  currentIndex2 = random.nextInt(6);
                });

                if (counter >= 13) {
                  timer.cancel();
                  sum = currentIndex1 + currentIndex2 + currentIndex + 3;
                  if (sum >= 11) {
                    ketqua = "TÀI";
                  } else {
                    ketqua = "XỈU";
                  }
                  setState(() {
                    counter = 1;
                  });
                }
              });
            },
            child: const Text(
              "Roll",
              style: TextStyle(fontSize: 25),
            ))
      ],
    ));
  }
}
