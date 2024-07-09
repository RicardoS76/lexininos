import 'package:flutter/material.dart';
import 'user/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                  // Encabezado con icono de configuración y título
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings, color: Colors.deepPurple, size: 40.0),
                      SizedBox(width: 10),
                      Text(
                        'Ajustes',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontFamily: 'Cocogoose',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Secciones de configuración
                  Expanded(
                    child: ListView(
                      children: [
                        _buildInfoTile('Seguridad', Icons.security, context, route: '/manage_accounts', color: Colors.blue),
                        _buildInfoTile('Ayuda y soporte', Icons.contact_support, context, route: '/contacts', color: Colors.green),
                        _buildInfoTile('Cerrar sesión', Icons.logout, context, onTap: _logout, color: Colors.red),
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

  void _logout() async {
    await SharedPreferencesHelper.clearUserCredentials();
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _buildInfoTile(String title, IconData icon, BuildContext context, {String? route, Function()? onTap, required Color color}) {
    return GestureDetector(
      onTap: onTap ?? () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
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
            Icon(icon, color: color, size: 30.0),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'Cocogoose',
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 20.0),
          ],
        ),
      ),
    );
  }
}
