import 'package:flutter/material.dart';

class ListViewWeatherPage extends StatefulWidget {
  const ListViewWeatherPage({super.key});

  @override
  State<ListViewWeatherPage> createState() => _ListViewWeatherPageState();
}

class _ListViewWeatherPageState extends State<ListViewWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Lokalizacja",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
                onEditingComplete: () {},
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
