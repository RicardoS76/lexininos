import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de Privacidad'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Introducción',
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600 ? 18.0 : 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Bienvenido a nuestra aplicación de pre-diagnóstico de dislexia para niños de 1° y 2° grado de primaria. Valoramos tu privacidad y nos comprometemos a proteger tus datos personales. Esta política de privacidad describe cómo manejamos la información que recopilamos y las medidas que tomamos para proteger tu privacidad.',
                      style: TextStyle(fontSize: constraints.maxWidth < 600 ? 14.0 : 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Recopilación de Información',
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600 ? 18.0 : 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Nuestra aplicación no recopila datos personales identificables de los usuarios. La información de inicio de sesión se almacena de forma local en tu dispositivo utilizando una base de datos SQLite y no se transfiere a servidores externos.',
                      style: TextStyle(fontSize: constraints.maxWidth < 600 ? 14.0 : 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Uso de la Información',
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600 ? 18.0 : 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'La información almacenada en tu dispositivo se utiliza únicamente para facilitar el acceso a la aplicación y mejorar tu experiencia de usuario. No accedemos ni utilizamos esta información para ningún otro propósito.',
                      style: TextStyle(fontSize: constraints.maxWidth < 600 ? 14.0 : 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Seguridad de la Información',
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600 ? 18.0 : 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Implementamos medidas de seguridad técnicas y organizativas para proteger la información almacenada en tu dispositivo contra el acceso no autorizado, la pérdida o la alteración. Sin embargo, la seguridad completa no puede ser garantizada.',
                      style: TextStyle(fontSize: constraints.maxWidth < 600 ? 14.0 : 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Consentimiento',
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600 ? 18.0 : 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Al utilizar nuestra aplicación, aceptas esta política de privacidad. Si no estás de acuerdo con los términos descritos, te pedimos que no utilices la aplicación.',
                      style: TextStyle(fontSize: constraints.maxWidth < 600 ? 14.0 : 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Cambios en la Política de Privacidad',
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600 ? 18.0 : 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Nos reservamos el derecho de actualizar esta política de privacidad en cualquier momento. Te notificaremos cualquier cambio a través de la aplicación. Te recomendamos revisar periódicamente esta política para estar informado sobre cómo protegemos tu información.',
                      style: TextStyle(fontSize: constraints.maxWidth < 600 ? 14.0 : 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Contacto',
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600 ? 18.0 : 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Si tienes alguna pregunta o inquietud sobre esta política de privacidad, no dudes en contactarnos a través de lexiayuda@gmail.com.',
                      style: TextStyle(fontSize: constraints.maxWidth < 600 ? 14.0 : 16.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
