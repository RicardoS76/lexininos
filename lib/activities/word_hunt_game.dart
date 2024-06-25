import 'package:flutter/material.dart';

class WordHuntGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caza de Palabras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Busca y selecciona las palabras',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Aquí puedes agregar la lógica de tu juego de caza de palabras
            // Ejemplo estático:
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                _buildWordButton(context, 'Gato'),
                _buildWordButton(context, 'Perro'),
                _buildWordButton(context, 'Casa'),
                _buildWordButton(context, 'Flor'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('¡Seleccionaste $text!')));
      },
      child: Text(text),
    );
  }
}
