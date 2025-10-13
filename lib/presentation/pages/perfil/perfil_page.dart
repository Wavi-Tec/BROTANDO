import 'package:flutter/material.dart';
import 'widgets/custom_back_button.dart';
import 'widgets/profile_card.dart';
import 'widgets/levels_section.dart';
import 'widgets/achievements_section.dart';
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
                CustomBackButton(route: '/inicio'),
                Transform.translate(
                  offset: const Offset(0, -15),
                  child: ProfileCard(
                    userName: 'Maria Gasa Torrez Flores',
                    userEmail: 'mari@gmail.com',
                    userImage:
                        'https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/350218472/original/1cae06a7845aee5beafbf7fe6a623dc5caafbed9/draw-cute-minimalist-cartoon-avatar-or-icon-for-you.jpg',
                    plantsCount: 8,
                    plantsStatus: 'Creciendo felices',
                    onEditPressed: () {},
                  ),
                ),
                const SizedBox(height: 18),

                // SECCIÓN DE NIVELES (6 niveles en 2 filas)
                const LevelsSection(),
                const SizedBox(height: 25),

                // SECCIÓN DE LOGROS (3 medallas)
                const AchievementsSection(),
                const SizedBox(height: 30),

                InviteButton(onPressed: () {}),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
