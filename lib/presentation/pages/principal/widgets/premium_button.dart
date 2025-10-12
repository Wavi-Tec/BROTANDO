import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PremiumButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const PremiumButton({super.key, this.onPressed});

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1DE9B6),
                  const Color(0xFF00BCD4),
                  const Color(0xFF10B3A9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00BCD4).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFF10B3A9).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Ejecutar callback personalizado si existe
                    widget.onPressed?.call();
                    // Navegar a la página de transacciones
                    context.go('/transacciones');
                  },
                  onTapDown: (_) {
                    _animationController.forward();
                  },
                  onTapUp: (_) {
                    _animationController.reverse();
                  },
                  onTapCancel: () {
                    _animationController.reverse();
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),

                          child: Image.asset(
                            'assets/logoYasta.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFFFFD700),
                                Color(0xFFFFF176),
                                Color(0xFFFFD700),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds),
                            child: const Text(
                              'Te Premia',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.5,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
