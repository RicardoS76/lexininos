import 'package:flutter/material.dart';

class VisualChallengePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desafío Visual: Figuras'),
      ),
      body: Center(
        child: Text(
          'Contenido de Desafío Visual: Figuras',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
