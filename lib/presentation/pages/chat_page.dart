// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ChatPage: Página que permite navegar al chat de Yes/No original
// Esta página actúa como puente entre la navegación curva y tu aplicación original
class ChatPage extends StatelessWidget {
  // Constructor con super.key (Flutter 2025)
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Estructura similar a otras páginas pero con funcionalidad adicional
    return Padding(
      padding: const EdgeInsets.all(24.0), // Padding consistente

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
        children: [
          // Título de la página de chat
          const Text(
            'Chat Page',
            style: TextStyle(
              fontSize: 40, // Tamaño consistente con otras páginas
              color: Colors.white, // Color para contraste
              fontWeight: FontWeight.bold, // Énfasis en el título
            ),
          ),

          const SizedBox(
            height: 50,
          ), // Espaciado más pequeño para acomodar el botón
          // Avatar con icono de chat
          const CircleAvatar(
            radius: 70, // Tamaño estándar
            child: Icon(Icons.chat, size: 120), // Icono de chat/conversación
          ),

          const SizedBox(height: 50), // Espacio antes del botón
          // ElevatedButton: Botón elevado que navega al chat original
          ElevatedButton(
            onPressed: () {
              // Usar GoRouter para navegar al chat screen
              context.go('/chat-screen');
            },
            // Estilizado del botón
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 30, // Padding horizontal
                vertical: 15, // Padding vertical
              ),
            ),
            // Texto del botón
            child: const Text(
              'Go to Yes/No Chat', // Texto descriptivo del botón
              style: TextStyle(fontSize: 18), // Tamaño de fuente legible
            ),
          ),
        ],
      ),
    );
  }
}
