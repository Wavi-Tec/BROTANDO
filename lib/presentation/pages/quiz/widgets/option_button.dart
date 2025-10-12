import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String option;
  final int index;
  final bool isCorrect;
  final int? selectedAnswerIndex;
  final bool answered;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.option,
    required this.index,
    required this.isCorrect,
    required this.selectedAnswerIndex,
    required this.answered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    if (answered) {
      if (index == selectedAnswerIndex) {
        backgroundColor = isCorrect
            ? const Color(0xFFB8E6D5)
            : const Color(0xFFFFCDD2);
        textColor = Colors.black87;
        borderColor = isCorrect ? const Color(0xFF10B3A9) : Colors.red;
      } else if (isCorrect) {
        backgroundColor = const Color(0xFFB8E6D5);
        textColor = Colors.black87;
        borderColor = const Color(0xFF10B3A9);
      } else {
        backgroundColor = Colors.white;
        textColor = Colors.black38;
        borderColor = Colors.grey.shade200;
      }
    } else {
      backgroundColor = Colors.white;
      textColor = Colors.black87;
      borderColor = Colors.grey.shade200;
    }

    final letters = ['a)', 'b)', 'c)', 'd)'];

    return InkWell(
      onTap: answered ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    // 🔤 LETRA - MÁS GRUESA
                    TextSpan(
                      text: '${letters[index]} ',
                      style: TextStyle(
                        fontFamily: 'Flexo',
                        color: textColor,
                        fontSize: 16, // 👈 Un poco más grande
                        fontWeight:
                            FontWeight.w900, // 👈 BLACK/HEAVY (máximo peso)
                        letterSpacing:
                            0.5, // 👈 Espaciado para verse más grueso
                      ),
                    ),
                    // 📝 OPCIÓN - REGULAR
                    TextSpan(
                      text: option,
                      style: TextStyle(
                        fontFamily: 'Flexo',
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (answered && (index == selectedAnswerIndex || isCorrect))
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? const Color(0xFF10B3A9) : Colors.red,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
