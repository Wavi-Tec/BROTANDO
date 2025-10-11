import 'package:flutter/material.dart';
import 'widgets/month_header.dart';
import 'widgets/rewards_grid.dart';

class TransaccionesPage extends StatelessWidget {
  const TransaccionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Verde agua claro
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header simplificado - solo número y palabra
            const MonthHeader(completed: 20),

            const SizedBox(height: 16),

            // Título
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Yasta te Premia',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900, // 🔥 más gruesa que bold
                  color: Color(0xFF2C3E50),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Grid de recompensas
            const Expanded(child: RewardsGrid()),
          ],
        ),
      ),
    );
  }
}
