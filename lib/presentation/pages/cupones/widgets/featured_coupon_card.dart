import 'package:flutter/material.dart';

class FeaturedCouponCard extends StatelessWidget {
  final IconData brandIcon;
  final Color brandColor;
  final Color iconColor;
  final String discount;
  final String description;
  final int coins;
  final VoidCallback? onRedeem;

  const FeaturedCouponCard({
    super.key,
    required this.brandIcon,
    required this.brandColor,
    required this.iconColor,
    required this.discount,
    required this.description,
    required this.coins,
    this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Brand Logo
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: brandColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Icon(brandIcon, color: iconColor, size: 28)),
          ),
          const SizedBox(width: 12),
          // Coupon Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Discount Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D7377),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Cupón: $discount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Coins and Button
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB800),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    coins.toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFB800),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 28,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D7377),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(60, 28),
                  ),
                  onPressed: onRedeem,
                  child: const Text(
                    'Canjear',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
