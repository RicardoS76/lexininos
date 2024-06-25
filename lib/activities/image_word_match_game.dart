import 'package:flutter/material.dart';

class ImageWordMatchGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asociación de Imágenes y Palabras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Empareja las palabras con las imágenes',
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
                    return Image.asset(
                      'assets/gato.png',
                      width: 100,
                      height: 100,
                    );
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
