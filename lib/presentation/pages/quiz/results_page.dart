import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/category_model.dart';

class ResultsPage extends StatelessWidget {
  final QuizCategory category;
  final int correctAnswers;
  final int totalQuestions;

  const ResultsPage({
    super.key,
    required this.category,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  double get percentage => (correctAnswers / totalQuestions) * 100;
  int get wrongAnswers => totalQuestions - correctAnswers;
  int get coinsEarned => correctAnswers * 10; // ← ajusta a tu regla

  // Título según desempeño
  String get resultTitle {
    if (percentage >= 80) return '¡Felicidades!';
    if (percentage >= 40) return 'Sigue intentando';
    return 'A la siguiente será mejor';
  }

  // Subtítulo según desempeño
  String get resultSubtitle {
    if (percentage >= 80) {
      return 'Excelente desempeño, dominas este tema.';
    } else if (percentage >= 40) {
      return 'Vas bien, refuerza un poco más y lo lograrás.';
    } else {
      return 'No pasa nada, practica un poco y mejorarás en la próxima.';
    }
  }

  _TrophyTier get tier {
    if (percentage >= 80) return _TrophyTier.gold;
    if (percentage >= 40) return _TrophyTier.silver;
    return _TrophyTier.broken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E6E6E),
      body: SafeArea(
        child: Stack(
          children: [
            // 🎊 Confetti pintado (sin dependencias)
            const Positioned.fill(child: _ConfettiLayer()),
            // Contenido
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Título
                  Text(
                    resultTitle,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withOpacity(0.95),
                      shadows: const [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black45,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Subtítulo
                  Text(
                    resultSubtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // 🏆 Trofeo dibujado con CustomPaint
                  Expanded(
                    child: Center(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.85, end: 1.0),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.elasticOut,
                        builder: (_, scale, child) =>
                            Transform.scale(scale: scale, child: child),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Base suave (sombra circular)
                            Container(
                              width: 220,
                              height: 220,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                            // Trofeo pintado
                            SizedBox(
                              width: 220,
                              height: 220,
                              child: CustomPaint(painter: _TrophyPainter(tier)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Chips de correctas/incorrectas (banda transparente)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent, // 100% transparente
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _StatChip(
                          value: correctAnswers,
                          icon: Icons.check_circle,
                          iconColor: const Color(0xFF22C55E),
                        ),
                        const SizedBox(width: 12),
                        _StatChip(
                          value: wrongAnswers,
                          icon: Icons.cancel,
                          iconColor: const Color(0xFFEF4444),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Tarjeta de monedas
                  _CoinsCard(coins: coinsEarned),

                  const SizedBox(height: 24),

                  // Botones
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.go('/quiz'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white30,
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.white.withOpacity(0.06),
                          ),
                          child: const Text(
                            'Explorar más',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              context.go('/quiz/play', extra: category),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: category.color,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'Reintentar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ─────────────────────────  TROFEO  ───────────────────────── */

enum _TrophyTier { gold, silver, broken }

class _TrophyPainter extends CustomPainter {
  final _TrophyTier tier;
  _TrophyPainter(this.tier);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Pequeña inclinación si está roto
    if (tier == _TrophyTier.broken) {
      canvas.translate(w * 0.02, 0);
      canvas.rotate(-0.06);
    }

    // Gradientes por nivel
    Shader cupShader;
    Color edge;
    Color baseTop;
    Color baseBottom;

    switch (tier) {
      case _TrophyTier.gold:
        cupShader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF4B3), Color(0xFFFFD54F), Color(0xFFF4B400)],
          stops: [0.0, 0.55, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, w, h));
        edge = const Color(0xFFB08900);
        baseTop = const Color(0xFF6D4C41);
        baseBottom = const Color(0xFF4E342E);
        break;
      case _TrophyTier.silver:
        cupShader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF5F7FA), Color(0xFFD1D5DB), Color(0xFF9CA3AF)],
          stops: [0.0, 0.55, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, w, h));
        edge = const Color(0xFF6B7280);
        baseTop = const Color(0xFF9E9E9E);
        baseBottom = const Color(0xFF757575);
        break;
      case _TrophyTier.broken:
        cupShader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE5E7EB), Color(0xFF9CA3AF), Color(0xFF6B7280)],
          stops: [0.0, 0.5, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, w, h));
        edge = const Color(0xFF4B5563);
        baseTop = const Color(0xFF616161);
        baseBottom = const Color(0xFF424242);
        break;
    }

    // Pinceles
    final cupPaint = Paint()..shader = cupShader;
    final stroke = Paint()
      ..color = edge.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final basePaintTop = Paint()..color = baseTop;
    final basePaintBottom = Paint()..color = baseBottom;

    // --- Formas base ---
    // Copa
    final cup = Path()
      ..moveTo(w * 0.25, h * 0.28)
      ..quadraticBezierTo(w * 0.5, h * 0.16, w * 0.75, h * 0.28)
      ..quadraticBezierTo(w * 0.78, h * 0.48, w * 0.62, h * 0.56)
      ..quadraticBezierTo(w * 0.5, h * 0.60, w * 0.38, h * 0.56)
      ..quadraticBezierTo(w * 0.22, h * 0.48, w * 0.25, h * 0.28)
      ..close();

    // Asa izquierda
    final handleL = Path()
      ..moveTo(w * 0.25, h * 0.34)
      ..quadraticBezierTo(w * 0.10, h * 0.36, w * 0.16, h * 0.50)
      ..quadraticBezierTo(w * 0.20, h * 0.58, w * 0.28, h * 0.54);

    // Asa derecha
    final handleR = Path()
      ..moveTo(w * 0.75, h * 0.34)
      ..quadraticBezierTo(w * 0.90, h * 0.36, w * 0.84, h * 0.50)
      ..quadraticBezierTo(w * 0.80, h * 0.58, w * 0.72, h * 0.54);

    // Cuello
    final neck = Path()
      ..moveTo(w * 0.45, h * 0.56)
      ..quadraticBezierTo(w * 0.5, h * 0.59, w * 0.55, h * 0.56)
      ..lineTo(w * 0.55, h * 0.66)
      ..quadraticBezierTo(w * 0.5, h * 0.68, w * 0.45, h * 0.66)
      ..close();

    // Base superior (plataforma)
    final baseTopRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.73),
        width: w * 0.40,
        height: h * 0.05,
      ),
      const Radius.circular(6),
    );

    // Base inferior
    final baseBottomRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.82),
        width: w * 0.54,
        height: h * 0.09,
      ),
      const Radius.circular(10),
    );

    // Dibujar
    canvas.drawPath(cup, cupPaint);
    canvas.drawPath(cup, stroke);
    canvas.drawPath(handleL, stroke);
    canvas.drawPath(handleR, stroke);
    canvas.drawPath(neck, cupPaint);
    canvas.drawPath(neck, stroke);
    canvas.drawRRect(baseTopRect, basePaintTop);
    canvas.drawRRect(baseBottomRect, basePaintBottom);

    // Brillos (highlight) suaves en copa
    final highlight = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white24, Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(cup, highlight);

    // Si está roto, dibujar grieta y astilla
    if (tier == _TrophyTier.broken) {
      final crack = Paint()
        ..color = Colors.black.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final crackPath = Path()
        ..moveTo(w * 0.52, h * 0.30)
        ..lineTo(w * 0.50, h * 0.34)
        ..lineTo(w * 0.54, h * 0.39)
        ..lineTo(w * 0.49, h * 0.45)
        ..lineTo(w * 0.53, h * 0.50);

      canvas.drawPath(crackPath, crack);

      // Astilla caída
      final chip = Path()
        ..moveTo(w * 0.60, h * 0.38)
        ..lineTo(w * 0.64, h * 0.41)
        ..lineTo(w * 0.61, h * 0.44)
        ..close();

      final chipPaint = Paint()..color = const Color(0xFF9CA3AF);
      canvas.save();
      canvas.translate(6, 10);
      canvas.rotate(0.3);
      canvas.drawPath(chip, chipPaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _TrophyPainter oldDelegate) =>
      oldDelegate.tier != tier;
}

/* ────────────────────────  UI AUXILIAR  ─────────────────────── */

/// Chip compacto para Correctas / Incorrectas
class _StatChip extends StatelessWidget {
  final int value;
  final IconData icon;
  final Color iconColor;
  const _StatChip({
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta central para mostrar monedas ganadas
class _CoinsCard extends StatelessWidget {
  final int coins;
  const _CoinsCard({required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF7F3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icono de moneda (puedes reemplazar por tu asset)
          const Text('🪙', style: TextStyle(fontSize: 26)),
          const SizedBox(width: 10),
          Text(
            '$coins',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

/// Capa de confeti simple (colores, formas y posiciones pseudoaleatorias)
class _ConfettiLayer extends StatelessWidget {
  const _ConfettiLayer();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _ConfettiPainter(seed: 42, density: 130));
  }
}

class _ConfettiPainter extends CustomPainter {
  final int seed;
  final int density;
  _ConfettiPainter({required this.seed, required this.density});

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed);
    final colors = <Color>[
      const Color(0xFFFF3B30),
      const Color(0xFF34C759),
      const Color(0xFF0A84FF),
      const Color(0xFFFFD60A),
      const Color(0xFFFF9F0A),
      const Color(0xFFBF5AF2),
      const Color(0xFF64D2FF),
    ];

    for (int i = 0; i < density; i++) {
      final paint = Paint()
        ..color = colors[rnd.nextInt(colors.length)]
        ..style = PaintingStyle.fill;

      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;

      final shape = rnd.nextInt(3);
      switch (shape) {
        case 0: // rectángulo
          final w = 6 + rnd.nextDouble() * 10;
          final h = 3 + rnd.nextDouble() * 8;
          final rect = Rect.fromCenter(
            center: Offset(x, y),
            width: w,
            height: h,
          );
          final angle = rnd.nextDouble() * math.pi;
          canvas.save();
          canvas.translate(x, y);
          canvas.rotate(angle);
          canvas.translate(-x, -y);
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, const Radius.circular(2)),
            paint,
          );
          canvas.restore();
          break;
        case 1: // círculo
          canvas.drawCircle(Offset(x, y), 2 + rnd.nextDouble() * 3.5, paint);
          break;
        default: // triángulo
          final path = Path();
          final s = 6 + rnd.nextDouble() * 8;
          path.moveTo(x, y - s / 2);
          path.lineTo(x - s / 2, y + s / 2);
          path.lineTo(x + s / 2, y + s / 2);
          path.close();
          canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.seed != seed || oldDelegate.density != density;
}
