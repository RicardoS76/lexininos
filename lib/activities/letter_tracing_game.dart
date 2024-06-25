import 'package:flutter/material.dart';

class LetterTracingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trazado de Letras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Traza las letras con tu dedo',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Aquí puedes implementar una lógica más avanzada para el trazado de letras
            // Ejemplo simple con un contenedor estático
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  'A',
                  style: TextStyle(fontSize: 200.0, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
