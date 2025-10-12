import 'package:flutter/material.dart';
import 'plant_tag_widget.dart';

// Plant model
class Plant {
  final String name;
  final String description;
  final String imageUrl;
  final List<PlantTag> tags;
  final double price;

  Plant({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.price,
  });
}

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Plant name with animation
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            plant.name,
            key: ValueKey(plant.name),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5DBBBB),
              height: 1.0,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Plant image and description
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant image with hero animation
            Hero(
              tag: 'plant_image_${plant.name}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  plant.imageUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Description
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  plant.description,
                  key: ValueKey(plant.description),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Tags with animation
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Wrap(
            key: ValueKey('tags_${plant.name}'),
            spacing: 12,
            runSpacing: 12,
            children: plant.tags.map((tag) {
              return PlantTagWidget(tag: tag);
            }).toList(),
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }
}
