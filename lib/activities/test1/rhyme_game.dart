import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/baseDatos/database_helper.dart'; // Asegúrate de importar tu DatabaseHelper

class RhymeGame extends StatefulWidget {
  @override
  _RhymeGameState createState() => _RhymeGameState();
}

class _RhymeGameState extends State<RhymeGame> {
  int currentLevel = 1;
  bool showInstructions = true;
  bool showLevelComplete = false;
  bool showFeedback = false;
  bool allLevelsComplete = false;
  DateTime startTime = DateTime.now();

  final List<List<String>> topWordsLevels = [
    ['pan', 'rey', 'mar', 'voz'],
    ['flor', 'sol', 'nube', 'luz', 'tren'],
    ['casa', 'gato', 'mesa', 'balón', 'ventana', 'ratón'],
    ['silla', 'perro', 'barco', 'noche', 'día', 'río']
  ];

  final List<List<String>> bottomWordsLevels = [
    ['plan', 'ley', 'par', 'dos'],
    ['amor', 'rol', 'sube', 'cruz', 'bien'],
    ['masa', 'pato', 'pesa', 'pelón', 'antena', 'camión'],
    ['villa', 'cerro', 'charco', 'roche', 'fría', 'tío']
  ];

  final List<Map<String, String>> correctPairsLevels = [
    {'pan': 'plan', 'rey': 'ley', 'mar': 'par', 'voz': 'dos'},
    {'flor': 'amor', 'sol': 'rol', 'nube': 'sube', 'luz': 'cruz', 'tren': 'bien'},
    {'casa': 'masa', 'gato': 'pato', 'mesa': 'pesa', 'balón': 'pelón', 'ventana': 'antena', 'ratón': 'camión'},
    {'silla': 'villa', 'perro': 'cerro', 'barco': 'charco', 'noche': 'roche', 'día': 'fría', 'río': 'tío'}
  ];

  List<String> topWords = [];
  List<String> bottomWords = [];
  Map<String, String> correctPairs = {};
  String feedbackMessage = '';
  Color feedbackColor = Colors.transparent;
  int correctCount = 0;

  @override
  void initState() {
    super.initState();
    _loadLevel(1);
  }

  void _loadLevel(int level) {
    setState(() {
      currentLevel = level;
      topWords = List.from(topWordsLevels[level - 1]);
      bottomWords = List.from(bottomWordsLevels[level - 1]);
      topWords.shuffle();
      bottomWords.shuffle();
      correctPairs = Map.from(correctPairsLevels[level - 1]);
      correctCount = 0;
      feedbackMessage = '';
      feedbackColor = Colors.transparent;
      showInstructions = true;
      showLevelComplete = false;
      showFeedback = false;
      allLevelsComplete = false;
      startTime = DateTime.now();
    });
  }

  void checkRhyme(String topWord, String bottomWord) {
    if (correctPairs[topWord] == bottomWord) {
      setState(() {
        feedbackMessage = '¡Correcto!';
        feedbackColor = Colors.green;
        correctCount++;
        topWords.remove(topWord);
        bottomWords.remove(bottomWord);
        showFeedback = true;
      });
    } else {
      setState(() {
        feedbackMessage = 'Inténtalo de nuevo';
        feedbackColor = Colors.red;
        showFeedback = true;
      });
    }

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showFeedback = false;
        if (correctCount == correctPairs.length) {
          if (currentLevel < 4) {
            showLevelComplete = true;
            _saveLevelTime();
          } else {
            _saveLevelTime();
            allLevelsComplete = true;
          }
        }
      });
    });
  }

  void _saveLevelTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int endTime = DateTime.now().difference(startTime).inSeconds;

    switch (currentLevel) {
      case 1:
        prefs.setInt('level1_time', endTime);
        break;
      case 2:
        prefs.setInt('level2_time', endTime);
        break;
      case 3:
        prefs.setInt('level3_time', endTime);
        break;
      case 4:
        prefs.setInt('level4_time', endTime);
        break;
    }

    // Verificar si el modo de resultados está activo
    bool resultsMode = prefs.getBool('resultsMode') ?? false;
    if (resultsMode) {
      // Guardar resultados en la base de datos
      final dbHelper = DatabaseHelper();
      int userId = await _getCurrentUserId();
      await dbHelper.insertResult({
        'id_usuario': userId,
        'prueba': currentLevel,
        'resultado': endTime.toString()
      });
    }
  }

  Future<int> _getCurrentUserId() async {
    // Implementar lógica para obtener el ID del usuario actual
    // Puede ser de SharedPreferences o de otra fuente
    // Suponiendo que se almacena en SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0; // Ajustar según sea necesario
  }

  void startGame() {
    setState(() {
      showInstructions = false;
    });
  }

  void nextLevel() {
    if (currentLevel < 4) {
      _loadLevel(currentLevel + 1);
    }
  }

  void goToMainPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildGame(context),
          if (showInstructions) buildInstructions(context),
          if (showLevelComplete) buildLevelComplete(context),
          if (showFeedback) buildFeedbackMessage(),
          if (allLevelsComplete) buildAllLevelsComplete(context),
        ],
      ),
    );
  }

  Widget buildInstructions(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Instrucciones',
              style: TextStyle(
                fontSize: 36.0,
                fontFamily: 'Cocogoose',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Arrastra las palabras de arriba hacia las palabras de abajo que rimen con ellas. ¡Vamos a jugar!',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              '¿Estás listo?',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Cocogoose',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Iniciar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLevelComplete(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¡Felicidades!',
              style: TextStyle(
                fontSize: 36.0,
                fontFamily: 'Cocogoose',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Has completado el nivel $currentLevel.',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              currentLevel < 4
                  ? 'Iniciar nivel ${currentLevel + 1}'
                  : 'Has completado todos los niveles',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            if (currentLevel < 4)
              ElevatedButton(
                onPressed: nextLevel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Cocogoose',
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Iniciar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildAllLevelsComplete(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¡Felicidades!',
              style: TextStyle(
                fontSize: 36.0,
                fontFamily: 'Cocogoose',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Has completado todos los niveles.',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: goToMainPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Cocogoose',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Regresar al Inicio',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGame(BuildContext context) {
    return Stack(
      children: [
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: 40.0, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 36.0,
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
                          TextSpan(
                              text: 'R',
                              style: TextStyle(
                                  color: Colors.red,
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'i',
                              style: TextStyle(
                                  color: Colors.orange,
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'm',
                              style: TextStyle(
                                  color: Colors.yellow,
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 'a',
                              style: TextStyle(
                                  color: Colors.green,
                                  shadows: _createShadows())),
                          TextSpan(
                              text: 's',
                              style: TextStyle(
                                  color: Colors.blue,
                                  shadows: _createShadows())),
                        ],
                      ),
                    ),
                    SizedBox(width: 40.0), // Placeholder for alignment
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.asset('assets/señal.png', height: 50.0),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Empareja las palabras que riman',
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    buildWordGrid(topWords, true),
                    Spacer(),
                    buildWordGrid(bottomWords, false),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildWordGrid(List<String> words, bool isTop) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 2.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: words.length,
      itemBuilder: (context, index) {
        if (isTop) {
          return Draggable<String>(
            data: words[index],
            feedbackOffset:
                Offset(0, -25), // Centra la palabra arrastrada debajo del dedo
            child: WordBox(word: words[index]),
            feedback: Material(
              color: Colors.transparent,
              child: Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Text(
                  words[index],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            childWhenDragging: WordBox(word: '', dragging: true),
          );
        } else {
          return DragTarget<String>(
            onWillAccept: (receivedWord) {
              return true;
            },
            onAccept: (receivedWord) {
              checkRhyme(receivedWord, words[index]);
            },
            builder: (context, candidateData, rejectedData) {
              return WordBox(word: words[index]);
            },
          );
        }
      },
    );
  }

  Widget buildFeedbackMessage() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 150.0,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: feedbackColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              feedbackMessage,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cocogoose',
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Shadow> _createShadows() {
    return [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 2.0,
        color: Colors.black,
      ),
    ];
  }
}

class WordBox extends StatelessWidget {
  final String word;
  final bool dragging;

  WordBox({required this.word, this.dragging = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: dragging ? Colors.grey : Colors.white.withOpacity(0.7),
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
          word,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
