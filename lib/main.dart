import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/egg_model.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.amber[100],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late String titleText;

  final EggModel soft = EggModel(hardnessTitle: "Na miękko", time: 3.0);
  final EggModel medium =
      EggModel(hardnessTitle: "No tak średnio bym powiedział", time: 6.0);
  final EggModel hard = EggModel(hardnessTitle: "Na twardo", time: 7.0);
  double progresBar = 0.0;
  double secondPass = 0.0;
  final AudioPlayer player=AudioPlayer();

  void selectEgg(EggSelection select) {
    secondPass=0.0;
    switch (select) {
      case EggSelection.soft:
        jajoAction(soft);
      case EggSelection.medium:
        jajoAction(medium);
      case EggSelection.hard:
        jajoAction(hard);
    }
  }

  @override
  void initState() {
    titleText = "Jakie Jajko Wariacie?";
    super.initState();
  }

  void jajoAction(EggModel eggModel) {
    setState(() {
      titleText = eggModel.hardnessTitle;

    });
    var startTime = eggModel.time;
    Timer.periodic(Duration(seconds: 1), (timer) {
      secondPass++;
      setState(() {
        progresBar=secondPass/startTime;
      });
      startTime--;
      if (startTime == 0) {
        timer.cancel();
        setState(() {
          titleText="Wyciągaj jajka!!";

        });
        player.play(AssetSource("alarm_sound.mp3"));
      }
      print(timer.tick);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(titleText,
              style: GoogleFonts.notoSansPahawhHmong(
                  fontSize: 24, fontWeight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              Jajo(
                  "assets/soft_egg@3x.png", () => selectEgg(EggSelection.soft)),
              Jajo("assets/medium_egg@3x.png",
                  () => selectEgg(EggSelection.medium)),
              Jajo(
                  "assets/hard_egg@3x.png", () => selectEgg(EggSelection.hard)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: LinearProgressIndicator(
              value: progresBar,
            ),
          ),
        ],
      ),
    ));
  }
}

class Jajo extends StatelessWidget {
  const Jajo(
    this.asset,
    this.onTap, {
    super.key,
  });
  final String asset;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap,
            child: Image.asset(
              asset,
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
