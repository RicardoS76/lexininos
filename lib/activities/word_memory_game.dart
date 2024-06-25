import 'package:flutter/material.dart';

class WordMemoryGame extends StatefulWidget {
  @override
  _WordMemoryGameState createState() => _WordMemoryGameState();
}

class _WordMemoryGameState extends State<WordMemoryGame> {
  List<String> words = ['Gato', 'Perro', 'Casa', 'Flor'];
  List<String> shuffledWords = [];
  String? selectedWord;
  int score = 0;

  @override
  void initState() {
    super.initState();
    shuffledWords = List.from(words)..shuffle();
  }

  void _checkMatch(String word) {
    if (selectedWord == null) {
      selectedWord = word;
    } else {
      if (selectedWord == word) {
        setState(() {
          score += 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('¡Correcto!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inténtalo de nuevo')));
      }
      selectedWord = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parejas de Palabras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Empareja las palabras con sus imágenes',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: shuffledWords.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _checkMatch(shuffledWords[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        shuffledWords[index],
                        style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text('Puntuación: $score', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
