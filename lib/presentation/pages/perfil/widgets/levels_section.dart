import 'package:flutter/material.dart';
import 'level_badge.dart';

class LevelsSection extends StatelessWidget {
  const LevelsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Nivel:',
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
              LevelBadge(
                image: 'assets/imagesG/nivel1.png',
                title: 'Nivel 1:\nSemilla Rebelde',
                backgroundColor: const Color(0xFFD4B5A0),
                isUnlocked: true,
                onTap: () {},
              ),
              LevelBadge(
                image: 'assets/imagesG/nivel2.png',
                title: 'Nivel 2:\nBrote Valiente',
                backgroundColor: const Color(0xFFB3D9F2),
                isUnlocked: false,
                lockMessage: '🌱 Planta 5 árboles',
                onTap: () {},
              ),
              LevelBadge(
                image: 'assets/imagesG/nivel3.png',
                title: 'Nivel 3:\nGuardián Verde',
                backgroundColor: const Color(0xFFC8F4D8),
                isUnlocked: false,
                lockMessage: '🌳 Alcanza nivel 2',
                onTap: () {},
              ),
              LevelBadge(
                image: 'assets/imagesG/nivel4.png',
                title: 'Nivel 4:\nÁrbol Sabio',
                backgroundColor: const Color(0xFFFFE5B4),
                isUnlocked: false,
                lockMessage: '📚 Completa 10 misiones',
                onTap: () {},
              ),
              LevelBadge(
                image: 'assets/imagesG/nivel5.png',
                title: 'Nivel 5:\nBosque Protector',
                backgroundColor: const Color(0xFFE8D7FF),
                isUnlocked: false,
                lockMessage: '🌲 Planta 50 árboles',
                onTap: () {},
              ),
              LevelBadge(
                image: 'assets/imagesG/nivel6.png',
                title: 'Nivel 6:\nLegado Natural',
                backgroundColor: const Color(0xFFFFD4D4),
                isUnlocked: false,
                lockMessage: '👑 Maestría total',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}