import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información de Contacto',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontFamily: 'Cocogoose',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Puedes contactarnos a través de los siguientes medios:',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email, color: Colors.purple),
              title: Text('Email: contacto@ejemplo.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.purple),
              title: Text('Teléfono: +52 123 456 7890'),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.purple),
              title: Text('Dirección: Calle Ejemplo 123, Ciudad, País'),
            ),
          ],
        ),
      ),
    );
  }
}
