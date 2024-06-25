import 'package:flutter/material.dart';

class LetterPuzzleGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Construcción de Letras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ensambla las letras a partir de piezas',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Aquí puedes agregar la lógica de tu juego de rompecabezas de letras
            // Ejemplo estático:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Draggable<String>(
                  data: 'A',
                  child: _buildDraggableItem('A'),
                  feedback: _buildDraggableItem('A', isDragging: true),
                  childWhenDragging: _buildDraggableItem('A', isDragging: false),
                ),
                DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    return _buildDraggableItem('A');
                  },
                  onWillAccept: (data) => data == 'A',
                  onAccept: (data) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('¡Correcto!')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableItem(String text, {bool isDragging = false}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey : Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          if (!isDragging)
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
