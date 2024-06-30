import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo,DO&appid=b25b61a81cebc15d5ec403933c61bb6d&units=metric&lang=sp'));

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body);
          _isLoading = false;
          _hasError = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima en Santo Domingo'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _hasError
                ? const Text('Error al cargar los datos del clima')
                : _weatherData == null
                    ? const Text('Datos no disponibles')
                    : _buildWeatherContent(),
      ),
    );
  }

  Widget _buildWeatherContent() {
    final weather = _weatherData!['weather'][0];
    final main = _weatherData!['main'];
    final temp = main['temp'].toString();
    final description = weather['description'];
    final iconCode = weather['icon'];

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Santo Domingo',
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Image.network(
            'https://openweathermap.org/img/wn/$iconCode@2x.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20.0),
          Text(
            '$temp°C',
            style: TextStyle(
              fontSize: 64.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            description.toString().toUpperCase(),
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
