import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  final String brandName;
  final String discount;
  final int coins;
  final Color color;
  final Color logoColor;
  final VoidCallback? onTap;

  const CouponCard({
    super.key,
    required this.brandName,
    required this.discount,
    required this.coins,
    required this.color,
    required this.logoColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Text(
                    brandName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: logoColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Discount Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D7377),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      discount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Coins
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(width: 6),
                      Text(
                        '$coins Monedas',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFB800),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
