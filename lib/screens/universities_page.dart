import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversitiesPage extends StatefulWidget {
  @override
  _UniversitiesPageState createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends State<UniversitiesPage> {
  final _countryController = TextEditingController();
  List<dynamic> _universities = [];

  void _fetchUniversities() async {
    final response = await http.get(
      Uri.parse(
          'http://universities.hipolabs.com/search?country=${_countryController.text}'),
    );
    final responseData = json.decode(response.body);

    setState(() {
      _universities = responseData;
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Universities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'Enter Country'),
            ),
            ElevatedButton(
              onPressed: _fetchUniversities,
              child: Text('Fetch Universities'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  final university = _universities[index];
                  return ListTile(
                    title: Text(university['name']),
                    subtitle: Text(university['domains'][0]),
                    onTap: () {
                      _launchURL(university['web_pages'][0]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
