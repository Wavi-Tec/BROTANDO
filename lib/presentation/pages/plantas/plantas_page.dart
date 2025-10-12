import 'package:flutter/material.dart';
import 'widgets/plant_card.dart';
import 'widgets/plant_tag_widget.dart';
import 'widgets/pagination_controls.dart';
import 'widgets/user_stats_header.dart';
import 'widgets/plant_search_bar.dart';
import 'widgets/purchase_button.dart';

class PlantasPage extends StatefulWidget {
  const PlantasPage({super.key});

  @override
  State<PlantasPage> createState() => _PlantasPageState();
}

class _PlantasPageState extends State<PlantasPage> {
  late PageController _pageController;
  int currentPage = 0;
  TextEditingController searchController = TextEditingController();
  List<Plant> filteredPlants = [];

  // Lista de plantas
  final List<Plant> plants = [
    Plant(
      name: 'Toborochi',
      description:
          'es un árbol sudamericano conocido por su tronco abultado que almacena agua y su tronco cubierto de aguijones cónicos. Alcanza entre 15 y 30 metros, tiene follaje caduco, y sus flores, que florecen hacia el fin del invierno o principios de otoño, son de colores cremas o rosados.',
      imageUrl:
          'https://images.unsplash.com/photo-1509937528035-ad76254b0356?w=150&h=150&fit=crop',
      price: 50.0,
      tags: [
        PlantTag(label: 'Floral', color: const Color(0xFF9C27B0)),
        PlantTag(
          label: '50 monedas',
          color: const Color(0xFFFDB913),
          isCoinTag: true,
        ),
        PlantTag(label: 'Riego semanal', color: const Color(0xFF2196F3)),
        PlantTag(label: 'Épico', color: const Color(0xFFF44336)),
      ],
    ),
    Plant(
      name: 'Cecropia',
      description:
          'es un género de árboles tropicales de crecimiento rápido. Sus hojas grandes y palmadas proporcionan sombra excelente. Son pioneros en la regeneración de bosques y tienen una relación simbiótica con hormigas que viven en sus troncos huecos.',
      imageUrl:
          'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=150&h=150&fit=crop',
      price: 75.0,
      tags: [
        PlantTag(label: 'Tropical', color: const Color(0xFF4CAF50)),
        PlantTag(
          label: '75 monedas',
          color: const Color(0xFFFDB913),
          isCoinTag: true,
        ),
        PlantTag(label: 'Riego frecuente', color: const Color(0xFF03A9F4)),
        PlantTag(label: 'Raro', color: const Color(0xFFFF9800)),
      ],
    ),
    Plant(
      name: 'Tajibo Amarillo',
      description:
          'es un árbol nativo de Bolivia conocido por sus espectaculares flores amarillas que aparecen antes que las hojas. Es el árbol nacional de Bolivia y puede alcanzar hasta 30 metros de altura. Sus flores doradas transforman el paisaje durante la época de floración.',
      imageUrl:
          'https://images.unsplash.com/photo-1574263867128-3736d83b1b32?w=150&h=150&fit=crop',
      price: 100.0,
      tags: [
        PlantTag(label: 'Nacional', color: const Color(0xFFFFD700)),
        PlantTag(
          label: '100 monedas',
          color: const Color(0xFFFDB913),
          isCoinTag: true,
        ),
        PlantTag(label: 'Riego moderado', color: const Color(0xFF2196F3)),
        PlantTag(label: 'Legendario', color: const Color(0xFF9C27B0)),
      ],
    ),
    Plant(
      name: 'Mara',
      description:
          'es un árbol maderable muy valorado por su madera de alta calidad. Puede crecer hasta 45 metros de altura y es una especie en peligro debido a la sobreexplotación. Sus hojas son compuestas y produce pequeñas flores blancas. Es fundamental para la conservación forestal.',
      imageUrl:
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=150&h=150&fit=crop',
      price: 120.0,
      tags: [
        PlantTag(label: 'Maderable', color: const Color(0xFF8D6E63)),
        PlantTag(
          label: '120 monedas',
          color: const Color(0xFFFDB913),
          isCoinTag: true,
        ),
        PlantTag(label: 'Riego escaso', color: const Color(0xFF607D8B)),
        PlantTag(label: 'En peligro', color: const Color(0xFFF44336)),
      ],
    ),
    Plant(
      name: 'Algarrobo',
      description:
          'es un árbol leguminoso adaptado a climas secos. Sus vainas contienen semillas comestibles ricas en proteínas. Es muy resistente a la sequía y sus raíces pueden extenderse hasta 50 metros. Sus flores pequeñas y amarillas atraen a las abejas.',
      imageUrl:
          'https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=150&h=150&fit=crop',
      price: 40.0,
      tags: [
        PlantTag(label: 'Resistente', color: const Color(0xFF795548)),
        PlantTag(
          label: '40 monedas',
          color: const Color(0xFFFDB913),
          isCoinTag: true,
        ),
        PlantTag(label: 'Sin riego', color: const Color(0xFF9E9E9E)),
        PlantTag(label: 'Común', color: const Color(0xFF4CAF50)),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    filteredPlants = plants; // Initialize with all plants
    searchController.addListener(_filterPlants);
  }

  @override
  void dispose() {
    _pageController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _filterPlants() {
    setState(() {
      final query = searchController.text.toLowerCase();
      if (query.isEmpty) {
        filteredPlants = plants;
      } else {
        filteredPlants = plants.where((plant) {
          return plant.name.toLowerCase().contains(query) ||
              plant.description.toLowerCase().contains(query) ||
              plant.tags.any((tag) => tag.label.toLowerCase().contains(query));
        }).toList();
      }

      // Reset to first page when filtering
      if (filteredPlants.isNotEmpty) {
        currentPage = 0;
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with points and coins
            UserStatsHeader(points: 15000, coins: 500),

            // Search bar
            PlantSearchBar(
              controller: searchController,
              onClear: () {
                searchController.clear();
              },
            ),

            const SizedBox(height: 16),

            // Search results indicator
            if (searchController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${filteredPlants.length} resultado${filteredPlants.length != 1 ? 's' : ''} encontrado${filteredPlants.length != 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            const SizedBox(height: 5),

            // Scrollable content with PageView
            Expanded(
              child: filteredPlants.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No se encontraron plantas',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Intenta con otro término de búsqueda',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemCount: filteredPlants.length,
                      itemBuilder: (context, index) {
                        final plant = filteredPlants[index];
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: PlantCard(plant: plant),
                          ),
                        );
                      },
                    ),
            ),

            // Pagination controls
            PaginationControls(
              currentPage: currentPage,
              totalPages: plants.length,
              pageController: _pageController,
              onPrevious: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              onNext: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),

            // Bottom purchase button
            PurchaseButton(
              price: filteredPlants[currentPage].price,
              onTap: () {
                _showPurchaseConfirmation();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseConfirmation() {
    final currentPlant = filteredPlants[currentPage];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 76, 175, 158),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_florist,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '¿Comprar ${currentPlant.name}?',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E5A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDB913),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '\$',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${currentPlant.price.toStringAsFixed(0)} monedas',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showPurchaseSuccess();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          76,
                          175,
                          158,
                        ),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Comprar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPurchaseSuccess() {
    final currentPlant = filteredPlants[currentPage];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 16),
              const Text(
                '¡Compra exitosa!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E5A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Has adquirido semillas de ${currentPlant.name}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Continuar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
