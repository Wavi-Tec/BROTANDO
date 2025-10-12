import 'package:flutter/material.dart';

class PlantSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onClear;
  final String hintText;

  const PlantSearchBar({
    super.key,
    required this.controller,
    this.onClear,
    this.hintText = 'Buscar planta...',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 38,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF0D7377)),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: onClear ?? () => controller.clear(),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(
                color: Color(0xFF0D7377),
                width: 1.5,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
