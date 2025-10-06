// Importación del paquete de navegación curva
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/add_page.dart';
import 'package:flutter_application_1/presentation/pages/chat_page.dart';
import 'package:flutter_application_1/presentation/pages/people_page.dart';
import 'package:flutter_application_1/presentation/pages/profile_page.dart';
import 'package:flutter_application_1/presentation/pages/search_page.dart';
// Importación de todas las páginas que mostrará la navegación

// HomeScreen es StatefulWidget porque necesita manejar el estado del índice seleccionado
class HomeScreen extends StatefulWidget {
  final Widget? child; // Widget hijo para mostrar en el cuerpo

  const HomeScreen({super.key, this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista de iconos que aparecerán en la barra de navegación
  // const para optimización - estos valores no cambian
  final items = const [
    Icon(Icons.people, size: 30), // Índice 0 - Página de People
    Icon(Icons.person, size: 30), // Índice 1 - Página de Profile
    Icon(Icons.add, size: 30), // Índice 2 - Página de Add
    Icon(Icons.search_outlined, size: 30), // Índice 3 - Página de Search
    Icon(Icons.chat, size: 30), // Índice 4 - Página de Chat
  ];

  // Variable que mantiene el índice de la página actualmente seleccionada
  // Iniciamos en índice 0 (People Page) para coincidir con GoRouter
  int index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Actualizar el índice basado en la ruta actual
    _updateIndexFromRoute();
  }

  void _updateIndexFromRoute() {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();
    switch (location) {
      case '/home':
        index = 0;
        break;
      case '/':
        index = 1;
        break;
      case '/add':
        index = 2;
        break;
      case '/search':
        index = 3;
        break;
      case '/chat':
        index = 4;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: Estructura básica de una pantalla en Material Design
    return Scaffold(
      backgroundColor: Colors.blue, // Color de fondo de toda la pantalla
      // AppBar: Barra superior de la aplicación
      appBar: AppBar(
        title: const Text('Curved Navigation Bar'),
        backgroundColor: Colors.blue[300], // Color de fondo más claro
        foregroundColor: Colors.white, // Color del texto
      ),

      // CurvedNavigationBar: Widget principal de navegación curva
      bottomNavigationBar: CurvedNavigationBar(
        items: items, // Los iconos definidos arriba
        index: index, // Índice actualmente seleccionado
        onTap: (selectedIndex) {
          // Función que se ejecuta al tocar un icono
          setState(() {
            // setState actualiza la UI cuando cambia el estado
            index = selectedIndex; // Cambiamos a la nueva página seleccionada
          });

          // Navegación usando GoRouter
          switch (selectedIndex) {
            case 0:
              context.go('/people');
              break;
            case 1:
              context.go('/profile');
              break;
            case 2:
              context.go('/add');
              break;
            case 3:
              context.go('/search');
              break;
            case 4:
              context.go('/chat');
              break;
          }
        },
        height: 70, // Altura de la barra de navegación
        backgroundColor: Colors
            .transparent, // Fondo transparente para mostrar el color del Scaffold
        animationDuration: const Duration(
          milliseconds: 300,
        ), // Duración de la animación entre cambios
      ),

      // Cuerpo principal de la pantalla
      body: Container(
        color: Colors.blue, // Color de fondo
        width: double.infinity, // Ancho completo de la pantalla
        height: double.infinity, // Alto completo de la pantalla
        alignment: Alignment.center, // Centra el contenido
        child:
            widget.child ??
            getSelectedWidget(
              index: index,
            ), // Muestra el child de GoRouter o la página correspondiente al índice
      ),
    );
  }

  // Método que determina qué página mostrar según el índice seleccionado
  // Este método ahora es de respaldo cuando no se usa GoRouter
  Widget getSelectedWidget({required int index}) {
    Widget widget; // Variable que contendrá la página a mostrar

    // Switch statement: evalúa el índice y retorna la página correspondiente
    switch (index) {
      case 0: // Si el índice es 0
        widget = const PeoplePage(); // Muestra la página de People
        break;
      case 1: // Si el índice es 1
        widget = const ProfilePage(); // Muestra la página de Profile
        break;
      case 2: // Si el índice es 2
        widget = const AddPage(); // Muestra la página de Add
        break;
      case 3: // Si el índice es 3
        widget = const SearchPage(); // Muestra la página de Search
        break;
      case 4: // Si el índice es 4
        widget = const ChatPage(); // Muestra la página de Chat
        break;
      default: // Caso por defecto (si algo sale mal)
        widget = const PeoplePage(); // Muestra People como página segura
        break;
    }
    return widget; // Retorna la página seleccionada
  }
}
