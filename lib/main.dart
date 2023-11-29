import 'dart:math';

import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MagicBall(),
    );
  }
}

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State<MagicBall> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  final List<int> magicBall = List.generate(6, (index) => index + 1);
  List<String> ballAssets = [];
  String ball = "assets/ball1.png";
  final Random rand = Random();

  @override
  void initState() {
    createBallAssets();
    getRandomNumbers();
    super.initState();
  }

  void createBallAssets() {
    for (var ball in magicBall) {
      ballAssets.add("assets/ball$ball.png");
    }
  }

  void getRandomNumbers() {
    int randBall = rand.nextInt(5);
    setState(() {
      ball = ballAssets[randBall];
      print(ball);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 139, 255),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Ask me antything...",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Image.asset(
              ball,
              width: MediaQuery.of(context).size.width * .8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 38),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              onPressed: () => getRandomNumbers(),
              child: const Text(
                "Button",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
