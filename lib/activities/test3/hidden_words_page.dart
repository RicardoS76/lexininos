import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lexininos/user/shared_preferences.dart';
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
  String selectedWord = '';

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
    String currentWord =
        selectedCells.map((index) => grid[index ~/ 10][index % 10]).join('');
    int wordIndex = words.indexOf(currentWord);
    if (wordIndex != -1 && !foundWords[wordIndex]) {
      setState(() {
        correctCells.addAll(selectedCells);
        foundWords[wordIndex] = true;
        selectedCells.clear();
        selectedWord = '';
      });

      if (foundWords.every((found) => found)) {
        _saveCompletionTime();
      }
    } else {
      setState(() {
        selectedCells.clear();
        selectedWord = '';
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

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    double gridWidth = renderBox.size.width - 32; // Adjust for padding
    double cellSize = gridWidth / 10;

    int startRow = (startPosition!.dy ~/ cellSize).clamp(0, 9);
    int startCol = (startPosition!.dx ~/ cellSize).clamp(0, 9);
    int endRow = (endPosition!.dy ~/ cellSize).clamp(0, 9);
    int endCol = (endPosition!.dx ~/ cellSize).clamp(0, 9);

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
      selectedWord =
          selectedCells.map((index) => grid[index ~/ 10][index % 10]).join('');
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
      int userId = await SharedPreferencesHelper.getUserId() ?? 0;
      int completionTime = DateTime.now().difference(startTime).inSeconds;
      await dbHelper.insertResult({
        'id_usuario': userId,
        'prueba': 5, // Representa la prueba de palabras escondidas
        'tiempo': completionTime,
        'errores': 0 // No se están rastreando los errores en esta prueba
      });
    }

    showDialog(
      context: context,
      builder: (context) => buildCompletionDialog(context),
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

  Widget buildCompletionDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        '¡Felicidades!',
        style: TextStyle(
          fontSize: 36.0,
          fontFamily: 'Cocogoose',
          fontWeight: FontWeight.bold,
          shadows: _createShadows(),
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Has completado la prueba. ¡Buen trabajo!',
        style: TextStyle(fontSize: 24.0),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
              Navigator.of(context).pop(); // Regresa a la página anterior
            },
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
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cellSize = min(constraints.maxWidth / 10, constraints.maxHeight / 12);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, size: 36.0, color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Sopa de Letras',
                                  style: TextStyle(
                                    fontSize: 36.0,
                                    fontFamily: 'Cocogoose',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                    shadows: _createShadows(),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(width: 36.0),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double maxWidth = constraints.maxWidth;
                            double chipWidth = (maxWidth - 32) / 5; // Ajustar para 5 chips por fila

                            return Column(
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: words.sublist(0, 5).map((word) {
                                    int index = words.indexOf(word);
                                    return Container(
                                      width: chipWidth,
                                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: foundWords[index]
                                                ? Colors.green
                                                : Colors.red,
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            word,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: words.sublist(5, 10).map((word) {
                                    int index = words.indexOf(word);
                                    return Container(
                                      width: chipWidth,
                                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: foundWords[index]
                                                ? Colors.green
                                                : Colors.red,
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            word,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedWord,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTapDown: handleTapDown,
                        onPanUpdate: handlePanUpdate,
                        onPanEnd: handlePanEnd,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 2.0,
                              childAspectRatio: 1,
                            ),
                            itemCount: 100,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedCells.contains(index);
                              bool isCorrect = correctCells.contains(index);
                              return Container(
                                width: cellSize,
                                height: cellSize,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: isCorrect
                                      ? Colors.green
                                      : (isSelected
                                          ? Colors.yellow
                                          : Colors.white),
                                ),
                                child: Center(
                                  child: Text(
                                    grid[index ~/ 10][index % 10],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: isCorrect
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (showInstructions) buildInstructions(context),
        ],
      ),
    );
  }
}
