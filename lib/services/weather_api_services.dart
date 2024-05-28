import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_app/models/weather.dart';

class WeatherApiService {
  static const String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String apiKey = '4fbcaea02da3f8d21a4ac27cfc5dca4c';

  static Future<Weather> fetchWeather(String city) async {
    final url = Uri.parse('$apiUrl?q=$city&units=metric&appid=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return Weather.fromJson(data);
    } else {
      throw jsonDecode(response.body)['message'];
    }
  }
}
