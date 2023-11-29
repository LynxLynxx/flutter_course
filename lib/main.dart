import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MagicBallApp());

class MagicBallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8 Ball',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MagicBallPage(),
    );
  }
}

class MagicBallPage extends StatefulWidget {
  @override
  _MagicBallPageState createState() => _MagicBallPageState();
}

class _MagicBallPageState extends State<MagicBallPage> {
  int ballNumber = 1;

  void shakeBall() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.purple, 
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Text(
                'Ask Me Anything...',
                style: TextStyle(fontSize: 50.0, color: Colors.white),
                
              ),
            ),
          ),
          Container(
            color: Colors.purple, 
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
                child: Image.asset('assets/ball$ballNumber.png'),
            ),
          ),
          Container(
            color: Colors.purple, 
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: ElevatedButton(
                onPressed: shakeBall,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'button'.toUpperCase(),
                    style: TextStyle(fontSize: 20.0), 
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
