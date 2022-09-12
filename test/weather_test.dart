import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocito_demo/models/weather.dart';
import 'package:mocito_demo/services/weather_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'weather_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("Fetch weather data", () {
    test("Fetch weather with lat lng", () async {
      final client = MockClient();

      when(client.get(Uri.parse(
              'https://api.openweathermap.org/data/2.5/weather?lat=21.1702&lon=72.8311&appid=131d2bc7b5d1579337f264d706fc2692')))
          .thenAnswer((data) async {
        print(data);
        return http.Response('', 200);
      });
      // http.Response(
      // '{"userId": 1, "id": 2, "title": "mock test"}', 200)

      // );

      // expect(await fetchWeather(client, 21.1702, 78.8311), isA<WeatherModel>());
    });
  });
}
