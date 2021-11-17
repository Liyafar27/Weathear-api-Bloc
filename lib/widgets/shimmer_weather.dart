import 'package:bloc_weather_api/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final speedWindAsset = 'assets/ic_wind.svg';
    final humidityAsset = 'assets/ic_humidity.svg';
    final pressureAsset = 'assets/ic_barometer.svg';
    final sunriseAsset = 'assets/ic_sunrise.svg';
    final sunsetAsset = 'assets/ic_sunset.svg';

    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        padding: EdgeInsets.only(right: 40, left: 40),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70.h,
            ),
            Container(
              color: Theme.of(context).disabledColor,
              width: 200.w,
              height: 50.h,
            ),
            SizedBox(
              height: 10.h,
            ),

                Container(
                  color: Theme.of(context).disabledColor,
                  width: 200.w,
                  height: 35.h,
                ),

            SizedBox(
              height: 80.h,
            ),
        Row(            mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Container(
              color: Theme.of(context).disabledColor,
              width: 50.w,
              height: 50.h,
            ),SizedBox(
      width: 20.w,
    ),Container(
              color: Theme.of(context).disabledColor,
              width: 90.w,
              height: 65.h,
            ),SizedBox(
              width: 20.w,
            ),Container(
              color: Theme.of(context).disabledColor,
              width: 50.w,
              height: 50.h,
            ),
          ],
        ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              color: Theme.of(context).disabledColor,
              width: 120.w,
              height: 40.h,
            ),
            SizedBox(
              height: 35.h,
            ),
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
                    Container(
                      color: Theme.of(context).disabledColor,
                      width: 70.w,
                      height: 25.h,
                    ),
                    Text(windSpeed,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
                SizedBox(
                  width: 40.w,
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
                    Container(
                      color: Theme.of(context).disabledColor,
                      width: 70.w,
                      height: 25.h,
                    ),
                    Text(humidity,
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
                SizedBox(
                  width: 40.w,
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
                      width: 30.w,
                    ),
                    Container(
                      color: Theme.of(context).disabledColor,
                      width: 70.w,
                      height: 25.h,
                    ),
                    Text(pressure,
                        style: Theme.of(context).textTheme.headline6),
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
                    Container(
                      color: Theme.of(context).disabledColor,
                      width: 55.w,
                      height: 25.h,
                    ),
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
                    Container(
                      color: Theme.of(context).disabledColor,
                      width: 55.w,
                      height: 25.h,
                    ),
                    Text(
                      sunset,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 28.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(18),
              ),
              width: 260.w,
              height: 55.h,
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              color: Theme.of(context).disabledColor,
              width: 100.w,
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
