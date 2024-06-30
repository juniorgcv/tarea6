import 'package:flutter/material.dart';
import 'screens/about_page.dart';
import 'screens/age_page.dart';
import 'screens/gender_page.dart';
import 'screens/home_page.dart';
import 'screens/news_page.dart';
import 'screens/universities_page.dart';
import 'screens/weather_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Agregar el parámetro key al constructor
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/gender': (context) => GenderPage(),
        '/age': (context) => AgePage(),
        '/universities': (context) => UniversitiesPage(),
        '/weather': (context) => WeatherPage(),
        '/news': (context) => NewsPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}
