import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() => runApp(const BrotandoApp());

class BrotandoApp extends StatelessWidget {
  const BrotandoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'Brotando',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
    );
  }
}
