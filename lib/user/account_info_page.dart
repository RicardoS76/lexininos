import 'package:flutter/material.dart';

class AccountInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de la cuenta'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Detalles de la cuenta',
          style: TextStyle(fontSize: 24.0, color: Colors.purple),
        ),
      ),
    );
  }
}
