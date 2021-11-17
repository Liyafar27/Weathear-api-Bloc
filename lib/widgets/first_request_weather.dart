import 'package:bloc_weather_api/bloc/search_weather_bloc.dart';
import 'package:bloc_weather_api/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_svg/svg.dart';

class FirstRequestWeather extends StatelessWidget {
  SearchWeatherBloc weatherBloc;

  FirstRequestWeather(this.weatherBloc);

  @override
  Widget build(BuildContext context) {
    final smartphoneAsset = 'assets/ic_smartphone.svg';
    var cityController = TextEditingController();
    return Container(
      padding: EdgeInsets.only(top: 100),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            smartphoneAsset,
            color: Colors.white70,
            height: 140.h,
            width: 100.w,
          ),
          SizedBox(
            height: 14.h,
          ),
          Text(requestTitle, style: Theme.of(context).textTheme.headline2),
          Container(
            padding: EdgeInsets.only(right: 30, left: 30, top: 20),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return emptyCity;
                }
                return null;
              },
              controller: cityController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.white70, style: BorderStyle.solid)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid)),
                hintText: fieldCity,
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          TextButton(
            onPressed: () {
              cityController.text.isNotEmpty
                  ? weatherBloc
                      .add(FetchSearchWeatherEvent(cityController.text))
                  : showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(forgotCity, style:Theme.of(context).textTheme.subtitle1),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              okDialog,
                            style:Theme.of(context).textTheme.subtitle1),
                            ),
                        ],
                      ),
                    );
            },
            child:
                Text(sendRequest, style: Theme.of(context).textTheme.headline3),
          ),
        ],
      ),
    );
  }
}
