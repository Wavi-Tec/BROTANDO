import 'package:flutter/material.dart';
import 'widgets/user_header.dart';
import 'widgets/puntos_card.dart';
import 'widgets/premium_button.dart';
import 'widgets/points_exchange_section.dart';
import 'widgets/surveys_section.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserHeader(
                userName: 'Maria Torrez',
                userImage:
                    'https://static.vecteezy.com/system/resources/previews/014/194/215/non_2x/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg',
                onNotificationPressed: () {
                  // Manejar notificaciones
                },
              ),
              const SizedBox(height: 20),
              const PuntosCard(points: 15000, coins: 500),
              const SizedBox(height: 20),
              PremiumButton(
                onPressed: () {
                  // Manejar botón premium
                },
              ),
              const SizedBox(height: 24),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: PointsExchangeSection()),
          SizedBox(width: 12),
          Expanded(child: SurveysSection()),
        ],
      ),
    );
  }
}
