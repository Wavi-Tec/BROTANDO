import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class CurvedBottomNav extends StatefulWidget {
  const CurvedBottomNav({super.key});

  @override
  State<CurvedBottomNav> createState() => _CurvedBottomNavState();
}

class _CurvedBottomNavState extends State<CurvedBottomNav> {
  // Lista de iconos y rutas correspondientes
  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'route': '/inicio'},
    {'icon': Icons.confirmation_num, 'route': '/cupon'},
    {'icon': Icons.compost, 'route': '/bosque'},
    {'icon': Icons.assignment_turned_in, 'route': '/cuestionario'},
    {'icon': Icons.volunteer_activism, 'route': '/donacion'},
  ];

  int index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateIndexFromRoute();
  }

  void _updateIndexFromRoute() {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();

    // Buscar el índice basado en la ruta actual
    for (int i = 0; i < navItems.length; i++) {
      if (location == navItems[i]['route']) {
        if (mounted) {
          setState(() {
            index = i;
          });
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: navItems.map((item) => Icon(item['icon'], size: 30)).toList(),
      index: index,
      onTap: (selectedIndex) {
        if (selectedIndex != index) {
          setState(() {
            index = selectedIndex;
          });
          context.go(navItems[selectedIndex]['route']);
        }
      },
      height: 70,
      backgroundColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
