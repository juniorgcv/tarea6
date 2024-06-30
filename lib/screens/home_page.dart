import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // Agregar el parámetro key al constructor
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarea 6'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF-YMqH1fRvAFrUN0b0Y_0u0v_dDYaAfGA0w&s'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gender');
              },
              child: const Text('Predecir el genero'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/age');
              },
              child: const Text('Predecir la edad'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/universities');
              },
              child: const Text('Lista de universidades'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
              child: const Text('Clima en Rd'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news');
              },
              child: const Text('Ultimas noticias'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: const Text('Sobre mi'),
            ),
          ],
        ),
      ),
    );
  }
}
