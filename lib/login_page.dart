import 'package:flutter/material.dart';
import 'dart:ui';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 200.0), // Asegúrate de que el logo esté en assets
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 50.0,
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
                        TextSpan(text: 'L', style: TextStyle(color: Color(0xFFF7941E), shadows: _createShadows())),
                        TextSpan(text: 'E', style: TextStyle(color: Color(0xFF19B5FE), shadows: _createShadows())),
                        TextSpan(text: 'X', style: TextStyle(color: Color(0xFF34C759), shadows: _createShadows())),
                        TextSpan(text: 'I', style: TextStyle(color: Color(0xFFFF3B30), shadows: _createShadows())),
                        TextSpan(text: 'N', style: TextStyle(color: Color(0xFF5856D6), shadows: _createShadows())),
                        TextSpan(text: 'I', style: TextStyle(color: Color(0xFFFFCC00), shadows: _createShadows())),
                        TextSpan(text: 'Ñ', style: TextStyle(color: Color(0xFF5AC8FA), shadows: _createShadows())),
                        TextSpan(text: 'O', style: TextStyle(color: Color(0xFF34C759), shadows: _createShadows())),
                        TextSpan(text: 'S', style: TextStyle(color: Color(0xFFF7941E), shadows: _createShadows())),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Nombre de usuario',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Icon(Icons.visibility_off),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/main');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade100,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('Iniciar Sesión'),
                  ),
                ],
              ),
            ),
          ),
        ),
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
}
