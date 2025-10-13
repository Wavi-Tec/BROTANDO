import 'package:flutter/material.dart';
import 'achievement_badge.dart';
import 'circular_badge.dart';

class AchievementsGrid extends StatelessWidget {
  const AchievementsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Logros',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 25,
          crossAxisSpacing: 25,
          children: [
            AchievementBadge(
              emoji: '🌍',
              backgroundColor: const Color(0xFFE8E4FF),
              type: 'wings-purple',
              onTap: () {
                // Manejar tap del logro
              },
            ),
            AchievementBadge(
              emoji: '🏆',
              backgroundColor: const Color(0xFFFFF4E6),
              type: 'wings-gold',
              onTap: () {
                // Manejar tap del logro
              },
            ),
            AchievementBadge(
              emoji: '💰',
              backgroundColor: const Color(0xFFE0F7FA),
              type: 'wings-cyan',
              onTap: () {
                // Manejar tap del logro
              },
            ),
            CircularBadge(
              emoji: '🌿',
              label: 'Colecta de Plantas',
              onTap: () {
                // Manejar tap del logro
              },
            ),
            CircularBadge(
              emoji: '🌸',
              label: 'Eco Friendly',
              onTap: () {
                // Manejar tap del logro
              },
            ),
            CircularBadge(
              emoji: '🌳',
              label: 'Planta Solidaria',
              onTap: () {
                // Manejar tap del logro
              },
            ),
          ],
        ),
      ],
    );
  }
}
