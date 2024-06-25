import 'package:flutter/material.dart';

class UserDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de usuario'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Detalles del usuario',
          style: TextStyle(fontSize: 24.0, color: Colors.purple),
        ),
      ),
    );
  }
}
