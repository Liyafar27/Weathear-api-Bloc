class WeatherData {
  final String name;
  final String main;
  final double temp;
  final double maxTemp;
  final double minTemp;
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
  double get getMaxTemp => maxTemp - 272.5;
  double get getMinTemp => minTemp - 272.5;
  int get getPressure => (pressure * 760 / 10132.5).toInt();


  WeatherData({
    required this.date,
    required this.name,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.feelsLikeTemp,
    required this.main,
    required this.icon,
    required this.description,
    required this.windSpeed,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.humidity,
    required this.pressure,

  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000 + json['timezone'] * 1000 , isUtc: true),
      sunriseTime: DateTime.fromMillisecondsSinceEpoch(
          (json['sys']['sunrise']) * 1000 + json['timezone'] * 1000 , isUtc: true),
      sunsetTime: DateTime.fromMillisecondsSinceEpoch(
          (json['sys']['sunset']) * 1000+ json['timezone'] * 1000 , isUtc: true),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      minTemp: json['main']['temp_min'].toDouble(),
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
