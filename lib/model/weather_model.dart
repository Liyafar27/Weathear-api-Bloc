class WeatherData {
  final String name;
  final String main;
  final double temp;
  final double feelsLikeTemp;
  final double windSpeed;
  final String icon;
  final String description;
  final int humidity;
  final int pressure;
  final DateTime date;
  final DateTime sunriseTime;
  final DateTime sunsetTime;

  double get getTemp => temp - 272.5;
  double get getFeelsLikeTemp => feelsLikeTemp - 272.5;


  WeatherData({
    required this.date,
    required this.name,
    required this.temp,
    required this.main,
    required this.icon,
    required this.description,
    required this.feelsLikeTemp,
    required this.windSpeed,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.humidity,
    required this.pressure,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      sunriseTime: DateTime.fromMillisecondsSinceEpoch(
          (json['sys']['sunrise']) * 1000,
          isUtc: false),
      sunsetTime: DateTime.fromMillisecondsSinceEpoch(
          (json['sys']['sunset']) * 1000,
          isUtc: false),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      feelsLikeTemp: json['main']['feels_like'].toDouble(),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: json['wind']['speed'],
    );
  }
}
