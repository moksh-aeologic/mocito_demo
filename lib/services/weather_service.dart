import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather.dart';

Future<WeatherModel> fetchWeather(http.Client client, lat, lng) async {
  final response = await client.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather'
          // ?lat=21.1702&lon=72.8311&appid=131d2bc7b5d1579337f264d706fc2692'
          )
      .replace(queryParameters: {
    'lat': lat,
    'lon': lng,
    'appid': '131d2bc7b5d1579337f264d706fc2692'
  }));

  if (response.statusCode == 200) {
    return WeatherModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather');
  }
}
