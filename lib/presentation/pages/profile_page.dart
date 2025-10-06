// Importación de Material Design para Flutter
import 'package:flutter/material.dart';

// ProfilePage: Página que muestra el perfil del usuario
// StatelessWidget porque el contenido es estático
class ProfilePage extends StatelessWidget {
  // Constructor con super.key (sintaxis moderna Flutter 2025)
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Estructura idéntica a PeoplePage pero con contenido de perfil
    return const Padding(
      padding: EdgeInsets.all(24.0), // Padding consistente en todas las páginas

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
        children: [
          // Título de la página de perfil
          Text(
            'Profile Page',
            style: TextStyle(
              fontSize: 40, // Tamaño consistente con otras páginas
              color: Colors.white, // Color que contrasta con el fondo azul
              fontWeight: FontWeight.bold, // Énfasis en negrita
            ),
          ),

          SizedBox(height: 100), // Espaciado consistente
          // Avatar circular con icono de persona
          CircleAvatar(
            radius: 70, // Mismo tamaño que otras páginas
            child: Icon(
              Icons.person,
              size: 120,
            ), // Icono específico para perfil
          ),

          SizedBox(height: 100), // Espaciado inferior
          // Contenido descriptivo
          Text(
            'Profile Page Content',
            style: TextStyle(
              fontSize: 30, // Tamaño de fuente consistente
              color: Colors.white, // Color consistente
            ),
          ),
        ],
      ),
    );
  }
}
