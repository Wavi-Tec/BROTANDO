import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // 👈 IMPORTANTE
import '../../../core/models/category_model.dart';
import 'widgets/category_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  // ✅ Usamos los ids nuevos (L348, FIN, YASTA, SEG)
  List<QuizCategory> get categories => [
    QuizCategory(
      id: 'L348',
      name: 'Ley 348',
      emoji: '⚖️',
      description: 'Derechos y prevención de violencia',
      totalQuestions: 5,
      color: const Color.fromARGB(255, 0, 0, 0), // violeta justicia
    ),
    QuizCategory(
      id: 'FIN',
      name: 'Educación Financiera',
      emoji: '💰',
      description: 'Ahorro, presupuesto e intereses',
      totalQuestions: 5,
      color: const Color(0xFF00A86B), // verde finanzas
    ),
    QuizCategory(
      id: 'YASTA',
      name: 'Yasta: uso y datos',
      emoji: '📱',
      description: 'Promos, puntos y buen uso',
      totalQuestions: 5,
      color: const Color.fromARGB(255, 241, 173, 109), // dorado/brand
    ),
    QuizCategory(
      id: 'SEG',
      name: 'Seguridad Digital',
      emoji: '🛡️',
      description: 'Fraudes, PIN y buenas prácticas',
      totalQuestions: 5,
      color: const Color.fromARGB(255, 238, 219, 250), // azul seguridad
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título principal
              const Text(
                'Gana puntos respondiendo\ncorrectamente',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w900, // Extra Bold
                  height: 1.4,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 24),

              // Subtítulo
              const Text(
                'Elige una categoría',
                style: TextStyle(
                  color: Color(0xFF00897B),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Grid de categorías
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      category: category,
                      onTap: () {
                        context.push('/quiz/play', extra: category);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
