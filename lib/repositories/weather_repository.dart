import 'package:learning_app/models/weather.dart';
import 'package:learning_app/services/weather_api_services.dart';

class WeatherRepository {
  Future<Weather> fetchWeather(String city) async {
    return await WeatherApiService.fetchWeather(city);
  }
}
