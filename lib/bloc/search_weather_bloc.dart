import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_weather_api/model/weather_model.dart';
import 'package:bloc_weather_api/model/weather_repo.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'search_weather_event.dart';

part 'search_weather_state.dart';

class SearchWeatherBloc extends Bloc<SearchWeatherEvent, SearchWeatherState> {
  final WeatherRepo _weatherRepo;

  SearchWeatherBloc(this._weatherRepo) : super(SearchWeatherEmptyState());

  @override
  Stream<SearchWeatherState> mapEventToState(
    SearchWeatherEvent event,) async* {
    if (event is FetchSearchWeatherEvent) {
      yield SearchWeatherIsLoading();
      try {
        final response = await _weatherRepo.getWeather(event.city);
        yield SearchWeatherIsLoadedState(weather: response);
      } catch (error) {
        if (error is SocketException) {
          yield NoConnectionExceptionState();
        } else {
          yield UnknownCityExceptionState();
        }
      }
    }
    if (event is ResetWeather) {
      yield SearchWeatherEmptyState();
    }
  }
}
