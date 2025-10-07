import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Clase para manejar todas las transiciones de página de la app
class PageTransitions {
  /// Transición con fade rápido y sin sobreposición
  static Page<dynamic> buildFadeTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 150),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Transición de salida más rápida para la página anterior
        const outCurve = Interval(0.0, 0.3, curve: Curves.easeInQuad);
        // Transición de entrada más lenta para la nueva página
        const inCurve = Interval(0.4, 1.0, curve: Curves.easeOutQuad);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            if (secondaryAnimation.status != AnimationStatus.dismissed) {
              // Página saliente - desaparece rápido
              return FadeTransition(
                opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(parent: secondaryAnimation, curve: outCurve),
                ),
                child: child,
              );
            } else {
              // Página entrante - aparece después
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: inCurve),
                child: child,
              );
            }
          },
          child: child,
        );
      },
    );
  }

  /// Transición con slide horizontal (alternativa)
  static Page<dynamic> buildSlideTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(1.0, 0.0), // Entra desde la derecha
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: child,
        );
      },
    );
  }
}
