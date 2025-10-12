import 'package:flutter/material.dart';

class RewardCard extends StatelessWidget {
  final String points;
  final String number;
  final bool isUnlocked;
  final bool isSpecial;

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
      height: 90, // altura compacta
      decoration: BoxDecoration(
        color: isSpecial
            ? const Color.fromARGB(255, 70, 122, 71)
            : const Color(0xFF37474F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // 🌟 Contenido principal centrado
          Center(
            child: isSpecial
                ? Image.asset(
                    'assets/imagesG/arbol1.png',
                    height: 100, // 🔹 ajusta el tamaño según necesites
                    fit: BoxFit.contain,
                  )
                : Text(
                    points,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),

          // 🌈 Degradado inferior horizontal
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
                    Color(0xFF00BFA5), // Turquesa brillante
                    Color(0xFF37474F), // Gris oscuro
                    Color(0xFF26A69A), // Verde medio
                  ],
                ),
              ),
              // 🔹 Ícono centrado en el degradado (eje X y eje Y)
              child: const Center(
                child: Icon(
                  Icons.compare_arrows,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          // 🔢 Número e ícono derecho (texto)
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            height: 36, // igual al alto del degradado
            child: Align(
              alignment:
                  Alignment.center, // 🔹 centra todo dentro del degradado
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🔹 Número
                  Text(
                    number,
                    style: TextStyle(
                      color: isUnlocked ? Colors.white : Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // 🔹 Imagen (logo Yasta)
                  Image.asset(
                    'assets/imagesG/yasta.png',
                    height:
                        36, // 🔹 ajustado para quedar centrado en el degradado
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
