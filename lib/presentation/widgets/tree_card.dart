import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/animated_growth.dart';
import '../../../core/constants/app_colors.dart';

class TreeCard extends StatelessWidget {
  final String name;
  final int level;
  final VoidCallback onGrow;

  const TreeCard({
    super.key,
    required this.name,
    required this.level,
    required this.onGrow,
  });

  @override
  Widget build(BuildContext context) {
    final height = 100 + (level * 20); // crece visualmente

    return GestureDetector(
      onTap: onGrow,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedGrowth(
              level: level,
              child: Icon(
                Icons.forest,
                size: height * 0.6,
                color: AppColors.greenPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Nivel $level", style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
