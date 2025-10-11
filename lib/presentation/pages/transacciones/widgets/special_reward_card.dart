import 'package:flutter/material.dart';

class SpecialRewardCard extends StatelessWidget {
  final String number;
  
  const SpecialRewardCard({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFE0B2), // Color crema/durazno
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Imagen de monedas (puedes usar un asset o emoji)
          Positioned(
            top: 8,
            right: 8,
            child: Text(
              '💰',
              style: const TextStyle(fontSize: 40),
            ),
          ),
          
          // Número
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                number,
                style: const TextStyle(
                  color: Color(0xFFE65100),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}