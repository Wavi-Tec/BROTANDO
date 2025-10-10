import 'package:flutter/material.dart';

class PointsCoinsHeader extends StatelessWidget {
  final int points;
  final int coins;

  const PointsCoinsHeader({
    super.key,
    required this.points,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Points icon and value
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFF0D7377), size: 22),
              const SizedBox(width: 4),
              Text(
                points.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D7377),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Coins icon and value
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFB800),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.monetization_on,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                coins.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D7377),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
