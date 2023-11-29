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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  final List<int> ballNumber = List.generate(5, (index) => index + 1);
  List<String> ballAssets = [];
  String ball1 = "assets/ball1.png";
  final Random rand = Random();

  @override
  void initState() {
    createBallAsset();
    getRandomNumber();
    super.initState();
  }

  void createBallAsset() {
    for (var ball in ballNumber) {
      print(ball);
      ballAssets.add("assets/ball$ball.png");
    }
  }

  void getRandomNumber() {
    int rand1 = rand.nextInt(5);

    setState(() {
      ball1 = ballAssets[rand1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[400],
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Ask Me Anything...",
                textAlign: TextAlign.center ,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              Image.asset(
                ball1,
                width: MediaQuery.of(context).size.width * .8,
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                  textStyle: TextStyle(fontSize: 38),
                  shape: RoundedRectangleBorder()
                ),
                onPressed: () => getRandomNumber(),
                child: const Text(
                  "Shake It"
                ),
              )
            ],
        
        ),
      ),
    );
  }
}