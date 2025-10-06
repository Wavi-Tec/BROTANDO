import 'package:flutter/material.dart';

class AnimatedGrowth extends StatelessWidget {
  final int level;
  final Widget child;

  const AnimatedGrowth({super.key, required this.level, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1 + (level * 0.05),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: child,
    );
  }
}
