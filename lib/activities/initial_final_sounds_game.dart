import 'package:flutter/material.dart';

class InitialFinalSoundsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juegos de Sonidos Iniciales y Finales'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Identifica los sonidos iniciales y finales',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Draggable<String>(
                  data: 'gato',
                  child: _buildDraggableItem('Gato'),
                  feedback: _buildDraggableItem('Gato', isDragging: true),
                  childWhenDragging: _buildDraggableItem('Gato', isDragging: false),
                ),
                DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    return _buildDraggableItem('G');
                  },
                  onWillAccept: (data) => data == 'gato',
                  onAccept: (data) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('¡Correcto!')),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Draggable<String>(
                  data: 'perro',
                  child: _buildDraggableItem('Perro'),
                  feedback: _buildDraggableItem('Perro', isDragging: true),
                  childWhenDragging: _buildDraggableItem('Perro', isDragging: false),
                ),
                DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    return _buildDraggableItem('P');
                  },
                  onWillAccept: (data) => data == 'perro',
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
