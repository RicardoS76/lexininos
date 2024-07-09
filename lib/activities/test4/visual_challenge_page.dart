import 'package:flutter/material.dart';

class VisualChallengePage extends StatefulWidget {
  @override
  _VisualChallengePageState createState() => _VisualChallengePageState();
}

class _VisualChallengePageState extends State<VisualChallengePage> {
  final List<Map<String, dynamic>> tests = [
    {
      'questionImage': 'assets/test4/test1.png',
      'options': [
        'assets/test4/correcta.png',
        'assets/test4/opcion1.png',
        'assets/test4/opcion3.png',
        'assets/test4/opcion4.png',
      ],
      'correctAnswer': 'assets/test4/correcta.png',
    },
    {
      'questionImage': 'assets/test4/test2.png',
      'options': [
        'assets/test4/op1.png',
        'assets/test4/correcto1.png',
        'assets/test4/op3.png',
        'assets/test4/op2.png',
      ],
      'correctAnswer': 'assets/test4/correcto1.png',
    },
    {
      'questionImage': 'assets/test4/test3.png',
      'options': [
        'assets/test4/correcto2.png',
        'assets/test4/opc1.png',
        'assets/test4/opc3.png',
        'assets/test4/opc2.png',
      ],
      'correctAnswer': 'assets/test4/correcto2.png',
    },
    {
      'questionImage': 'assets/test4/test4.png',
      'options': [
        'assets/test4/opci1.png',
        'assets/test4/opci2.png',
        'assets/test4/correcto3.png',
        'assets/test4/opci3.png',
      ],
      'correctAnswer': 'assets/test4/correcto3.png',
    },
    {
      'questionImage': 'assets/test4/test5.png',
      'options': [
        'assets/test4/opcio2.png',
        'assets/test4/opcio3.png',
        'assets/test4/opcio1.png',
        'assets/test4/correcto4.png',
      ],
      'correctAnswer': 'assets/test4/correcto4.png',
    },
  ];

  int currentTestIndex = 0;
  bool showInstructions = true;
  bool _isCorrect = false;
  String _selectedOption = '';

  void checkAnswer(String selectedImage) {
    setState(() {
      _isCorrect = selectedImage == tests[currentTestIndex]['correctAnswer'];
      _selectedOption = selectedImage;
      if (_isCorrect) {
        _showFeedbackDialog();
      } else {
        _showIncorrectNotification();
      }
    });
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            '¡Correcto!',
            style: TextStyle(
              fontFamily: 'Cocogoose',
              fontSize: 24,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  'Has seleccionado la respuesta correcta.',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
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
                    decoration: TextDecoration.none,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (currentTestIndex < tests.length - 1) {
                      currentTestIndex++;
                    } else {
                      _showCompletionDialog();
                    }
                    showInstructions = false;
                    _selectedOption = '';
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showIncorrectNotification() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            '¡Incorrecto!',
            style: TextStyle(
              fontFamily: 'Cocogoose',
              fontSize: 24,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  'Inténtalo de nuevo.',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
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
                  decoration: TextDecoration.none,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _selectedOption = '';
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            '¡Felicidades!',
            style: TextStyle(
              fontFamily: 'Cocogoose',
              fontSize: 24,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  'Has completado todas las pruebas.',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
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
                  'Finalizar',
                  style: TextStyle(
                    fontFamily: 'Cocogoose',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    showInstructions = true;
                    currentTestIndex = 0;
                    _selectedOption = '';
                  });
                },
              ),
            ),
          ),
        ],
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

  void startGame() {
    setState(() {
      showInstructions = false;
    });
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
              'Selecciona la imagen que corresponde a la pregunta mostrada. ¡Vamos a jugar!',
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

  Color _getButtonColor(String option) {
    if (!_isCorrect && option == _selectedOption) {
      return Colors.red;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final currentTest = tests[currentTestIndex];
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
                      Flexible(
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
                                  text: 'D',
                                  style: TextStyle(
                                      color: Colors.red,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'e',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 's',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'a',
                                  style: TextStyle(
                                      color: Colors.green,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'f',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'í',
                                  style: TextStyle(
                                      color: Colors.purple,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'o ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'V',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'i',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 's',
                                  style: TextStyle(
                                      color: Colors.green,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'u',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'a',
                                  style: TextStyle(
                                      color: Colors.purple,
                                      shadows: _createShadows())),
                              TextSpan(
                                  text: 'l',
                                  style: TextStyle(
                                      color: Colors.red,
                                      shadows: _createShadows())),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 36.0), // Placeholder to balance the Row
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Selecciona la imagen correcta:',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(currentTest['questionImage']),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: currentTest['options'].length,
                    itemBuilder: (context, index) {
                      double imageSize = (currentTestIndex == 2)
                          ? 80.0
                          : 100.0; // Adjust the size of the images for test3
                      return GestureDetector(
                        onTap: () {
                          checkAnswer(currentTest['options'][index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              currentTest['options'][index],
                              fit: BoxFit.cover,
                              width: imageSize,
                              height: imageSize,
                            ),
                          ),
                        ),
                      );
                    },
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
