import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.greenPrimary,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.forest), label: "Bosque"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Retos"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Opciones"),
      ],
    );
  }
}
