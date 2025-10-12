import 'package:flutter/material.dart';

class SpecialRewardCard extends StatelessWidget {
  final String number;

  const SpecialRewardCard({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // 🔹 misma altura que RewardCard
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700), // Dorado brillante
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 🌟 Contenido principal centrado (ticket)
          Center(
            child: Image.asset(
              'assets/imagesG/ticket1.png',
              height: 80,
              fit: BoxFit.contain,
            ),
          ),

          // 🌈 Degradado inferior horizontal (igual estructura)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFFFE082), // Amarillo claro
                    Color(0xFFFFC107), // Dorado medio
                    Color(0xFFFFD54F), // Dorado intenso
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.compare_arrows,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          // 🔢 Número e imagen Yasta igual que RewardCard
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            height: 36,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset(
                    'assets/imagesG/yasta.png',
                    height: 36,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
