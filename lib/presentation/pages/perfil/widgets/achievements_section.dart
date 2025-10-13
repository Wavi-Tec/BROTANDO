import 'package:flutter/material.dart';
import 'achievement_badge.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Logros:',
            style: TextStyle(
              fontFamily: 'Flexo',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 15),
        // CARRUSEL HORIZONTAL
        SizedBox(
          height: 180, // ← Altura para contener badge + texto
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              AchievementBadge(
                image: 'assets/imagesG/logro1.png',
                title: 'Primer Brote',
                isUnlocked: true,
                onTap: () {},
              ),
              AchievementBadge(
                image: 'assets/imagesG/logro2.png',
                title: 'Plantador Oficial',
                isUnlocked: false,
                lockMessage: '🌿 Planta tu primera planta',
                onTap: () {},
              ),
              AchievementBadge(
                image: 'assets/imagesG/logro3.png',
                title: 'Mente Verde',
                isUnlocked: false,
                lockMessage: '🧠 Completa 5 quizzes',
                onTap: () {},
              ),
              AchievementBadge(
                image: 'assets/imagesG/logro4.png',
                title: 'Eco Guerrero',
                isUnlocked: false,
                lockMessage: '⚔️ Gana 3 desafíos',
                onTap: () {},
              ),
              AchievementBadge(
                image: 'assets/imagesG/logro5.png',
                title: 'Guardián del Bosque',
                isUnlocked: false,
                lockMessage: '🌲 Cuida 20 plantas',
                onTap: () {},
              ),
              AchievementBadge(
                image: 'assets/imagesG/logro6.png',
                title: 'Maestro Verde',
                isUnlocked: false,
                lockMessage: '🏆 Desbloquea todo',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
