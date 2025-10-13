import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userImage;
  final int plantsCount;
  final String plantsStatus;
  final VoidCallback? onEditPressed;

  const ProfileCard({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userImage,
    this.plantsCount = 5,
    this.plantsStatus = 'Creciendo felices',
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        children: [
          // Profile Picture centered above
          Stack(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1DD1A1), Color(0xFF10AC84)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1DD1A1).withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(userImage, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 25,
                      color: Color.fromARGB(255, 36, 36, 36),
                    ),
                    onPressed: onEditPressed,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // User Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // 🌿 Plants Card mejorado
              // 🌿 Plants Card mejorado
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCF7E3),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max, // ← Cambiar de min a max
                  mainAxisAlignment:
                      MainAxisAlignment.center, // ← Centrar contenido
                  children: [
                    // Icono o emoji principal
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFB2E8C5),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        // ← Para que la imagen sea circular
                        child: Image.asset(
                          'assets/imagesG/p1.png', // ← Ruta relativa desde la raíz del proyecto
                          width: 40, // ← Ajusta el tamaño
                          height: 40,
                          fit: BoxFit.cover, // ← Para que cubra todo el espacio
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Textos
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Flexo',
                              color: Color.fromARGB(255, 12, 54, 15),
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '$plantsCount', // 👈 solo el número
                                style: const TextStyle(
                                  fontSize:
                                      25, // 👈 tamaño más grande SOLO del número
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ' Plantas', // 👈 mantiene la palabra normal
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          plantsStatus,
                          style: const TextStyle(
                            fontFamily: 'Flexo',
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
