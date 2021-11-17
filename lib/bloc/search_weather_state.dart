part of 'search_weather_bloc.dart';

@immutable
abstract class SearchWeatherState {}


class SearchWeatherEmptyState extends SearchWeatherState {}

class SearchWeatherIsLoading extends SearchWeatherState{}

class SearchWeatherIsLoadedState extends SearchWeatherState{
  final WeatherData weather;

  SearchWeatherIsLoadedState({required this.weather});
 }

class NoConnectionExceptionState extends SearchWeatherState{
}

class UnknownCityExceptionState extends SearchWeatherState{
}