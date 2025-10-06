// Importación de Material Design para Flutter
import 'package:flutter/material.dart';

// PrincipalPage: Página que muestra contenido relacionado con "People"
// StatelessWidget porque no necesita manejar estado interno
class PrincipalPage extends StatelessWidget {
  // Constructor con super.key (sintaxis moderna Flutter 2025)
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Padding: Añade espacio alrededor del contenido (24 píxeles en todos los lados)
    return const Padding(
      padding: EdgeInsets.all(24.0),

      // Column: Organiza los elementos verticalmente
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centra los elementos verticalmente
        children: [
          // Título principal de la página
          Text(
            'People Page',
            style: TextStyle(
              fontSize: 40, // Tamaño grande para el título
              color:
                  Colors.white, // Color blanco para contrastar con fondo azul
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),

          // Espacio vertical de 100 píxeles
          SizedBox(height: 100),

          // CircleAvatar: Crea un círculo con icono
          CircleAvatar(
            radius: 70, // Radio del círculo (140 píxeles de diámetro)
            child: Icon(
              Icons.people,
              size: 120,
            ), // Icono de personas, tamaño 120
          ),

          // Otro espacio vertical
          SizedBox(height: 100),

          // Texto descriptivo de la página
          Text(
            'People Page Content',
            style: TextStyle(
              fontSize: 30, // Tamaño mediano
              color: Colors.white, // Color blanco
            ),
          ),
        ],
      ),
    );
  }
}
