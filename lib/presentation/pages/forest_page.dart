import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/tree_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav.dart';
import 'package:go_router/go_router.dart';

class ForestPage extends StatefulWidget {
  const ForestPage({super.key});

  @override
  State<ForestPage> createState() => _ForestPageState();
}

class _ForestPageState extends State<ForestPage> {
  List<Map<String, dynamic>> trees = [
    {"name": "Roble", "level": 1},
    {"name": "Sauce", "level": 2},
    {"name": "Pino", "level": 1},
  ];

  int coins = 0;
  int currentIndex = 0;

  void growTree(int index) {
    setState(() {
      trees[index]["level"]++;
      coins += 5; // recompensa
    });
  }

  void resetForest() {
    setState(() {
      trees = trees.map((t) => {"name": t["name"], "level": 1}).toList();
      coins = 0;
    });
  }

  void onNavTap(int index) {
    setState(() => currentIndex = index);
    switch (index) {
      case 0:
        context.go('/forest');
        break;
      case 1:
        context.go('/challenges');
        break;
      case 2:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tu Bosque 🌿"),
        backgroundColor: AppColors.greenPrimary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            // Encabezado con puntos y monedas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "🌳 Árboles: ${trees.length}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "💰 Monedas: $coins",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Lista de árboles
            Expanded(
              child: GridView.builder(
                itemCount: trees.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final tree = trees[index];
                  return TreeCard(
                    name: tree["name"],
                    level: tree["level"],
                    onGrow: () => growTree(index),
                  );
                },
              ),
            ),

            // Botón para reiniciar
            CustomButton(
              text: "Reiniciar Bosque",
              onPressed: resetForest,
              color: AppColors.brown,
            ),
          ],
        ),
      ),
      // 👇 Aquí agregamos la barra inferior
      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }
}
