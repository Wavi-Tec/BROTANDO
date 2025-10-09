import 'package:flutter/material.dart';
import 'category_button.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          CategoryButton(
            label: 'Todos',
            icon: Icons.apps,
            category: 'Todos',
            selectedCategory: selectedCategory,
            onTap: () => onCategoryChanged('Todos'),
          ),
          CategoryButton(
            label: 'Incendios',
            icon: Icons.local_fire_department,
            category: 'Incendios',
            selectedCategory: selectedCategory,
            onTap: () => onCategoryChanged('Incendios'),
          ),
          CategoryButton(
            label: 'Guardaparque',
            icon: Icons.park,
            category: 'Guardaparque',
            selectedCategory: selectedCategory,
            onTap: () => onCategoryChanged('Guardaparque'),
          ),
          CategoryButton(
            label: 'Bomberos',
            icon: Icons.fire_truck,
            category: 'Bomberos',
            selectedCategory: selectedCategory,
            onTap: () => onCategoryChanged('Bomberos'),
          ),
          CategoryButton(
            label: 'Reforestar',
            icon: Icons.nature,
            category: 'Reforestar',
            selectedCategory: selectedCategory,
            onTap: () => onCategoryChanged('Reforestar'),
          ),
        ],
      ),
    );
  }
}
