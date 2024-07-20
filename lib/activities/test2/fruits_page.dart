import 'package:flutter/material.dart';
import 'package:lexininos/user/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/baseDatos/database_helper.dart';

class FruitsPage extends StatefulWidget {
  @override
  _FruitsPageState createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  final List<Map<String, dynamic>> _fruitData = [
    {
      'image': 'assets/frutas/cereza.jpg',
      'correctAnswer': 'Cereza',
      'options': ['Cereza', 'Ceriza', 'Cereja'],
      'description': 'Las cerezas son pequeñas, redondas y dulces.',
      'feedback': 'Cereza contiene 6 letras:\n\nC, E, R, E, Z, A'
    },
    {
      'image': 'assets/frutas/fresa.jpg',
      'correctAnswer': 'Fresa',
      'options': ['Fresa', 'Frisa', 'Frosa'],
      'description': 'Las fresas son rojas, jugosas y dulces.',
      'feedback': 'Fresa contiene 5 letras:\n\nF, R, E, S, A'
    },
    {
      'image': 'assets/frutas/kiwi.jpg',
      'correctAnswer': 'Kiwi',
      'options': ['Kiwi', 'Kowi', 'Kawi'],
      'description': 'El kiwi es una fruta verde con piel marrón.',
      'feedback': 'Kiwi contiene 4 letras:\n\nK, I, W, I'
    },
    {
      'image': 'assets/frutas/limon.jpg',
      'correctAnswer': 'Limón',
      'options': ['Limón', 'Lemón', 'Liman'],
      'description': 'El limón es amarillo y tiene un sabor ácido.',
      'feedback': 'Limón contiene 5 letras:\n\nL, I, M, Ó, N'
    },
    {
      'image': 'assets/frutas/mango.jpg',
      'correctAnswer': 'Mango',
      'options': ['Mango', 'Mengo', 'Mingo'],
      'description': 'El mango es una fruta tropical dulce y jugosa.',
      'feedback': 'Mango contiene 5 letras:\n\nM, A, N, G, O'
    },
    {
      'image': 'assets/frutas/manzana.jpg',
      'correctAnswer': 'Manzana',
      'options': ['Manzana', 'Menzana', 'Menzina'],
      'description': 'Las manzanas pueden ser rojas, verdes o amarillas.',
      'feedback': 'Manzana contiene 7 letras:\n\nM, A, N, Z, A, N, A'
    },
    {
      'image': 'assets/frutas/naranja.jpg',
      'correctAnswer': 'Naranja',
      'options': ['Naranja', 'Naranga', 'Naranta'],
      'description': 'La naranja es una fruta cítrica dulce y jugosa.',
      'feedback': 'Naranja contiene 7 letras:\n\nN, A, R, A, N, J, A'
    },
    {
      'image': 'assets/frutas/platano.jpg',
      'correctAnswer': 'Plátano',
      'options': ['Plátano', 'Plátana', 'Plátina'],
      'description': 'El plátano es una fruta larga y amarilla.',
      'feedback': 'Plátano contiene 7 letras:\n\nP, L, Á, T, A, N, O'
    },
    {
      'image': 'assets/frutas/sandia.jpg',
      'correctAnswer': 'Sandía',
      'options': ['Sandía', 'Sandía', 'Sondía'],
      'description': 'La sandía es grande, verde por fuera y roja por dentro.',
      'feedback': 'Sandía contiene 6 letras:\n\nS, A, N, D, Í, A'
    },
    {
      'image': 'assets/frutas/uva.jpg',
      'correctAnswer': 'Uva',
      'options': ['Uva', 'Eva', 'Iva'],
      'description': 'Las uvas pueden ser verdes, rojas o moradas.',
      'feedback': 'Uva contiene 3 letras:\n\nU, V, A'
    },
  ];

  int _currentIndex = 0;
  bool _showResult = false;
  bool _isCorrect = false;
  String _selectedOption = '';
  List<String> _shuffledOptions = [];
  late DateTime _startTime;
  int _errors = 0;

  @override
  void initState() {
    super.initState();
    if (_fruitData.isNotEmpty) {
      _startTime = DateTime.now();
      _shuffleOptions();
    }
  }

  void _shuffleOptions() {
    if (_fruitData.isNotEmpty) {
      _shuffledOptions = List.from(_fruitData[_currentIndex]['options']);
      _shuffledOptions.shuffle();
    }
  }

  void _checkAnswer(String answer) {
    setState(() {
      _isCorrect = answer == _fruitData[_currentIndex]['correctAnswer'];
      _selectedOption = answer;
      _showResult = true;
    });
    if (_isCorrect) {
      _showFeedbackDialog();
    } else {
      _errors++;
      _showIncorrectNotification();
    }
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              '¡Correcto!',
              style: TextStyle(
                fontFamily: 'Cocogoose',
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    _fruitData[_currentIndex]['feedback'].split('\n\n')[0],
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    _fruitData[_currentIndex]['feedback'].split('\n\n')[1],
                    style: TextStyle(
                      fontFamily: 'Cocogoose',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    _fruitData[_currentIndex]['description'],
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                      fontFamily: 'Cocogoose',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _nextFruit();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showIncorrectNotification() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              '¡Incorrecto!',
              style: TextStyle(
                fontFamily: 'Cocogoose',
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    'Inténtalo de nuevo',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Cocogoose',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _showResult = false;
                    _selectedOption = '';
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _nextFruit() {
    if (_currentIndex < _fruitData.length - 1) {
      setState(() {
        _currentIndex++;
        _showResult = false;
        _selectedOption = '';
        _shuffleOptions();
      });
    } else {
      _saveTestResults();
      _showCompletionDialog();
    }
  }

  void _saveTestResults() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool resultsMode = prefs.getBool('resultsMode') ?? false;
    final int endTime = DateTime.now().difference(_startTime).inSeconds;

    if (resultsMode) {
      final dbHelper = DatabaseHelper();
      int userId = await SharedPreferencesHelper.getUserId() ?? 0;
      await dbHelper.insertResult({
        'id_usuario': userId,
        'prueba': 3, // Representa la prueba de frutas
        'tiempo': endTime,
        'errores': _errors
      });
    }
  }

  Future<int> _getCurrentUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0; // Ajustar según sea necesario
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              '¡Prueba Completada!',
              style: TextStyle(
                fontFamily: 'Cocogoose',
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    'Has completado todas las preguntas.',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Cocogoose',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context); // Volver a la página principal
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getButtonColor(String option) {
    if (!_showResult) return Colors.white;
    if (_isCorrect) {
      return option == _selectedOption ? Colors.green : Colors.red;
    } else {
      return option == _selectedOption ? Colors.red : Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo difuminado
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),
                    Text(
                      'Conecta y Aprende',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: 'Cocogoose',
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    if (_fruitData.isNotEmpty) ...[
                      Container(
                        height: 300.0, // Imagen más grande
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            _fruitData[_currentIndex]['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        '¿Cuál es el nombre correcto de la fruta?',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'Cocogoose',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Column(
                        children: _shuffledOptions.map<Widget>((option) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            width: MediaQuery.of(context).size.width *
                                0.8, // Contenedor menos largo
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                backgroundColor: _getButtonColor(option),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              onPressed: () => _checkAnswer(option),
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Cocogoose',
                                  color:
                                      _showResult && option == _selectedOption
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ] else ...[
                      Center(
                        child: Text(
                          'No hay datos de frutas disponibles.',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cocogoose',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
