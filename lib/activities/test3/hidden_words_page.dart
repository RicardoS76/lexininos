import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/baseDatos/database_helper.dart';

class HiddenWordsPage extends StatefulWidget {
  @override
  _HiddenWordsPageState createState() => _HiddenWordsPageState();
}

class _HiddenWordsPageState extends State<HiddenWordsPage> {
  final List<String> words = [
    'SOL',
    'LUNA',
    'CASA',
    'GATO',
    'PERRO',
    'MESA',
    'BOLA',
    'FLOR',
    'NUBE',
    'RISA'
  ];

  late List<List<String>> grid;
  late List<bool> foundWords;
  List<int> selectedCells = [];
  List<int> correctCells = [];
  Offset? startPosition;
  Offset? endPosition;
  bool showInstructions = true;
  DateTime startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    grid = generateGrid();
    foundWords = List.generate(words.length, (index) => false);
    startTime = DateTime.now();
  }

  List<List<String>> generateGrid() {
    List<List<String>> emptyGrid =
        List.generate(10, (_) => List.generate(10, (_) => ' '));

    for (String word in words) {
      placeWordInGrid(word, emptyGrid);
    }

    fillEmptySpaces(emptyGrid);

    return emptyGrid;
  }

  void placeWordInGrid(String word, List<List<String>> grid) {
    bool placed = false;
    Random random = Random();
    while (!placed) {
      int direction = random.nextInt(2); // 0 for horizontal, 1 for vertical
      int startRow =
          random.nextInt(grid.length - (direction == 1 ? word.length : 0));
      int startCol =
          random.nextInt(grid[0].length - (direction == 0 ? word.length : 0));

      bool canPlace = true;
      for (int i = 0; i < word.length; i++) {
        int row = startRow + (direction == 1 ? i : 0);
        int col = startCol + (direction == 0 ? i : 0);
        if (grid[row][col] != ' ' && grid[row][col] != word[i]) {
          canPlace = false;
          break;
        }
      }

      if (canPlace) {
        for (int i = 0; i < word.length; i++) {
          int row = startRow + (direction == 1 ? i : 0);
          int col = startCol + (direction == 0 ? i : 0);
          grid[row][col] = word[i];
        }
        placed = true;
      }
    }
  }

  void fillEmptySpaces(List<List<String>> grid) {
    Random random = Random();
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == ' ') {
          grid[i][j] = String.fromCharCode(65 + random.nextInt(26));
        }
      }
    }
  }

  void checkWord() {
    String selectedWord =
        selectedCells.map((index) => grid[index ~/ 10][index % 10]).join('');
    int wordIndex = words.indexOf(selectedWord);
    if (wordIndex != -1 && !foundWords[wordIndex]) {
      setState(() {
        correctCells.addAll(selectedCells);
        foundWords[wordIndex] = true;
        selectedCells.clear();
      });

      if (foundWords.every((found) => found)) {
        _saveCompletionTime();
      }
    } else {
      setState(() {
        selectedCells.clear();
      });
    }
  }

  void handleTapDown(TapDownDetails details) {
    setState(() {
      startPosition = details.localPosition;
      endPosition = details.localPosition;
      selectCells();
    });
  }

  void handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      endPosition = details.localPosition;
      selectCells();
    });
  }

  void handlePanEnd(DragEndDetails details) {
    checkWord();
  }

  void selectCells() {
    if (startPosition == null || endPosition == null) return;

    int startRow = (startPosition!.dy ~/ 40).clamp(0, 9);
    int startCol = (startPosition!.dx ~/ 40).clamp(0, 9);
    int endRow = (endPosition!.dy ~/ 40).clamp(0, 9);
    int endCol = (endPosition!.dx ~/ 40).clamp(0, 9);

    List<int> newSelectedCells = [];
    if (startRow == endRow) {
      for (int col = startCol; col <= endCol; col++) {
        newSelectedCells.add(startRow * 10 + col);
      }
    } else if (startCol == endCol) {
      for (int row = startRow; row <= endRow; row++) {
        newSelectedCells.add(row * 10 + startCol);
      }
    }
    setState(() {
      selectedCells = newSelectedCells;
    });
  }

  void startGame() {
    setState(() {
      showInstructions = false;
      startTime = DateTime.now();
    });
  }

  void _saveCompletionTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool resultsMode = prefs.getBool('resultsMode') ?? false;

    if (resultsMode) {
      final dbHelper = DatabaseHelper();
      int userId = await _getCurrentUserId();
      int completionTime = DateTime.now().difference(startTime).inSeconds;
      await dbHelper.insertResult({
        'id_usuario': userId,
        'prueba': 3, // Representa la prueba de palabras escondidas
        'tiempo': completionTime,
        'errores': 0 // No se están rastreando los errores en esta prueba
      });
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('¡Felicidades!'),
        content: Text('Has completado la prueba. ¡Buen trabajo!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
              Navigator.of(context).pop(); // Regresa a la página anterior
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<int> _getCurrentUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0; // Ajustar según sea necesario
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
              'Selecciona las letras de las palabras que encuentres. ¡Vamos a jugar!',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,
                            size: 36.0, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
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
                                  text: 'S',
                                  style: TextStyle(
                                      color: Colors.red,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'o',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'p',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'a',
                                  style: TextStyle(
                                      color: Colors.green,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'd',
                                  style: TextStyle(
                                      color: Colors.red,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'e',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'L',
                                  style: TextStyle(
                                      color: Colors.green,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'e',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 't',
                                  style: TextStyle(
                                      color: Colors.red,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'r',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'a',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 's',
                                  style: TextStyle(
                                      color: Colors.green,
                                      shadows: _createShadows())),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 36.0),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Encuentra las siguientes palabras:',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: words
                        .asMap()
                        .map((index, word) => MapEntry(
                              index,
                              Chip(
                                label: Text(
                                  word,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    shadows: foundWords[index]
                                        ? [
                                            Shadow(
                                                color: Colors.green,
                                                blurRadius: 3)
                                          ]
                                        : [
                                            Shadow(
                                                color: Colors.red,
                                                blurRadius: 3)
                                          ],
                                  ),
                                ),
                                backgroundColor: Colors.white,
                              ),
                            ))
                        .values
                        .toList(),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTapDown: handleTapDown,
                    onPanUpdate: handlePanUpdate,
                    onPanEnd: handlePanEnd,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 10,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedCells.contains(index);
                          bool isCorrect = correctCells.contains(index);
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: isCorrect
                                  ? Colors.green
                                  : (isSelected ? Colors.yellow : Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                grid[index ~/ 10][index % 10],
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: isCorrect ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showInstructions) buildInstructions(context),
        ],
      ),
    );
  }
}
