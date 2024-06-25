import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Resultados'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Resultados',
          style: TextStyle(fontSize: 24.0, color: Colors.purple),
        ),
      ),
    );
  }
}
