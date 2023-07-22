import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String baseUrl = 'https://api.weatherapi.com/v1';
  String apiKey = '6fe0b996c1bd47d4b1f214318230306';
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;

    Uri url =
        Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');

    http.Response response = await http.get(url);

    if (response.statusCode == 400) {
      var data = jsonDecode(response.body);
      throw Exception(data['error']['message']);
    }
    Map<String, dynamic> data = jsonDecode(response.body);

    weather = WeatherModel.fromJson(data);

    return weather;
  }
}
