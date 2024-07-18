import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/baseDatos/database_helper.dart';

class ObjectsPage extends StatefulWidget {
  @override
  _ObjectsPageState createState() => _ObjectsPageState();
}

class _ObjectsPageState extends State<ObjectsPage> {
  final List<Map<String, dynamic>> _objectData = [
    {
      'image': 'assets/objetos/bolsa.jpg',
      'correctAnswer': 'Bolsa',
      'options': ['Bolsa', 'Balsa', 'Balsa'],
      'description': 'Una bolsa se usa para llevar cosas.',
      'feedback': 'Bolsa contiene 5 letras:\n\nB, O, L, S, A'
    },
    {
      'image': 'assets/objetos/gafas.jpg',
      'correctAnswer': 'Gafas',
      'options': ['Gafas', 'Gafes', 'Gafos'],
      'description': 'Las gafas ayudan a ver mejor.',
      'feedback': 'Gafas contiene 5 letras:\n\nG, A, F, A, S'
    },
    {
      'image': 'assets/objetos/gorra.jpg',
      'correctAnswer': 'Gorra',
      'options': ['Gorra', 'Garra', 'Gorro'],
      'description': 'Una gorra protege del sol.',
      'feedback': 'Gorra contiene 5 letras:\n\nG, O, R, R, A'
    },
    {
      'image': 'assets/objetos/lapiz.jpg',
      'correctAnswer': 'Lápiz',
      'options': ['Lápiz', 'Lápez', 'Lápas'],
      'description': 'Un lápiz se usa para escribir.',
      'feedback': 'Lápiz contiene 5 letras:\n\nL, Á, P, I, Z'
    },
    {
      'image': 'assets/objetos/libro.jpg',
      'correctAnswer': 'Libro',
      'options': ['Libro', 'Liblo', 'Lipro'],
      'description': 'Un libro tiene muchas páginas.',
      'feedback': 'Libro contiene 5 letras:\n\nL, I, B, R, O'
    },
    {
      'image': 'assets/objetos/mesa.jpg',
      'correctAnswer': 'Mesa',
      'options': ['Mesa', 'Masa', 'Misa'],
      'description': 'Una mesa tiene cuatro patas.',
      'feedback': 'Mesa contiene 4 letras:\n\nM, E, S, A'
    },
    {
      'image': 'assets/objetos/pelota.jpg',
      'correctAnswer': 'Pelota',
      'options': ['Pelota', 'Pelosa', 'Peleto'],
      'description': 'Una pelota se usa para jugar.',
      'feedback': 'Pelota contiene 6 letras:\n\nP, E, L, O, T, A'
    },
    {
      'image': 'assets/objetos/reloj.jpg',
      'correctAnswer': 'Reloj',
      'options': ['Reloj', 'Relog', 'Relij'],
      'description': 'Un reloj muestra la hora.',
      'feedback': 'Reloj contiene 5 letras:\n\nR, E, L, O, J'
    },
    {
      'image': 'assets/objetos/silla.jpg',
      'correctAnswer': 'Silla',
      'options': ['Silla', 'Salla', 'Silla'],
      'description': 'Una silla se usa para sentarse.',
      'feedback': 'Silla contiene 5 letras:\n\nS, I, L, L, A'
    },
    {
      'image': 'assets/objetos/zapato.jpg',
      'correctAnswer': 'Zapato',
      'options': ['Zapato', 'Zaparo', 'Zapata'],
      'description': 'Un zapato se usa en el pie.',
      'feedback': 'Zapato contiene 6 letras:\n\nZ, A, P, A, T, O'
    },
  ];

  int _currentIndex = 0;
  bool _showResult = false;
  bool _isCorrect = false;
  String _selectedOption = '';
  List<String> _shuffledOptions = [];
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _shuffleOptions();
  }

  void _shuffleOptions() {
    _shuffledOptions = List.from(_objectData[_currentIndex]['options']);
    _shuffledOptions.shuffle();
  }

  void _checkAnswer(String answer) {
    setState(() {
      _isCorrect = answer == _objectData[_currentIndex]['correctAnswer'];
      _selectedOption = answer;
      _showResult = true;
    });
    if (_isCorrect) {
      _showFeedbackDialog();
    } else {
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
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    _objectData[_currentIndex]['feedback'].split('\n\n')[0],
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    _objectData[_currentIndex]['feedback'].split('\n\n')[1],
                    style: TextStyle(
                        fontFamily: 'Cocogoose',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    _objectData[_currentIndex]['description'],
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
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
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _nextObject();
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
                  fontWeight: FontWeight.bold),
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
                        fontWeight: FontWeight.bold),
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
                      fontWeight: FontWeight.bold),
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

  void _nextObject() {
    if (_currentIndex < _objectData.length - 1) {
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
      int userId = await _getCurrentUserId();
      await dbHelper.insertResult({
        'id_usuario': userId,
        'prueba': 4, // Representa la prueba de objetos
        'resultado': endTime.toString()
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
                  fontWeight: FontWeight.bold),
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
                        fontWeight: FontWeight.bold),
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
                      fontWeight: FontWeight.bold),
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
                          _objectData[_currentIndex]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '¿Cuál es el nombre correcto del objeto?',
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
                                color: _showResult && option == _selectedOption
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
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
