import 'package:bloc_weather_api/bloc/search_weather_bloc.dart';
import 'package:bloc_weather_api/utils/string.dart';
import 'package:bloc_weather_api/widgets/shimmer_weather.dart';
import 'package:bloc_weather_api/model/weather_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'widgets/first_request_weather.dart';
import 'widgets/info_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = SearchWeatherBloc(WeatherRepo())..add(SearchWeatherInitialEvent());
    return ScreenUtilInit(
      designSize: const Size(375, 800),
      allowFontScaling: false,
      builder: () => MaterialApp(
        title: titleApp,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white70,
              fontSize: 60.sp,
            ),
            headline2: TextStyle(
              color: Colors.white70,
              fontSize: 34.sp,
            ),
            headline3: TextStyle(
              color: Colors.white70,
              fontSize: 24.sp,
            ),
            headline4: TextStyle(
              color: Colors.white70,
              fontSize: 18.sp,
            ),
            headline5: TextStyle(
              color: Colors.white70,
              fontSize: 16.sp,
            ),
            headline6: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
              subtitle1: TextStyle(
                color:  Colors.grey[900],
                fontSize: 16.sp,
                fontWeight: FontWeight.w600
              ),
          ),
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[900],
          body: BlocProvider<SearchWeatherBloc>(
            create: (context) => bloc,
            child: _SearchPage(),
          ),
        ),
      ),
    );
  }
}

class _SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = (BlocProvider.of<SearchWeatherBloc>(context));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<SearchWeatherBloc, SearchWeatherState>(
            builder: (context, state) {
          if (state is SearchWeatherEmptyState) {
            return FirstRequestWeather(weatherBloc);
          } else if (state is SearchWeatherIsLoading) {
            return ShimmerWeather();
          } else if (state is SearchWeatherIsLoadedState) {
            return InfoWeather(state.weather, weatherBloc);
          } else if (state is UnknownCityExceptionState) {
            return _ErrorScreen(weatherBloc, unknowCityException);
          } else if (state is NoConnectionExceptionState) {
            return _ErrorScreen(weatherBloc, noConnectionException);
          } else {
            return const Text(
              unknowException,
              style: TextStyle(color: Colors.white),
            );
          }
        }),
      ],
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final SearchWeatherBloc weatherBloc;
  final String errorMessage;

  const _ErrorScreen(this.weatherBloc, this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 100),
            child: Text(errorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3)),
        FirstRequestWeather(weatherBloc),
      ],
    );
  }
}
