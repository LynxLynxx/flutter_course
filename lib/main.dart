import 'package:flutter/material.dart';
import 'package:flutter_course/pages/list_view_weather_page.dart';
import 'package:flutter_course/pages/widgets/snack_brar_widget.dart';
import 'package:flutter_course/repositories/weather_repository.dart';

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
      home: const ListViewWeatherPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String responseText = "";
  bool loading = false;
  final WeatherRepository weatherRepository = WeatherRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !loading ? Text(responseText) : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        setState(() {
          loading = true;
        });
        final res = await weatherRepository.getCurrentWeatherByName([
          "lublin",
          "lubelskie",
          "poland",
        ]);
        setState(() {
          loading = false;
        });
        res.fold((l) {
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(l.message));
        }, (r) {
          setState(() {
            responseText = r.toString();
          });
        });
      }),
    );
  }
}
