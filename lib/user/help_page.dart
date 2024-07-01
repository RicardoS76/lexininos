import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de colores pasteles
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Encabezado con icono de ayuda y título
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.help, color: Colors.purple, size: 40.0),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Ayuda Especializada',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                            fontFamily: 'Cocogoose',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Descripción sobre la dislexia
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'La dislexia es una dificultad de aprendizaje de la lectura que afecta la decodificación, el reconocimiento de palabras y la ortografía. Es importante buscar la ayuda de profesionales para proporcionar el apoyo adecuado y estrategias personalizadas que ayuden a los niños a superar estos desafíos y a alcanzar su máximo potencial académico y personal.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.purple.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Secciones de ayuda
                  Expanded(
                    child: ListView(
                      children: [
                        _buildInfoTile('UBR DE Atoyatempan', Icons.location_on, context, route: '/atoyatempan'),
                        _buildInfoTile('UBR DE Tochtepec', Icons.location_on, context, route: '/tochtepec'),
                        _buildInfoTile('UBR DE Molcaxac', Icons.location_on, context, route: '/molcaxac'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, IconData icon, BuildContext context, {String? route}) {
    return GestureDetector(
      onTap: route != null
          ? () {
              Navigator.pushNamed(context, route);
            }
          : null,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.purple, size: 30.0),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontFamily: 'Cocogoose',
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.purple, size: 20.0),
          ],
        ),
      ),
    );
  }
}
