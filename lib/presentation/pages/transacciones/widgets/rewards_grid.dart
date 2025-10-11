import 'package:flutter/material.dart';
import 'reward_card.dart';
import 'special_reward_card.dart';

class RewardsGrid extends StatelessWidget {
  const RewardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.85,
      children: const [
        // Fila 1
        RewardCard(points: '10 Puntos', number: '20', isUnlocked: true),
        RewardCard(points: '15 Puntos', number: '40', isUnlocked: true),
        RewardCard(points: '20 Puntos', number: '50', isUnlocked: true),

        // Fila 2
        RewardCard(points: '25 Puntos', number: '70', isUnlocked: true),
        RewardCard(points: '30 Puntos', number: '80', isUnlocked: true),
        RewardCard(points: '40 Puntos', number: '90', isUnlocked: true),

        // Fila 3
        RewardCard(points: '45 Puntos', number: '95', isUnlocked: true),
        RewardCard(
          points: '',
          number: '100',
          isSpecial: true,
          isUnlocked: true,
        ), // Árbol
        RewardCard(points: '50 Puntos', number: '110', isUnlocked: true),

        // Fila 4
        RewardCard(points: '55 Puntos', number: '115'),
        RewardCard(points: '60 Puntos', number: '120'),
        RewardCard(points: '65 Puntos', number: '250'),

        // Fila 5
        RewardCard(points: '70 Puntos', number: '260'),
        RewardCard(points: '75 Puntos', number: '280'),
        SpecialRewardCard(number: '200'), // Tarjeta amarilla
      ],
    );
  }
}
