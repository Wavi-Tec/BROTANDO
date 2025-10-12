import 'package:flutter/material.dart';

class UserStatsHeader extends StatelessWidget {
  final int points;
  final int coins;

  const UserStatsHeader({super.key, required this.points, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Spacer(),

          // Points section
          const SizedBox(width: 8),
          const Icon(Icons.star, color: Color(0xFF0D7377), size: 24),
          Text(
            points.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 24),

          // Coins section
          const SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFFDB913),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '\$',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Text(
            coins.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
