import 'package:flutter/material.dart';

class HiddenWordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palabras Escondidas'),
      ),
      body: Center(
        child: Text(
          'Contenido de Palabras Escondidas',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
