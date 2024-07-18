import 'package:flutter/material.dart';

import 'baseDatos/database_helper.dart';
import 'main_page.dart';
import 'user/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _obscureText = true;
  String _errorMessage = '';

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
                  Image.asset('assets/logo.png', height: 200.0),
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
                        TextSpan(
                            text: 'L',
                            style: TextStyle(
                                color: Color(0xFFF7941E),
                                shadows: _createShadows())),
                        TextSpan(
                            text: 'E',
                            style: TextStyle(
                                color: Color(0xFF19B5FE),
                                shadows: _createShadows())),
                        TextSpan(
                            text: 'X',
                            style: TextStyle(
                                color: Color(0xFF34C759),
                                shadows: _createShadows())),
                        TextSpan(
                            text: 'I',
                            style: TextStyle(
                                color: Color(0xFFFF3B30),
                                shadows: _createShadows())),
                        TextSpan(
                            text: 'N',
                            style: TextStyle(
                                color: Color(0xFF5856D6),
                                shadows: _createShadows())),
                        TextSpan(
                            text: 'I',
                            style: TextStyle(
                                color: Color(0xFFFFCC00),
                                shadows: _createShadows())),
                        TextSpan(
                            text: 'Ñ',
                            style: TextStyle(
                                color: Color(0xFF5AC8FA),
                                shadows: _createShadows())),
                        TextSpan(
                            text: 'O',
                            style: TextStyle(
                                color: Color(0xFF34C759),
                                shadows: _createShadows())),
                        TextSpan(
                            text: 'S',
                            style: TextStyle(
                                color: Color(0xFFF7941E),
                                shadows: _createShadows())),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _usernameController,
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
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/reset_password');
                      },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic>? user =
                          await _dbHelper.getUser(_usernameController.text);
                      if (user != null &&
                          user['contrasena_hash'] == _passwordController.text) {
                        // Guardar las credenciales
                        await SharedPreferencesHelper.saveUserCredentials(
                            _usernameController.text,
                            _passwordController.text,
                            user['nombre']);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(
                              authenticatedUserPassword:
                                  _passwordController.text,
                              name: user['nombre'],
                            ),
                          ),
                        );

                        print('Inicio de sesión exitoso. Datos: $user');
                      } else {
                        setState(() {
                          _errorMessage =
                              'Nombre de usuario o contraseña incorrectos';
                          _usernameController.clear();
                          _passwordController.clear();
                        });
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            _errorMessage = '';
                          });
                        });
                        print('Error de inicio de sesión');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('Iniciar Sesión'),
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      '¿No tienes cuenta?, Registrate aqui!',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
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
