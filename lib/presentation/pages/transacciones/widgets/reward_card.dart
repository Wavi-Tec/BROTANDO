import 'package:flutter/material.dart';

class RewardCard extends StatelessWidget {
  final String points;
  final String number;
  final bool isUnlocked;
  final bool isSpecial; // Para la tarjeta del árbol

  const RewardCard({
    super.key,
    required this.points,
    required this.number,
    this.isUnlocked = false,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSpecial 
            ? const Color(0xFF4CAF50) // Verde para árbol
            : const Color(0xFF37474F), // Gris oscuro
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Contenido principal
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Puntos
                if (!isSpecial)
                  Text(
                    points,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                
                const Spacer(),
                
                // Ícono o imagen especial
                if (isSpecial)
                  Center(
                    child: Text(
                      '🌳',
                      style: const TextStyle(fontSize: 40),
                    ),
                  )
                else
                  const Icon(
                    Icons.shopping_bag,
                    color: Color(0xFF00BFA5),
                    size: 24,
                  ),
                
                const Spacer(),
                
                // Número inferior
                Row(
                  children: [
                    Text(
                      number,
                      style: TextStyle(
                        color: isUnlocked ? Colors.white : Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (isUnlocked)
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF00BFA5),
                        size: 16,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}