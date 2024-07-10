import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue.shade100,
                  Colors.lightGreen.shade100,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Información',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                          fontFamily: 'Cocogoose',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Lexiniños es una innovadora aplicación diseñada para apoyar a niños con dificultades de aprendizaje, especialmente aquellos con dislexia. Utilizando una combinación de tecnologías avanzadas y enfoques pedagógicos probados, Lexiniños ofrece una serie de actividades interactivas y juegos educativos que ayudan a mejorar las habilidades de lectura, escritura y comprensión. La aplicación cuenta con cuatro pruebas principales diseñadas para evaluar y mejorar diversas habilidades cognitivas y de aprendizaje: Rimas, Conecta y Aprende, Palabras Escondidas, y Desafío Visual: Figuras. Lexiniños proporciona un prediagnóstico y se recomienda consultar a un especialista para una evaluación completa.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    _buildInfoTile('Política de Privacidad', Icons.privacy_tip, context, route: '/privacy_policy'),
                    _buildInfoTile('Acerca de Nosotros', Icons.info, context, route: '/about_us'),
                  ],
                ),
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
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12.0),
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
            Icon(icon, color: Colors.teal.shade700, size: 30.0),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.teal.shade700, size: 20.0),
          ],
        ),
      ),
    );
  }
}
