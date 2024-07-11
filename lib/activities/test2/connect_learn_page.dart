import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/baseDatos/database_helper.dart';

class ConnectLearnPage extends StatefulWidget {
  @override
  _ConnectLearnPageState createState() => _ConnectLearnPageState();
}

class _ConnectLearnPageState extends State<ConnectLearnPage> {
  final List<Map<String, dynamic>> _animalData = [
    {
      'image': 'assets/animales/buho.jpg',
      'correctAnswer': 'Buho',
      'options': ['Buho', 'Baho', 'Bugo'],
      'description':
          'El búho es un ave nocturna que puede girar su cabeza hasta 270 grados.',
      'feedback': 'Buho contiene 4 letras:\n\nB, U, H, O'
    },
    {
      'image': 'assets/animales/canguro.jpg',
      'correctAnswer': 'Canguro',
      'options': ['Canguro', 'Canguro', 'Cunguro'],
      'description':
          'El canguro es un marsupial que salta sobre sus patas traseras.',
      'feedback': 'Canguro contiene 7 letras:\n\nC, A, N, G, U, R, O'
    },
    {
      'image': 'assets/animales/cebra.jpg',
      'correctAnswer': 'Cebra',
      'options': ['Cebra', 'Kebra', 'Tebra'],
      'description':
          'La cebra es un animal con rayas blancas y negras, pariente del caballo.',
      'feedback': 'Cebra contiene 5 letras:\n\nC, E, B, R, A'
    },
    {
      'image': 'assets/animales/delfin.jpg',
      'correctAnswer': 'Delfin',
      'options': ['Delfin', 'Delfon', 'Deltin'],
      'description':
          'El delfín es un mamífero marino conocido por su inteligencia y sociabilidad.',
      'feedback': 'Delfin contiene 6 letras:\n\nD, E, L, F, I, N'
    },
    {
      'image': 'assets/animales/elefante.jpg',
      'correctAnswer': 'Elefante',
      'options': ['Elefante', 'Elefente', 'Elefanpe'],
      'description':
          'El elefante es el animal terrestre más grande y tiene una trompa larga.',
      'feedback': 'Elefante contiene 8 letras:\n\nE, L, E, F, A, N, T, E'
    },
    {
      'image': 'assets/animales/jirafa.jpg',
      'correctAnswer': 'Jirafa',
      'options': ['Jirafa', 'Jirasa', 'Jiraga'],
      'description':
          'La jirafa es el animal más alto del mundo, con un cuello muy largo.',
      'feedback': 'Jirafa contiene 6 letras:\n\nJ, I, R, A, F, A'
    },
    {
      'image': 'assets/animales/leon.jpg',
      'correctAnswer': 'Leon',
      'options': ['Leon', 'Lean', 'Leom'],
      'description':
          'El león es conocido como el rey de la selva y vive en África.',
      'feedback': 'Leon contiene 4 letras:\n\nL, E, O, N'
    },
    {
      'image': 'assets/animales/mono.jpg',
      'correctAnswer': 'Mono',
      'options': ['Mono', 'Meno', 'Mino'],
      'description':
          'El mono es un primate que vive en los árboles y es muy juguetón.',
      'feedback': 'Mono contiene 4 letras:\n\nM, O, N, O'
    },
    {
      'image': 'assets/animales/panda.jpg',
      'correctAnswer': 'Panda',
      'options': ['Panda', 'Ponda', 'Pando'],
      'description':
          'El panda es un oso blanco y negro que come principalmente bambú.',
      'feedback': 'Panda contiene 5 letras:\n\nP, A, N, D, A'
    },
    {
      'image': 'assets/animales/tigre.jpg',
      'correctAnswer': 'Tigre',
      'options': ['Tigre', 'Tigra', 'Tigre'],
      'description':
          'El tigre es un gran felino con rayas negras y naranjas, y vive en Asia.',
      'feedback': 'Tigre contiene 5 letras:\n\nT, I, G, R, E'
    },
  ];
  int _currentIndex = 0;
  bool _showResult = false;
  bool _isCorrect = false;
  String _selectedOption = '';
  List<String> _shuffledOptions = [];
  int _errorCount = 0;

  @override
  void initState() {
    super.initState();
    _shuffleOptions();
  }

  void _shuffleOptions() {
    _shuffledOptions = List.from(_animalData[_currentIndex]['options']);
    _shuffledOptions.shuffle();
  }

  void _checkAnswer(String answer) {
    setState(() {
      _isCorrect = answer == _animalData[_currentIndex]['correctAnswer'];
      _selectedOption = answer;
      _showResult = true;
    });
    if (_isCorrect) {
      _showFeedbackDialog();
    } else {
      _errorCount++;
      _showIncorrectNotification();
    }
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                    _animalData[_currentIndex]['feedback'].split('\n\n')[0],
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    _animalData[_currentIndex]['feedback'].split('\n\n')[1],
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
                    _animalData[_currentIndex]['description'],
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
                    _nextAnimal();
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

  void _nextAnimal() {
    if (_currentIndex < _animalData.length - 1) {
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

    if (resultsMode) {
      final dbHelper = DatabaseHelper();
      int userId = await _getCurrentUserId();
      await dbHelper.insertResult({
        'id_usuario': userId,
        'prueba': 2, // Representa la prueba de animales
        'resultado': _errorCount.toString()
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                          _animalData[_currentIndex]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '¿Cuál es el nombre correcto del animal?',
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
