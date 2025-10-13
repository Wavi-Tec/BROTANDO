import 'package:flutter/material.dart';

class LevelBadge extends StatelessWidget {
  final String image;
  final String title;
  final Color backgroundColor;
  final bool isUnlocked;
  final String? lockMessage; // ← NUEVO: mensaje de bloqueo
  final VoidCallback? onTap;

  const LevelBadge({
    super.key,
    required this.image,
    required this.title,
    required this.backgroundColor,
    this.isUnlocked = false,
    this.lockMessage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120, // ← Ancho fijo para el carrusel
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Opacity(
                      opacity: isUnlocked ? 1.0 : 0.4,
                      child: Image.asset(
                        image,
                        width: 110,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Icono de candado si está bloqueado
                if (!isUnlocked)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Título
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Flexo',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isUnlocked ? Colors.black87 : Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Mensaje de desbloqueo
            if (!isUnlocked && lockMessage != null) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lockMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Flexo',
                    fontSize: 9,
                    color: Colors.orange.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
