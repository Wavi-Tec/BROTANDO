import 'package:flutter/material.dart';

class MonthHeader extends StatelessWidget {
  final int completed;

  const MonthHeader({super.key, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          // Imagen/Logo
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/imagesG/imagen1.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // Número
          Text(
            '$completed',
            style: const TextStyle(
              fontSize: 28, // ← CAMBIA EL TAMAÑO AQUÍ
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(
                255,
                0,
                0,
                0,
              ), // ← CAMBIA EL COLOR AQUÍ (verde agua)
            ),
          ),

          const SizedBox(width: 8),

          // Ícono de flechas (tu logo)
          const Icon(
            Icons.sync_alt, // ← Usa el ícono que más se parezca
            color: Color(0xFF00BFA5), // ← CAMBIA EL COLOR AQUÍ
            size: 28, // ← CAMBIA EL TAMAÑO AQUÍ
          ),

          const SizedBox(width: 8),

          // Palabra "transacciones"
          const Text(
            'transacciones',
            style: TextStyle(
              fontSize: 18, // ← CAMBIA EL TAMAÑO AQUÍ
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(
                255,
                122,
                122,
                122,
              ), // ← CAMBIA EL COLOR AQUÍ (gris oscuro)
            ),
          ),
        ],
      ),
    );
  }
}
