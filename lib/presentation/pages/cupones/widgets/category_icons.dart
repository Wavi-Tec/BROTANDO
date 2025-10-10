import 'package:flutter/material.dart';

class CategoryIcons extends StatelessWidget {
  final List<CategoryItem> categories;

  const CategoryIcons({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: categories
            .map(
              (category) => _buildCategoryIcon(
                icon: category.icon,
                label: category.label,
                color: category.color,
                onTap: category.onTap,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCategoryIcon({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF0D7377),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  CategoryItem({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });
}
