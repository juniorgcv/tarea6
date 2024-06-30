import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderPage extends StatefulWidget {
  // Agregar el parámetro key al constructor
  const GenderPage({Key? key}) : super(key: key);

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final _nameController = TextEditingController();
  String _gender = '';
  String _message = '';

  void _predictGender() async {
    final response = await http.get(
      Uri.parse('https://api.genderize.io/?name=${_nameController.text}'),
    );
    final responseData = json.decode(response.body);

    setState(() {
      _gender = responseData['gender'];
      _message = _gender == 'male' ? 'It\'s a boy!' : 'It\'s a girl!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predecir el genero'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Introdusca su nombre'),
            ),
            ElevatedButton(
              onPressed: _predictGender,
              child: const Text('Predecir el genero'),
            ),
            Text(
              _message,
              style: TextStyle(
                fontSize: 24,
                color: _gender == 'male' ? Colors.blue : Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
