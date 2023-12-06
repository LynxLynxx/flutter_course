import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final num temperature;
  final int pressure;
  final int humidity;
  final num lon;
  final num lat;
  final int weatherId;

  const WeatherModel(
      {required this.cityName,
      required this.main,
      required this.description,
      required this.iconCode,
      required this.temperature,
      required this.pressure,
      required this.humidity,
      required this.lon,
      required this.lat,
      required this.weatherId});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      cityName: json["name"],
      main: json["weather"][0]["main"],
      description: json["weather"][0]["description"],
      iconCode: json["weather"][0]["icon"],
      temperature: json["main"]["temp"],
      pressure: json["main"]["pressure"],
      humidity: json["main"]["humidity"],
      lon: json["coord"]["lon"],
      lat: json["coord"]["lat"],
      weatherId: json["weather"][0]["id"]);

  Map<String, dynamic> toJson() => {
        "cityName": cityName,
        "main": main,
        "description": description,
        "iconCode": iconCode,
        "temperature": temperature,
        "pressure": pressure,
        "humidity": humidity,
        "lon": lon,
        "lat": lat,
        "weatherId": weatherId,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [
        cityName,
        main,
        description,
        iconCode,
        temperature,
        pressure,
        humidity,
        lon,
        lat,
        weatherId
      ];
}
