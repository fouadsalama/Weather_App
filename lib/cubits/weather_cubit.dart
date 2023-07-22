import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this.weatherService,
  ) : super(InitialState());
  WeatherService weatherService;

  String? cityName;

  WeatherModel? weatherModel;

  static WeatherCubit get(context) => BlocProvider.of(context);

  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      weatherModel = await weatherService.getWeather(cityName: cityName);

      print(weatherModel?.maxTemp);
      print(weatherModel?.code);

      emit(WeatherSuccess());
    } catch (e) {
      emit(WeatherFailure());
    }
  }
}
