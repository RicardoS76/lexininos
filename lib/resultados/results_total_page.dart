import 'package:flutter/material.dart';

class ResultsTotalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados Totales'),
      ),
      body: Center(
        child: Text('Aquí se mostrarán los resultados totales de todas las pruebas.'),
      ),
    );
  }
}
