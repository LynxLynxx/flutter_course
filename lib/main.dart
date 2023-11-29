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
      title: 'Flutter',
      theme: ThemeData(
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
  final List<int> ballNumber = List.generate(5, (index) => index + 1);
   List<String> ballLista = [];
final Random rand=Random();
 String ball="assets/ball1.png";

 @override
  void initState() {
    utworzListePilek();
    getRandomN();
    super.initState();
  }
void getRandomN(){
  int numerek=rand.nextInt(5);
  print(numerek);
  print(ballLista.toString());
  setState(() {
    ball = ballLista[numerek];
  });
}

void utworzListePilek(){
  for (var ball in ballNumber){
    ballLista.add("assets/ball$ball.png");
  
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Ask My Anything...',textAlign: TextAlign.center,  
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 40) ),
                Image.asset(
                  ball,
                  width: 300,
                  height: 300,
                ),
                ElevatedButton( style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 38)
          ,
                ),
                onPressed: (){getRandomN();},
                  child: const Text("Przycisk"),)
 


              ]),
        ));
  }
}
