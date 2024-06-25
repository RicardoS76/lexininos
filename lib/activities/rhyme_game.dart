import 'package:flutter/material.dart';

class RhymeGame extends StatefulWidget {
  @override
  _RhymeGameState createState() => _RhymeGameState();
}

class _RhymeGameState extends State<RhymeGame> {
  final List<Map<String, dynamic>> words = [
    {'word': 'Gato', 'rhyme': 'ato', 'selected': false, 'offset': Offset.zero},
    {'word': 'Perro', 'rhyme': 'erro', 'selected': false, 'offset': Offset.zero},
    {'word': 'Pato', 'rhyme': 'ato', 'selected': false, 'offset': Offset.zero},
    {'word': 'Mesa', 'rhyme': 'esa', 'selected': false, 'offset': Offset.zero},
    {'word': 'Rato', 'rhyme': 'ato', 'selected': false, 'offset': Offset.zero},
    {'word': 'Casa', 'rhyme': 'asa', 'selected': false, 'offset': Offset.zero},
  ];

  Map<String, dynamic>? selectedWord;
  List<Offset> lineOffsets = [];
  String feedbackMessage = '';
  Color feedbackColor = Colors.green;

  void selectWord(Map<String, dynamic> word, Offset offset) {
    setState(() {
      if (selectedWord == null) {
        selectedWord = word;
        selectedWord!['selected'] = true;
        selectedWord!['offset'] = offset;
      } else {
        if (selectedWord!['rhyme'] == word['rhyme'] && selectedWord!['word'] != word['word']) {
          lineOffsets.add(selectedWord!['offset']);
          lineOffsets.add(offset);
          feedbackMessage = '¡Correcto!';
          feedbackColor = Colors.green;
          selectedWord!['selected'] = false;
          selectedWord = null;
        } else {
          feedbackMessage = 'Inténtalo de nuevo';
          feedbackColor = Colors.red;
          selectedWord!['selected'] = false;
          selectedWord = null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de colores pasteles
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink.shade100,
                  Colors.blue.shade100,
                  Colors.green.shade100,
                  Colors.yellow.shade100,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Título con icono de home
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.home, size: 40.0, color: Colors.white),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 36.0, // Tamaño grande para que sea entendible para el niño
                              fontFamily: 'Cocogoose',
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            children: [
                              TextSpan(text: 'R', style: TextStyle(color: Colors.red)),
                              TextSpan(text: 'i', style: TextStyle(color: Colors.blue)),
                              TextSpan(text: 'm', style: TextStyle(color: Colors.green)),
                              TextSpan(text: 'a', style: TextStyle(color: Colors.yellow)),
                              TextSpan(text: 's', style: TextStyle(color: Colors.orange)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 60), // Espacio proporcional para alinear el título
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Instrucción
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/señal.png', height: 100.0),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Empareja las palabras que riman',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Palabras en cuadrícula
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                    ),
                    padding: EdgeInsets.all(20.0),
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      final word = words[index];
                      return GestureDetector(
                        onTapUp: (details) {
                          selectWord(word, details.globalPosition);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: word['selected'] ? Colors.grey : Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
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
                              word['word'],
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Retroalimentación
                AnimatedOpacity(
                  opacity: feedbackMessage.isEmpty ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    feedbackMessage,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: feedbackColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final List<Offset> offsets;

  LinePainter(this.offsets);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < offsets.length; i += 2) {
      canvas.drawLine(offsets[i], offsets[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
