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
            const SizedBox(height: 20), //es para dar espacio arriba
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
                        'Campaña ciudadana que recauda fondos para equipar a los bomberos forestales que luchan contra los incendios en la Chiquitanía y a los refugios de animales.',
                    imageUrl:
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-kQM4nZP5q5ZJ321XBevY6c3zYJkjo4.png',
                    category: 'Bomberos',
                    donationCount: 127,
                    targetAmount: 50000,
                    currentAmount: 35000,
                  ),
                  DonationCard(
                    title: 'Sembramos VIDA en la Chiquitanía - Unión Verde',
                    description:
                        'Programa impulsado por la Unión Europea bajo los Objetivos de Desarrollo Sostenible (ODS) que busca la restauración y adaptación al cambio climático.',
                    imageUrl:
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-kQM4nZP5q5ZJ321XBevY6c3zYJkjo4.png',
                    category: 'Reforestar',
                    donationCount: 89,
                    targetAmount: 25000,
                    currentAmount: 18500,
                  ),
                  DonationCard(
                    title: 'Fundación Amigos de la Naturaleza (FAN Bolivia)',
                    description:
                        'Organización dedicada a la conservación de la biodiversidad boliviana, que apoya a áreas protegidas y comunidades locales en la protección de bosques.',
                    imageUrl:
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-kQM4nZP5q5ZJ321XBevY6c3zYJkjo4.png',
                    category: 'Guardaparque',
                    donationCount: 203,
                    targetAmount: 75000,
                    currentAmount: 45000,
                  ),
                  DonationCard(
                    title: 'Fundación Munasim Kullakita',
                    description:
                        'Organización que trabaja por los derechos de los animales.',
                    imageUrl:
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-kQM4nZP5q5ZJ321XBevY6c3zYJkjo4.png',
                    category: 'Incendios',
                    donationCount: 56,
                    targetAmount: 15000,
                    currentAmount: 8900,
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
