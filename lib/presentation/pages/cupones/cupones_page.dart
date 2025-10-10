import 'package:flutter/material.dart';
import 'widgets/points_coins_header.dart';
import 'widgets/category_icons.dart';
import 'widgets/featured_coupon_card.dart';
import 'widgets/coupon_card.dart';

class CuponesPage extends StatelessWidget {
  const CuponesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Points and Coins
              const PointsCoinsHeader(points: 15000, coins: 500),
              const SizedBox(height: 20),
              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Canje de Puntos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D7377),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Category Icons
              CategoryIcons(
                categories: [
                  CategoryItem(
                    icon: Icons.local_pharmacy,
                    label: 'Farmancion',
                    color: const Color(0xFF0D7377),
                    onTap: () {
                      // Manejar tap de farmacia
                    },
                  ),
                  CategoryItem(
                    icon: Icons.restaurant,
                    label: 'Comida',
                    color: const Color(0xFF0D7377),
                    onTap: () {
                      // Manejar tap de comida
                    },
                  ),
                  CategoryItem(
                    icon: Icons.checkroom,
                    label: 'Ropa',
                    color: const Color(0xFF0D7377),
                    onTap: () {
                      // Manejar tap de ropa
                    },
                  ),
                  CategoryItem(
                    icon: Icons.confirmation_number,
                    label: 'Cupones',
                    color: const Color(0xFF0D7377),
                    onTap: () {
                      // Manejar tap de cupones
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Featured Coupon Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FeaturedCouponCard(
                  brandIcon: Icons.restaurant_menu,
                  brandColor: const Color(0xFFE53935),
                  iconColor: Colors.yellow[700]!,
                  discount: '30 % DTO',
                  description: 'Canjea este cupón con monedas.',
                  coins: 120,
                  onRedeem: () {
                    // Manejar canje del cupón destacado
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Grid of Coupon Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.00,
                  children: [
                    CouponCard(
                      brandName: 'HIPERMAXI',
                      discount: '10 % DTO',
                      coins: 60,
                      color: const Color(0xFFFF6B35),
                      logoColor: Colors.white,
                      onTap: () {
                        // Manejar tap de HIPERMAXI
                      },
                    ),
                    CouponCard(
                      brandName: 'FarmaCorp',
                      discount: '30 % DTO',
                      coins: 120,
                      color: const Color(0xFF4A90E2),
                      logoColor: Colors.white,
                      onTap: () {
                        // Manejar tap de FarmaCorp
                      },
                    ),
                    CouponCard(
                      brandName: 'entel\nBolivia',
                      discount: '10 Bs',
                      coins: 70,
                      color: const Color(0xFF00A8E8),
                      logoColor: Colors.white,
                      onTap: () {
                        // Manejar tap de Entel
                      },
                    ),
                    CouponCard(
                      brandName: 'Manavic',
                      discount: '15 % DTO',
                      coins: 70,
                      color: const Color(0xFFE91E63),
                      logoColor: Colors.white,
                      onTap: () {
                        // Manejar tap de Manavic
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
