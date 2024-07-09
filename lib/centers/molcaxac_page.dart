import 'package:flutter/material.dart';

class MolcaxacPage extends StatefulWidget {
  @override
  _MolcaxacPageState createState() => _MolcaxacPageState();
}

class _MolcaxacPageState extends State<MolcaxacPage> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;

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
                        'UBR DE Molcaxac',
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
                    _buildInfoRow('Tipo de Unidad', 'UBR (Unidad Básica de Rehabilitación)', context),
                    _buildExpandableInfoRow(
                      'Domicilio',
                      '''
Tipo de Vialidad: Avenida
Nombre de Vialidad: Avenida 16 de Septiembre
Número Exterior e Interior: 5 Sur
Nombre del Asentamiento: Barrio San Jose
Código Postal: 75650
''',
                      context,
                      isExpanded1,
                      () {
                        setState(() {
                          isExpanded1 = !isExpanded1;
                        });
                      },
                    ),
                    _buildInfoRow('Correo Electrónico UBR', 'karensvl_31@hotmail.com', context, isCustomFont: true),
                    _buildInfoRow('Teléfono UBR', '2241042261', context, isCustomFont: true),
                    _buildExpandableInfoRow(
                      'Horario de Servicio',
                      '''
Matutino (lunes a viernes): 9:00 am - 12:00 pm
Vespertino (lunes a viernes): 1:00 pm - 4:00 pm
Sabatino: No se labora
''',
                      context,
                      isExpanded2,
                      () {
                        setState(() {
                          isExpanded2 = !isExpanded2;
                        });
                      },
                    ),
                    _buildExpandableInfoRow(
                      'Responsable de la UBR',
                      '''
Nombre: L.F.T Karen Santos Vidal
Cargo: Encargada
Correo Electrónico: karensvl_31@hotmail.com
Teléfono Móvil: 2241042261
''',
                      context,
                      isExpanded3,
                      () {
                        setState(() {
                          isExpanded3 = !isExpanded3;
                        });
                      },
                    ),
                    _buildImageReferenceRow(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, BuildContext context, {bool isCustomFont = false}) {
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
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$title: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                  fontFamily: 'Cocogoose',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontFamily: isCustomFont ? 'Arial' : 'Cocogoose',
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
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

  Widget _buildExpandableInfoRow(String title, String value, BuildContext context, bool isExpanded, VoidCallback onTap) {
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
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                    fontFamily: 'Cocogoose',
                  ),
                ),
              ),
              TextButton(
                onPressed: onTap,
                child: Row(
                  children: [
                    Text(
                      isExpanded ? 'Ver menos' : 'Ver más',
                      style: TextStyle(color: Colors.teal.shade700),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.teal.shade700,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isExpanded)
            Text(
              value,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
                fontFamily: 'Arial',
              ),
              textAlign: TextAlign.left,
            ),
        ],
      ),
    );
  }

  Widget _buildImageReferenceRow(BuildContext context) {
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Imagen de referencia',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
                fontFamily: 'Cocogoose',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _showImageDialog(context);
            },
            child: Row(
              children: [
                Text(
                  'Ver imagen',
                  style: TextStyle(color: Colors.teal.shade700),
                ),
                Icon(
                  Icons.image,
                  color: Colors.teal.shade700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(10.0),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: InteractiveViewer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Image.asset('assets/UBR3.jpg'),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.teal.shade700),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
