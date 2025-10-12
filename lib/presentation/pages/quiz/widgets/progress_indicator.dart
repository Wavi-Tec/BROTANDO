import 'package:flutter/material.dart';

class QuizProgressIndicator extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final double progress;
  final Color color;

  const QuizProgressIndicator({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // 👈 FONDO TRANSPARENTE
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // 🔢 CONTADOR (1/5)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      252,
                      164,
                      2,
                    ).withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '$currentQuestion/$totalQuestions',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // 📊 BARRA DE PROGRESO
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade300, // 👈 FONDO GRIS CLARO
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFFFB300), // 👈 COLOR DORADO
                  ), // 👈 COLOR NARANJA
                  minHeight: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
