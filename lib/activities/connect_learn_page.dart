import 'package:flutter/material.dart';

class ConnectLearnPage extends StatefulWidget {
  @override
  _ConnectLearnPageState createState() => _ConnectLearnPageState();
}

class _ConnectLearnPageState extends State<ConnectLearnPage> {
  final List<Map<String, dynamic>> _animalData = [
    {
      'image': 'assets/animales/buho.jpg',
      'correctAnswer': 'Buho',
      'options': ['Buho', 'Baho', 'Bugo']
    },
    {
      'image': 'assets/animales/canguro.jpg',
      'correctAnswer': 'Canguro',
      'options': ['Canguro', 'Canguro', 'Cunguro']
    },
    {
      'image': 'assets/animales/cebra.jpg',
      'correctAnswer': 'Cebra',
      'options': ['Cebra', 'Kebra', 'Tebra']
    },
    {
      'image': 'assets/animales/delfin.jpg',
      'correctAnswer': 'Delfin',
      'options': ['Delfin', 'Delfon', 'Deltin']
    },
    {
      'image': 'assets/animales/elefante.jpg',
      'correctAnswer': 'Elefante',
      'options': ['Elefante', 'Elefente', 'Elefanpe']
    },
    {
      'image': 'assets/animales/jirafa.jpg',
      'correctAnswer': 'Jirafa',
      'options': ['Jirafa', 'Jirasa', 'Jiraga']
    },
    {
      'image': 'assets/animales/leon.jpg',
      'correctAnswer': 'Leon',
      'options': ['Leon', 'Lean', 'Leom']
    },
    {
      'image': 'assets/animales/mono.jpg',
      'correctAnswer': 'Mono',
      'options': ['Mono', 'Meno', 'Mino']
    },
    {
      'image': 'assets/animales/panda.jpg',
      'correctAnswer': 'Panda',
      'options': ['Panda', 'Ponda', 'Pando']
    },
    {
      'image': 'assets/animales/tigre.jpg',
      'correctAnswer': 'Tigre',
      'options': ['Tigre', 'Tigra', 'Tigre']
    },
  ];
  int _currentIndex = 0;
  bool _showResult = false;
  bool _isCorrect = false;

  void _checkAnswer(String answer) {
    setState(() {
      _isCorrect = answer == _animalData[_currentIndex]['correctAnswer'];
      _showResult = true;
    });
  }

  void _nextAnimal() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _animalData.length;
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conecta y Aprende', style: TextStyle(fontFamily: 'Cocogoose')),
        backgroundColor: Colors.blue,
      ),
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
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '¿Cuál es el nombre del animal?',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Cocogoose',
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: _animalData[_currentIndex]['options'].map<Widget>((option) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15.0), backgroundColor: Colors.lightBlueAccent,
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
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (_showResult)
                      Column(
                        children: [
                          SizedBox(height: 20.0),
                          Text(
                            _isCorrect ? '¡Correcto!' : 'Incorrecto. Inténtalo de nuevo.',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'Cocogoose',
                              color: _isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: _nextAnimal,
                            child: Text('Siguiente'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Cocogoose',
                              ),
                            ),
                          ),
                        ],
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
