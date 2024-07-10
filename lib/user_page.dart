import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
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
                  // Encabezado con icono de usuario y título
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.teal.shade700, size: 40.0),
                      SizedBox(width: 10),
                      Text(
                        'Usuario',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                          fontFamily: 'Cocogoose',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Secciones de información del usuario
                  Expanded(
                    child: ListView(
                      children: [
                        _buildInfoTile('Ayuda especializada', Icons.help_outline, context, route: '/help', textColor: Colors.purple),
                        _buildInfoTile('Información', Icons.info_outline, context, route: '/info', textColor: Colors.blue),
                        _buildInfoTile('Ver Resultados', Icons.assessment, context, route: '/results', textColor: Colors.green),
                        _buildInfoTile('Datos del Usuario', Icons.perm_identity, context, route: '/user_data', textColor: Colors.orange),
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

  Widget _buildInfoTile(String title, IconData icon, BuildContext context, {String? route, required Color textColor}) {
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
            Icon(icon, color: textColor, size: 30.0),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'Cocogoose',
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: textColor, size: 20.0),
          ],
        ),
      ),
    );
  }
}
