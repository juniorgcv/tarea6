import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre mi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://media.licdn.com/dms/image/C4E03AQHIjhugvBZdNg/profile-displayphoto-shrink_800_800/0/1515643135126?e=1724889600&v=beta&t=GUI_AIfd4M1UCjh__g_IwBQ0ytvhslnpVlPaJ_nvoLs'),
              radius: 50,
            ),
            SizedBox(height: 16),
            Text(
              'German J. Cespedes Estevez',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8),
            Text('Informacion de Contacto: 20197569@itla.edu.do'),
            Text('Telefono: +18299657036'),
          ],
        ),
      ),
    );
  }
}
