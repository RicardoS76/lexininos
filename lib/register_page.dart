import 'package:flutter/material.dart';

import 'baseDatos/database_helper.dart';
import 'privacy_policy_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isChecked = false;

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
              child: Form(
                key: _formKey,
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
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Nombre de usuario',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(
                          _formKey.currentState != null &&
                                  _formKey.currentState!.validate()
                              ? Icons.check_circle
                              : Icons.error,
                          color: _formKey.currentState != null &&
                                  _formKey.currentState!.validate()
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      autofillHints: [AutofillHints.username],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un nombre de usuario';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Nombre',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un nombre';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Correo electrónico',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(
                          _formKey.currentState != null &&
                                  _formKey.currentState!.validate()
                              ? Icons.check_circle
                              : Icons.error,
                          color: _formKey.currentState != null &&
                                  _formKey.currentState!.validate()
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      validator: validateEmail,
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
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
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: validatePassword,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                        PasswordStrengthBar(password: _passwordController.text),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Confirmar contraseña',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirma tu contraseña';
                        }
                        if (value != _passwordController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicyPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Acepto la Política de Privacidad',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _isChecked
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                bool usernameTaken = await _dbHelper
                                    .isUsernameTaken(_usernameController.text);
                                bool emailTaken = await _dbHelper
                                    .isEmailTaken(_emailController.text);

                                if (usernameTaken) {
                                  print('Nombre de usuario ya está en uso');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Nombre de usuario ya está en uso')),
                                  );
                                  return;
                                }

                                if (emailTaken) {
                                  print('Correo electrónico ya está en uso');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Correo electrónico ya está en uso')),
                                  );
                                  return;
                                }

                                Map<String, dynamic> row = {
                                  'nombre_usuario': _usernameController.text,
                                  'nombre': _nameController.text,
                                  'contrasena_hash': _passwordController.text, // Sin hashing de contraseña
                                  'correo_electronico': _emailController.text,
                                };
                                final id = await _dbHelper.insertUser(row);
                                print('Registro exitoso. ID: $id. Datos: $row');
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              } else {
                                print('Por favor llena todos los campos');
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade100,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('Registrarse'),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Ya tengo cuenta',
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa un correo electrónico';
    }
    String pattern =
        r'^[^@]+@[^@]+\.[^@]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa una contraseña';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra mayúscula';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra minúscula';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'La contraseña debe tener al menos un número';
    }
    return null;
  }
}

class PasswordStrengthBar extends StatelessWidget {
  final String password;
  PasswordStrengthBar({required this.password});

  int _calculateStrength(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    return strength;
  }

  @override
  Widget build(BuildContext context) {
    int strength = _calculateStrength(password);
    return LinearProgressIndicator(
      value: strength / 4,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(
        strength < 2 ? Colors.red : (strength < 3 ? Colors.yellow : Colors.green),
      ),
    );
  }
}
