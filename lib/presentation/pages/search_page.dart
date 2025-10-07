// Importación de Material Design para Flutter
import 'package:flutter/material.dart';

// SearchPage: Página dedicada a funcionalidades de búsqueda
// StatelessWidget para contenido estático
class SearchPage extends StatelessWidget {
  // Constructor con super.key (patrón moderno de Flutter 2025)
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Estructura de diseño consistente con el resto de páginas
    // Mantiene la misma jerarquía visual y espaciado
    return const Padding(
      padding: EdgeInsets.all(24.0), // Margen interno estándar

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Alineación central vertical
        children: [
          // Título de la página de búsqueda
          Text(
            'Search Page',
            style: TextStyle(
              fontSize: 40, // Tamaño prominente para el título
              color: Colors.white, // Color que resalta sobre fondo azul
              fontWeight: FontWeight.bold, // Grosor de fuente para destacar
            ),
          ),

          SizedBox(height: 100), // Espacio vertical uniforme
          // CircleAvatar con icono de búsqueda
          CircleAvatar(
            radius: 70, // Tamaño consistente con otras páginas
            child: Icon(Icons.search, size: 120), // Icono de lupa para búsqueda
          ),

          SizedBox(height: 100), // Espacio inferior
          // Contenido descriptivo de la página
          Text(
            'Search Page Content',
            style: TextStyle(
              fontSize: 30, // Tamaño de fuente para texto secundario
              color: Colors.white, // Color uniforme en toda la app
            ),
          ),
        ],
      ),
    );
  }
}
