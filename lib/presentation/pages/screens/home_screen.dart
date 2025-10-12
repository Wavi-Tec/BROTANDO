// Importación del paquete de navegación curva
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/curved_bottom_nav.dart';
import '../principal/widgets/user_header.dart';

// HomeScreen es StatelessWidget ahora que la lógica está en CurvedBottomNav
class HomeScreen extends StatelessWidget {
  final Widget? child; // Widget hijo para mostrar en el cuerpo

  const HomeScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    // Obtener la ruta actual
    final String currentLocation = GoRouterState.of(context).uri.toString();

    // Determinar si mostrar el AppBar
    final bool showAppBar =
        currentLocation != '/perfil' &&
        currentLocation != '/cupon' &&
        currentLocation != '/bosque';

    // Scaffold: Estructura básica de una pantalla en Material Design
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        //aAQUI SE CAMBIA EL FONDO DEL NAV
        255,
        245,
        245,
        245,
      ), // Color de fondo de toda la pantalla
      // AppBar: Barra superior de la aplicación (condicionalmente mostrada)
      appBar: showAppBar
          ? PreferredSize(
              preferredSize: const Size.fromHeight(300),
              child: Container(
                color: Colors.white,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        UserHeader(
                          userName: 'Maria Torrez',
                          userImage:
                              'https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/350218472/original/1cae06a7845aee5beafbf7fe6a623dc5caafbed9/draw-cute-minimalist-cartoon-avatar-or-icon-for-you.jpg',
                          onNotificationPressed: () {
                            // Manejar notificaciones
                          },
                          onUserImagePressed: () {
                            context.go('/perfil');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,

      // Usar el widget reutilizable CurvedBottomNav
      bottomNavigationBar: const CurvedBottomNav(),

      // Cuerpo principal de la pantalla
      body: Container(
        color: Colors.white10, // Color de fondo
        width: double.infinity, // Ancho completo de la pantalla
        height: double.infinity, // Alto completo de la pantalla
        alignment: Alignment.center, // Centra el contenido
        child:
            child ??
            const Center(
              child: Text(
                'Selecciona una opción en la barra de navegación',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ), // Muestra el child de GoRouter o un mensaje por defecto
      ),
    );
  }
}
