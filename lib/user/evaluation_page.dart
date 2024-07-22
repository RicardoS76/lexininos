import 'package:flutter/material.dart';

class DetailedEvaluationPage extends StatelessWidget {
  final int totalTime;
  final int completedTests;

  DetailedEvaluationPage({required this.totalTime, required this.completedTests});

  String getEvaluation() {
    if (completedTests < 4) {
      return 'Faltan pruebas por realizar.';
    }

    if (totalTime < 240) {
      return 'Leve';
    } else if (totalTime < 300) {
      return 'Moderada';
    } else if (totalTime < 420) {
      return 'Severa';
    } else {
      return 'Profunda';
    }
  }

  String getEvaluationMessage() {
    if (completedTests < 4) {
      return 'Faltan pruebas por realizar.';
    }

    if (totalTime < 240) {
      return 'Dificultades menores con la lectura y la escritura. '
          'Errores ocasionales en la ortografía. '
          'Lectura más lenta de lo normal, pero generalmente comprensible. '
          'Capacidad para compensar las dificultades con estrategias de aprendizaje.';
    } else if (totalTime < 300) {
      return 'Problemas más consistentes con la lectura y la escritura. '
          'Errores frecuentes en la ortografía y la gramática. '
          'Lectura significativamente más lenta que la media. '
          'Necesidad de apoyo educativo y estrategias de aprendizaje específicas para manejar el trastorno.';
    } else if (totalTime < 420) {
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
  Widget build(BuildContext context) {
    final evaluation = getEvaluation();
    final evaluationMessage = getEvaluationMessage();
    final formattedTime = formatTime(totalTime);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWarningDialog(context);
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PRE-DIAGNÓSTICO',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                  fontFamily: 'Arial',
                ),
              ),
              SizedBox(height: 20),
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
                  color: completedTests < 4 ? Colors.red : Colors.black,
                  fontFamily: 'Arial',
                ),
              ),
              SizedBox(height: 20),
              Text(
                evaluationMessage,
                style: TextStyle(
                  fontSize: 18.0,
                  color: completedTests < 4 ? Colors.red : Colors.black,
                  fontFamily: 'Arial',
                ),
                textAlign: TextAlign.center,
              ),
              if (completedTests >= 4) ...[
                SizedBox(height: 20),
                Text(
                  'Tiempo Total: $formattedTime',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 18),
                  minimumSize: Size(200, 50), // Hacer el botón más grande
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Volver al Menú'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita que se pueda cerrar el diálogo haciendo clic fuera de él
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
                      Navigator.pop(context); // Cierra el diálogo y continúa
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
                      Navigator.pop(context);
                      Navigator.pop(context); // Cierra el diálogo y regresa al menú
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
