import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List _articles = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.sonymusic.com/wp-json/wp/v2/posts/'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _articles = data;
          // Ordenar los artículos por fecha
          _articles.sort((a, b) =>
              DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
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

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se puede abrir el enlace $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ultimas noticias'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _hasError
                ? const Text('Problemas al cargar los datos')
                : ListView.builder(
                    itemCount: _articles.length >= 3 ? 3 : _articles.length,
                    itemBuilder: (context, index) {
                      final article = _articles[index];
                      return ListTile(
                        title: Text(article['title']['rendered']),
                        subtitle: Text(article['excerpt']['rendered']),
                        onTap: () => _launchURL('https://www.sonymusic.com/'),
                      );
                    },
                  ),
      ),
    );
  }
}
