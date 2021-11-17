import 'package:bloc_weather_api/utils/string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather_model.dart';

class WeatherRepo {
  Future<WeatherData> getWeather(String city) async {
    print(await http.read(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$appId&lang=ru')));
    final response = await http.Client().get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$appId&lang=ru"));
    if (response.statusCode != 200) {
      throw Exception();
    }
    return WeatherData.fromJson(jsonDecode(response.body));
  }
}
