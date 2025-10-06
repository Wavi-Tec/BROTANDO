// Importación de Material Design para Flutter
import 'package:flutter/material.dart';

// AddPage: Página para funcionalidades de "añadir" contenido
// StatelessWidget porque no maneja estado local
class AddPage extends StatelessWidget {
  // Constructor con super.key (Flutter 2025)
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mantiene la misma estructura de diseño que las otras páginas
    // Esto asegura consistencia en la experiencia de usuario
    return const Padding(
      padding: EdgeInsets.all(24.0), // Padding estándar para todas las páginas

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido
        children: [
          // Título específico para la funcionalidad de "Add"
          Text(
            'Add Page',
            style: TextStyle(
              fontSize: 40, // Tamaño grande para títulos
              color: Colors.white, // Contraste con fondo azul
              fontWeight: FontWeight.bold, // Peso de fuente para énfasis
            ),
          ),

          SizedBox(height: 100), // Separación vertical estándar
          // Avatar con icono de "añadir" (símbolo +)
          CircleAvatar(
            radius: 70, // Radio consistente con otras páginas
            child: Icon(Icons.add, size: 120), // Icono de "+" para añadir
          ),

          SizedBox(height: 100), // Separación inferior
          // Texto descriptivo para esta página
          Text(
            'Add Page Content',
            style: TextStyle(
              fontSize: 30, // Tamaño de fuente para contenido
              color: Colors.white, // Color consistente
            ),
          ),
        ],
      ),
    );
  }
}
