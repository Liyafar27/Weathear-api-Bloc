part of 'search_weather_bloc.dart';

@immutable
abstract class SearchWeatherEvent {}
class SearchWeatherInitialEvent extends SearchWeatherEvent {}


class FetchSearchWeatherEvent extends SearchWeatherEvent {
  final String city;

  FetchSearchWeatherEvent(this.city);
}

class ResetWeather extends SearchWeatherEvent {}
