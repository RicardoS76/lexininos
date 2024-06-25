import 'package:flutter/material.dart';

class InteractiveStoryGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exploración de Historias'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Haz clic en las palabras para escuchar su pronunciación',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Aquí puedes agregar la lógica de tu historia interactiva
            // Ejemplo estático:
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 24.0, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Había una vez un ',
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('¡Perro!')));
                          },
                          child: Text(
                            'perro',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      TextSpan(text: ' que vivía en una '),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('¡Casa!')));
                          },
                          child: Text(
                            'casa',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
