import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
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
                        'Acerca de Nosotros',
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
                      'Misión:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nuestra misión en Lexiniños es proporcionar herramientas educativas accesibles y efectivas para apoyar a niños con dificultades de aprendizaje, especialmente aquellos con dislexia. Nos comprometemos a crear un entorno de aprendizaje inclusivo y divertido, donde cada niño pueda desarrollar su máximo potencial. A través de tecnologías innovadoras y metodologías probadas, buscamos facilitar la detección temprana de dificultades de aprendizaje y ofrecer recursos que mejoren las habilidades cognitivas y académicas de los niños, preparando así un camino hacia su éxito educativo y personal.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Valores:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildValueTile('Inclusividad', 'Creemos en la educación para todos, sin importar las dificultades de aprendizaje. Nuestra aplicación está diseñada para ser accesible y útil para todos los niños.'),
                    _buildValueTile('Innovación', 'Nos esforzamos por utilizar las últimas tecnologías y enfoques pedagógicos para crear experiencias de aprendizaje atractivas y efectivas.'),
                    _buildValueTile('Empatía', 'Entendemos las dificultades que enfrentan los niños con dislexia y otras dificultades de aprendizaje. Trabajamos con compasión y dedicación para proporcionar el apoyo necesario.'),
                    _buildValueTile('Colaboración', 'Valoramos la colaboración con padres, educadores y especialistas para ofrecer soluciones que realmente marquen la diferencia en el aprendizaje de los niños.'),
                    _buildValueTile('Compromiso', 'Estamos comprometidos con el desarrollo continuo de nuestra aplicación para asegurar que siempre cumpla con las necesidades cambiantes de los niños y sus familias.'),
                    _buildValueTile('Calidad', 'Nos esforzamos por mantener altos estándares de calidad en todos nuestros productos y servicios, asegurando que sean fiables y efectivos.'),
                    SizedBox(height: 20),
                    Text(
                      'Contacto:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Para cualquier pregunta o soporte, por favor contáctanos a través del correo: lexiayuda@gmail.com.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
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

  Widget _buildValueTile(String title, String description) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
