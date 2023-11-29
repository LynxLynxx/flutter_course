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
        appBarTheme: AppBarTheme(
          color: Colors.indigo,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
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
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(
          'Ask Me Anything...',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 0),
          TextButton(
            onPressed: shakeBall,
            child: Image.asset('assets/ball$ballNumber.png'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.indigo,
            ),
            onPressed: shakeBall,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Shake It',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
