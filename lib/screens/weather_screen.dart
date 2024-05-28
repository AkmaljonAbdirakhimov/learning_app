// lib/screens/weather_screen.dart
import 'package:flutter/material.dart';
import 'package:learning_app/models/weather.dart';
import 'package:learning_app/repositories/weather_repository.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Weather> _weatherFuture;
  final _weatherRepository = WeatherRepository();
  final TextEditingController _cityController = TextEditingController();
  String selectedCity = "Tashkent";

  @override
  void initState() {
    super.initState();
    _weatherFuture = _weatherRepository.fetchWeather(selectedCity);
  }

  Future<void> _fetchWeather() async {
    setState(() {
      if (_cityController.text.trim().isNotEmpty) {
        selectedCity = _cityController.text;
      }
      _weatherFuture = _weatherRepository.fetchWeather(selectedCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchWeather,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter city',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _fetchWeather,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<Weather>(
                future: _weatherFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('No data available');
                  } else {
                    final weather = snapshot.data!;
                    return Column(
                      children: [
                        Text(
                          weather.city,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${weather.temperature.toStringAsFixed(0)}°C',
                          style: const TextStyle(fontSize: 48),
                        ),
                        Text(
                          weather.description,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Image.network(
                          'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
