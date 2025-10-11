import 'package:flutter/material.dart';
import 'donation_modal.dart';

class DonationCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final int donationCount;
  final double targetAmount;
  final double currentAmount;

  const DonationCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.donationCount = 0,
    this.targetAmount = 0.0,
    this.currentAmount = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDonationModal(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey[200],
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF1B5E5A),
                        child: const Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ECDC4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1B5E5A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Text(
                    //   description,
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.grey[600],
                    //     height: 1.4,
                    //   ),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    const SizedBox(height: 10),
                    // Progress bar for donations
                    if (targetAmount > 0) ...[
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (currentAmount / targetAmount).clamp(
                            0.0,
                            1.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF4ECDC4),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${currentAmount.toStringAsFixed(0)} / \$${targetAmount.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${((currentAmount / targetAmount) * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF1B5E5A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                    // Donation count and actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: const Color(0xFF4ECDC4),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$donationCount donaciones',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF1B5E5A),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.share,
                              color: const Color(0xFF4ECDC4),
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDonationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DonationModal(
        title: title,
        description: description,
        imageUrl: imageUrl,
        category: category,
        donationCount: donationCount,
        targetAmount: targetAmount,
        currentAmount: currentAmount,
      ),
    );
  }
}
