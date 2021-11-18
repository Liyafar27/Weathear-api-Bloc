import 'package:bloc_weather_api/bloc/search_weather_bloc.dart';
import 'package:bloc_weather_api/model/weather_model.dart';
import 'package:bloc_weather_api/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/size_extension.dart';

class InfoWeather extends StatelessWidget {
  WeatherData weather;
  SearchWeatherBloc weatherBloc;

  InfoWeather(this.weather, this.weatherBloc);

  @override
  Widget build(BuildContext context) {
    var weatherController = TextEditingController();

    return Container(
      padding: const EdgeInsets.only(right: 32, left: 32),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 70.h,
          ),
          GestureDetector(
            onTap: () {
              weatherBloc.add(FetchSearchWeatherEvent(weather.name));
            },
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline2,
                children: [
                  TextSpan(text: weather.name),
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 5),
                      child:
                          Icon(Icons.replay, color: Colors.white70, size: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            DateFormat('kk:mm   dd.MM.yyyy').format(weather.date),
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 30.h,
          ),
          Center(
              child: SizedBox(
            child: Image.network(
              'https://openweathermap.org/img/w/${weather.icon}.png',
              scale: 0.3,
            ),
            height: 50.h,
            width: 50.w,
          )),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(weather.getMaxTemp.round().toString() + celsius,
                      style: Theme.of(context).textTheme.headline4),
                  Text(maxTemp,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              Column(
                children: [
                  Text(weather.getTemp.round().toString() + celsius,
                      style: Theme.of(context).textTheme.headline1),
                  Text(
                      weather.description +
                          feelsLike +
                          weather.getTemp.round().toString() +
                          celsius,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5),
                ],
              ),
              Column(
                children: [
                  Text(weather.getMinTemp.round().toString() + celsius,
                      style: Theme.of(context).textTheme.headline4),
                  Text(minTemp,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 45.h,
          ),
          _InfoGrid(weather),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
            child: TextFormField(
              controller: weatherController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Colors.white70, style: BorderStyle.solid)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid)),
                hintText: fieldCity,
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                weatherController.text.isNotEmpty
                    ? weatherBloc
                        .add(FetchSearchWeatherEvent(weatherController.text))
                    : showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(forgotCity,
                              style: Theme.of(context).textTheme.subtitle1),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(okDialog,
                                  style: Theme.of(context).textTheme.subtitle1),
                            )
                          ],
                        ),
                      );
              },
              child: Text(sendRequestWeather,
                  style: Theme.of(context).textTheme.headline5),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final WeatherData weather;

  _InfoGrid(this.weather);

  @override
  Widget build(BuildContext context) {
    const speedWindAsset = 'assets/ic_wind.svg';
    const humidityAsset = 'assets/ic_humidity.svg';
    const pressureAsset = 'assets/ic_barometer.svg';
    const sunriseAsset = 'assets/ic_sunrise.svg';
    const sunsetAsset = 'assets/ic_sunset.svg';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  speedWindAsset,
                  color: Colors.white70,
                  height: 35.h,
                  width: 50.w,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(weather.windSpeed.toString() + kmHours,
                    style: Theme.of(context).textTheme.headline4),
                Text(windSpeed,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
            SizedBox(
              width: 30.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  humidityAsset,
                  color: Colors.white70,
                  height: 35.h,
                  width: 50.w,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(weather.humidity.toString() + percent,
                    style: Theme.of(context).textTheme.headline4),
                Text(humidity, style: Theme.of(context).textTheme.headline6),
              ],
            ),
            SizedBox(
              width: 30.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  pressureAsset,
                  color: Colors.white70,
                  height: 35.h,
                  width: 50.w,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(weather.getPressure.toString() + pres,
                    // weather.pressure.toString(),
                    style: Theme.of(context).textTheme.headline4),
                Text(pressure, style: Theme.of(context).textTheme.headline6),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  sunriseAsset,
                  color: Colors.white70,
                  height: 35.h,
                  width: 50.w,
                ),
                Text(DateFormat('kk:mm').format(weather.sunriseTime),
                    style: Theme.of(context).textTheme.headline3),
                Text(sunrise, style: Theme.of(context).textTheme.headline6),
              ],
            ),
            SizedBox(
              width: 30.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  sunsetAsset,
                  color: Colors.white70,
                  height: 35.h,
                  width: 50.w,
                ),
                Text(DateFormat('kk:mm').format(weather.sunsetTime),
                    style: Theme.of(context).textTheme.headline3),
                Text(sunset, style: Theme.of(context).textTheme.headline6),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
