import 'package:flutter/material.dart';

class TepexiDeRodriguezPage extends StatefulWidget {
  @override
  _TepexiDeRodriguezPageState createState() => _TepexiDeRodriguezPageState();
}

class _TepexiDeRodriguezPageState extends State<TepexiDeRodriguezPage> {
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'UBR DE Tepexi de Rodríguez',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
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
Nombre de Vialidad: Avenida Tecnológico
Número Exterior e Interior: 15
Nombre del Asentamiento: San Sebastián
Código Postal: 74690
''',
                      context,
                      isExpanded1,
                      () {
                        setState(() {
                          isExpanded1 = !isExpanded1;
                        });
                      },
                    ),
                    _buildInfoRow('Correo Electrónico UBR', 'Sin correo', context, isCustomFont: true),
                    _buildInfoRow('Teléfono UBR', 'Sin teléfono', context, isCustomFont: true),
                    _buildExpandableInfoRow(
                      'Horario de Servicio',
                      '''
Matutino (lunes a viernes): 9:00 AM a 14:00 HRS
Vespertino (lunes a viernes): 0
Sabatino: 9:00 AM a 12:00 HRS
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
Nombre: LTFR. Karen Rojas Zapata
Cargo: Responsable de UBR
Correo Electrónico: krn.r17@hotmail.com
Teléfono Móvil: 2381787953
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
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$title: ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontFamily: 'Cocogoose',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontFamily: isCustomFont ? 'Arial' : 'Cocogoose',
                      fontWeight: FontWeight.normal,
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
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
                      style: TextStyle(color: Colors.purple),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.purple,
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
                fontSize: 16.0,
                color: Colors.purple.shade700,
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
          Expanded(
            child: Text(
              'Imagen de referencia',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
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
                  style: TextStyle(color: Colors.purple),
                ),
                Icon(
                  Icons.image,
                  color: Colors.purple,
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
                    child: Image.asset('assets/UBR4.jpg'),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.purple),
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
