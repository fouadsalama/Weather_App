import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';

import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/pages/widgets/default_body.dart';
import 'package:weather_app/pages/widgets/success_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

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
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPage();
                  }));
                },
                icon: const Icon(Icons.search),
              ),
            ],
            title: const Text('Weather App'),
          ),
          body: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherSuccess) {
              weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
              print('weatherData is $weatherData');
              return SuccessBody(weatherData: weatherData);
            } else if (state is WeatherFailure) {
              return const Center(
                child: Text('something went wrong please try again'),
              );
            } else {
              return const DefaultBody();
            }
          }),
        );
      },
    );
  }
}
