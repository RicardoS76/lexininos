import 'dart:ui';
import 'package:flutter/material.dart';

class DetailedEvaluationPage extends StatefulWidget {
  final int totalTime;
  final int completedTests;

  DetailedEvaluationPage({required this.totalTime, required this.completedTests});

  @override
  _DetailedEvaluationPageState createState() => _DetailedEvaluationPageState();
}

class _DetailedEvaluationPageState extends State<DetailedEvaluationPage> {
  bool showBlurEffect = false;

  String getEvaluation() {
    if (widget.completedTests < 4) {
      return 'Faltan pruebas por realizar.';
    }

    if (widget.totalTime < 240) {
      return 'Dislexia Leve';
    } else if (widget.totalTime < 300) {
      return 'Dislexia Moderada';
    } else if (widget.totalTime < 420) {
      return 'Dislexia Severa';
    } else {
      return 'Dislexia Profunda';
    }
  }

  Color getEvaluationColor() {
    if (widget.completedTests < 4) {
      return Colors.red;
    }

    if (widget.totalTime < 240) {
      return Colors.green;
    } else if (widget.totalTime < 300) {
      return Colors.yellow;
    } else if (widget.totalTime < 420) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getEvaluationMessage() {
    if (widget.completedTests < 4) {
      return 'Faltan pruebas por realizar.';
    }

    if (widget.totalTime < 240) {
      return 'Dificultades menores con la lectura y la escritura. '
          'Errores ocasionales en la ortografía. '
          'Lectura más lenta de lo normal, pero generalmente comprensible. '
          'Capacidad para compensar las dificultades con estrategias de aprendizaje.';
    } else if (widget.totalTime < 300) {
      return 'Problemas más consistentes con la lectura y la escritura. '
          'Errores frecuentes en la ortografía y la gramática. '
          'Lectura significativamente más lenta que la media. '
          'Necesidad de apoyo educativo y estrategias de aprendizaje específicas para manejar el trastorno.';
    } else if (widget.totalTime < 420) {
      return 'Dificultades graves con la lectura y la escritura. '
          'Errores constantes en la ortografía y la gramática. '
          'Lectura extremadamente lenta y con poca comprensión. '
          'Dependencia de ayudas tecnológicas y educativas intensivas. '
          'Problemas con otras habilidades del lenguaje, como la fluidez y la comprensión oral.';
    } else {
      return 'Incapacidad casi total para leer y escribir de manera funcional. '
          'Errores persistentes y graves en la ortografía y la gramática. '
          'Gran dificultad para comprender textos escritos. '
          'Requiere apoyo educativo y tecnológico muy intensivo. '
          'Afecta significativamente otras áreas del aprendizaje y el desarrollo personal.';
    }
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '$minutes minutos y $seconds segundos';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWarningDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final evaluation = getEvaluation();
    final evaluationColor = getEvaluationColor();
    final evaluationMessage = getEvaluationMessage();
    final formattedTime = formatTime(widget.totalTime);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.teal.shade700),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'PRE-DIAGNÓSTICO',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade700,
                              fontFamily: 'Arial',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                  SizedBox(height: 200), // Aumenta el espacio superior
                  Center(
                    child: Card(
                      color: Colors.teal.shade50,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Resultado de Evaluación',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade700,
                                fontFamily: 'Arial',
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              evaluation,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: evaluationColor,
                                fontFamily: 'Arial',
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              evaluationMessage,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: widget.completedTests < 4 ? Colors.red : Colors.black,
                                fontFamily: 'Arial',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.completedTests >= 4) ...[
                    SizedBox(height: 20),
                    ExpansionTile(
                      title: Text(
                        'Ver Tiempo Total',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Tiempo Total: $formattedTime',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 122, 213, 148),
                        textStyle: TextStyle(fontSize: 18),
                        minimumSize: Size(140, 60), // Hacer el botón más corto y alto
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Volver al Menú'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showBlurEffect)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showWarningDialog(BuildContext context) {
    setState(() {
      showBlurEffect = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Center(
            child: Text(
              'IMPORTANTE',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontFamily: 'Arial',
              ),
            ),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: SingleChildScrollView(
              child: Text(
                'El resultado del desempeño mostrado a continuación es un pre-diagnóstico realizado con un sistema de ponderación basado en diferentes pruebas de diagnóstico de la dislexia. Para una mayor certeza, acuda a un especialista en tratar la dislexia o un centro especializado los cuales podrá ubicar en el apartado de ayuda especializada en la opción usuarios.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Continuar',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                    },
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(150, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Regresar',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                      Navigator.of(context).pop(); // Regresa a la página anterior
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).then((_) {
      if (mounted) {
        setState(() {
          showBlurEffect = false;
        });
      }
    });
  }
}
