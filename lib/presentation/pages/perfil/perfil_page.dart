import 'package:flutter/material.dart';
import 'widgets/custom_back_button.dart';
import 'widgets/profile_card.dart';
import 'widgets/achievements_grid.dart';
import 'widgets/invite_button.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                CustomBackButton(route: '/inicio'),
                // Profile Card
                ProfileCard(
                  userName: 'Maria Gasa Torrez Flores',
                  userEmail: 'mari@gmail.com',
                  userImage:
                      'https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/350218472/original/1cae06a7845aee5beafbf7fe6a623dc5caafbed9/draw-cute-minimalist-cartoon-avatar-or-icon-for-you.jpg',
                  plantsCount: 5,
                  plantsStatus: 'Creciendo felices',
                  onEditPressed: () {
                    // Manejar edición del perfil
                  },
                ),
                const SizedBox(height: 18),
                // Achievements Section
                const AchievementsGrid(),
                const SizedBox(height: 30),
                // Invite Button
                InviteButton(
                  onPressed: () {
                    // Manejar invitar amigos
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
