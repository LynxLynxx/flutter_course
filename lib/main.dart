// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/egg_model.dart';
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.amber,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String titleText;
  Map jajaCzas = {
    "hard": 7.0,
    "medium": 4.0,
    "soft": 3.0,
  };

  Map jajaTitle = {
    "hard": "Na miękko",
    "medium": "Na średnio",
    "soft": "Na twardo",
  };

  final EggModel soft = EggModel(hardnessTitle: "Na miękko", time: 3.0);
  final EggModel medium = EggModel(hardnessTitle: "Na średnio", time: 4.0);
  final EggModel hard = EggModel(hardnessTitle: "Na twardo", time: 7.0);
  double progressBar = 0.0;
  double secondPass = 0;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    titleText = "Jaki rodzaj jajka preferujesz?";
    super.initState();
  }

  void selectEgg(EggSelection select) {
    setState(() {
      secondPass = 0.0;
      progressBar = 0.0;
    });

    switch (select) {
      case EggSelection.soft:
        jajoAction(soft);
      case EggSelection.medium:
        jajoAction(medium);
      case EggSelection.hard:
        jajoAction(hard);
    }
  }

  void jajoAction(EggModel eggModel) {
    setState(() {
      titleText = eggModel.hardnessTitle;
    });
    var startTime = eggModel.time;
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(startTime);
      secondPass++;
      setState(() {
        progressBar = secondPass / startTime;
      });

      //startTime--;
      if (secondPass > eggModel.time) {
        timer.cancel();
        setState(() {
          titleText = "Ugotowane!";
          player.play(AssetSource("alarm_sound.mp3"));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            titleText,
            style: GoogleFonts.dancingScript(
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Jajo("assets/soft_egg@3x.png",
                    () => selectEgg(EggSelection.soft)),
                Jajo("assets/medium_egg@3x.png",
                    () => selectEgg(EggSelection.medium)),
                Jajo("assets/hard_egg@3x.png",
                    () => selectEgg(EggSelection.hard)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
            child: LinearProgressIndicator(
              value: progressBar,
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
    Key? key,
  }) : super(key: key);
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
      ),
    );
  }
}
