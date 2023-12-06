class ApiK {
  static const String baseUrl = "https://api.openweathermap.org";
  static const String apiVer = "/data/2.5";
  static const String apiKey = "af419f1a6e746f5bc05affe24232cfce";

  static String currentWeatherByName(List<String> names) {
    return "$baseUrl$apiVer/weather?appid=$apiKey&q=${names.join(",").toString()}";
  }
}