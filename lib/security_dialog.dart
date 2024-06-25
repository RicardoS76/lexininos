import 'package:flutter/material.dart';

class SecurityDialog extends StatelessWidget {
  final Function onPasswordAccepted;
  final String title;

  SecurityDialog({required this.onPasswordAccepted, required this.title});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
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
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Para acceder a esta opción\npide ayuda a tu tutor',
                    style: TextStyle(fontSize: 26.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 10.0),
                Image.asset('assets/msg.png', height: 250.0),
              ],
            ),
            SizedBox(height: 20.0),
            Text('Ingrese su contraseña', style: TextStyle(fontSize: 20.0)),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Contraseña'),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Cancelar', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text('Aceptar', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPasswordAccepted();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
