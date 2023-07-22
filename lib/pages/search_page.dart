import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/cubits/weather_state.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  String? cityName;

  SearchPage({Key? key, this.cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                BlocProvider.of<WeatherCubit>(context).weatherModel == null
                    ? Colors.blue
                    : BlocProvider.of<WeatherCubit>(context)
                        .weatherModel
                        ?.getThemeColor(),
            title: const Text('Search a City'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (data) {
                  cityName = data;
                },
                onSubmitted: (data) async {
                  cityName = data;

                  BlocProvider.of<WeatherCubit>(context)
                      .getWeather(cityName: cityName!);
                  BlocProvider.of<WeatherCubit>(context).cityName = cityName;

                  Navigator.pop(context);
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  labelText: 'Search',
                  labelStyle: const TextStyle(color: Colors.black54),
                  hintText: 'Enter a city',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      BlocProvider.of<WeatherCubit>(context).cityName =
                          cityName;
                      BlocProvider.of<WeatherCubit>(context)
                          .getWeather(cityName: cityName!);

                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
