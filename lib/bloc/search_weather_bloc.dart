import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_weather_api/model/weather_model.dart';
import 'package:bloc_weather_api/model/weather_repo.dart';
import 'package:meta/meta.dart';
import 'package:location/location.dart';

part 'search_weather_event.dart';

part 'search_weather_state.dart';

class SearchWeatherBloc extends Bloc<SearchWeatherEvent, SearchWeatherState> {
  final WeatherRepo _weatherRepo;

  SearchWeatherBloc(this._weatherRepo) : super(SearchWeatherEmptyState());
  LocationData? locationData;
  double? latitude;
  double? longitude;

  @override
  Stream<SearchWeatherState> mapEventToState(
    SearchWeatherEvent event,
  ) async* {
    if (event is SearchWeatherInitialEvent) {
      Location location = Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          yield SearchWeatherEmptyState();
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          yield SearchWeatherEmptyState();
        }
      }
      locationData = await location.getLocation();
      latitude = locationData!.latitude;
      longitude = locationData!.longitude;
      log(locationData!.longitude.toString());
      yield SearchWeatherIsLoading();
      try {
        final response =
            await _weatherRepo.geLocationWeather(latitude!, longitude!);
        yield SearchWeatherIsLoadedState(weather: response);
      } catch (error) {
        if (error is SocketException) {
          yield NoConnectionExceptionState();
        } else {
          yield UnknownCityExceptionState();
        }
      }
    }
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
      log("SearchWeatherEmptyState");
    }
  }
}
