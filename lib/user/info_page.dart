import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Información',
          style: TextStyle(fontSize: 24.0, color: Colors.purple),
        ),
      ),
    );
  }
}
