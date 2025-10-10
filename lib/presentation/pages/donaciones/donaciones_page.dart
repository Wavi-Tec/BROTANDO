import 'package:flutter/material.dart';
import 'widgets/index.dart';

class DonacionesPage extends StatefulWidget {
  const DonacionesPage({super.key});

  @override
  State<DonacionesPage> createState() => _DonacionesPageState();
}

class _DonacionesPageState extends State<DonacionesPage> {
  String selectedCategory = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 10.0,
              ),
              child: Row(
                children: [
                  // Align "Donación" with the left button
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Donación',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Align "Monedas" with the right button
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Monedas',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Stats Row
            const StatsCard(donationsCount: 16, coinsCount: 500),

            const SizedBox(height: 20),

            // Category Filters
            CategoryFilter(
              selectedCategory: selectedCategory,
              onCategoryChanged: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),

            const SizedBox(height: 10),

            // Donation Cards List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  DonationCard(
                    title:
                        '"Salvemos la Chiquitanía" - Bomberos Forestales Voluntarios',
                    description:
                        'Descripción: Campaña ciudadana que recauda fondos para equipar a los bomberos forestales que luchan contra los incendios en la Chiquitanía y a los refugios de animales, plantas y animales durante los incendios.',
                    imageUrl:
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-kQM4nZP5q5ZJ321XBevY6c3zYJkjo4.png',
                    category: 'Bomberos',
                  ),
                  DonationCard(
                    title: 'Sembramos VIDA en la Chiquitanía - Unión Verde',
                    description:
                        'Descripción: Programa impulsado por la Unión Europea bajo los Objetivos de Desarrollo Sostenible (ODS) que busca la restauración y adaptación al cambio climático mediante la siembra de especies nativas y endémicas.',
                    imageUrl:
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-kQM4nZP5q5ZJ321XBevY6c3zYJkjo4.png',
                    category: 'Reforestar',
                  ),
                  DonationCard(
                    title: 'Fundación Amigos de la Naturaleza (FAN Bolivia)',
                    description:
                        'Descripción: Organización dedicada a la conservación de la biodiversidad boliviana, que apoya a áreas protegidas y comunidades locales en la protección de bosques, ríos y fuentes de agua.',
                    imageUrl:
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-kQM4nZP5q5ZJ321XBevY6c3zYJkjo4.png',
                    category: 'Guardaparque',
                  ),
                  DonationCard(
                    title: 'Fundación Munasim Kullakita',
                    description:
                        'Descripción: Organización que trabaja por los derechos de los animales.',
                    imageUrl:
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-kQM4nZP5q5ZJ321XBevY6c3zYJkjo4.png',
                    category: 'Todos',
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
