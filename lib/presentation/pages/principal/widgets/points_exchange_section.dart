import 'package:flutter/material.dart';
import 'cupon_card.dart';

class PointsExchangeSection extends StatelessWidget {
  const PointsExchangeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Canje de Puntos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        CuponCard(
          color: const Color(0xFFFF5252),
          icon: '😊',
          discount: '17% DTO',
          onTap: () {
            // Manejar tap del cupón
          },
        ),
        const SizedBox(height: 12),
        CuponCard(
          color: const Color(0xFFFF6F00),
          brandName: 'HIPERMAXI',
          discount: '17% DTO',
          onTap: () {
            // Manejar tap del cupón
          },
        ),
        const SizedBox(height: 12),
        CuponCard(
          color: const Color(0xFF0091EA),
          brandName: 'entel',
          discount: '17% DTO',
          onTap: () {
            // Manejar tap del cupón
          },
        ),
        const SizedBox(height: 12),
        CuponCard(
          color: const Color(0xFFE91E63),
          brandName: '+vida',
          discount: '17% DTO',
          onTap: () {
            // Manejar tap del cupón
          },
        ),
        const SizedBox(height: 12),
        CuponCard(
          color: const Color(0xFFE91E63),
          brandName: '+vida',
          discount: '17% DTO',
          onTap: () {
            // Manejar tap del cupón
          },
        ),
      ],
    );
  }
}
