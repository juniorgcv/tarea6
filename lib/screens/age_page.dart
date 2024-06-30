import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgePage extends StatefulWidget {
  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final _nameController = TextEditingController();
  String _ageMessage = '';

  void _predictAge() async {
    final response = await http.get(
      Uri.parse('https://api.agify.io/?name=${_nameController.text}'),
    );
    final responseData = json.decode(response.body);
    final age = responseData['age'];

    setState(() {
      if (age < 18) {
        _ageMessage = 'Eres Joven!';
      } else if (age < 60) {
        _ageMessage = 'Eres un adulto!';
      } else {
        _ageMessage = 'Eres muy mayor!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predecir la edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Introdusca su nombre'),
            ),
            ElevatedButton(
              onPressed: _predictAge,
              child: Text('Predir la edad'),
            ),
            Text(
              _ageMessage,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
