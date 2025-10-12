import 'package:flutter/material.dart';
import '../../../../core/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final QuizCategory category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  Alignment _getImageAlignment() {
    switch (category.id) {
      case '1': // Aleatorio - Superior derecha
        return Alignment.topRight;
      case '2': // Ambiental - Centro
        return Alignment.center;
      case '3': // Finanzas - Inferior izquierda
        return Alignment.bottomLeft;
      case '4': // Equidad de Género - Superior izquierda
        return Alignment.topLeft;
      default:
        return Alignment.center;
    }
  }

  // Tamaño de la imagen (usado realmente ahora)
  double _getImageSize() {
    switch (category.id) {
      case '1':
        return 240; // 80 * 3
      case '2':
        return 300; // 100 * 3
      case '3':
        return 210; // 70 * 3
      case '4':
        return 270; // 90 * 3
      default:
        return 240;
    }
  }

  // 🔧 Filtro para subir un poco saturación/contraste (opcional)
  ColorFilter _vibranceFilter() {
    // Ajustes suaves: saturación 1.25, contraste 1.08, brillo +0.02
    const s = 1.25; // saturation
    const c = 1.08; // contrast
    const b = 0.02; // brightness
    // Matriz base para saturación
    final rWeight = 0.2126, gWeight = 0.7152, bWeight = 0.0722;
    final invS = (1 - s);
    final r = invS * rWeight;
    final g = invS * gWeight;
    final bl = invS * bWeight;

    // Matriz saturación
    final sat = <double>[
      r + s,
      g,
      bl,
      0,
      0,
      r,
      g + s,
      bl,
      0,
      0,
      r,
      g,
      bl + s,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ];

    // Matriz contraste + brillo (aprox simple)
    final t = 0.5 * (1 - c); // trasladar para contraste
    final contr = <double>[
      c,
      0,
      0,
      0,
      b + t,
      0,
      c,
      0,
      0,
      b + t,
      0,
      0,
      c,
      0,
      b + t,
      0,
      0,
      0,
      1,
      0,
    ];

    // Multiplicamos matrices sat * contr (orden aproximado suficiente para este caso)
    List<double> mul(List<double> a, List<double> b) {
      final out = List<double>.filled(20, 0);
      for (int row = 0; row < 4; row++) {
        for (int col = 0; col < 5; col++) {
          out[row * 5 + col] =
              a[row * 5 + 0] * b[0 * 5 + col] +
              a[row * 5 + 1] * b[1 * 5 + col] +
              a[row * 5 + 2] * b[2 * 5 + col] +
              a[row * 5 + 3] * b[3 * 5 + col] +
              (col == 4 ? a[row * 5 + 4] : 0);
        }
      }
      // última fila fija (alfa)
      out[15] = 0;
      out[16] = 0;
      out[17] = 0;
      out[18] = 1;
      out[19] = 0;
      return out;
    }

    final m = mul(sat, contr);
    return ColorFilter.matrix(m);
  }

  @override
  Widget build(BuildContext context) {
    final imgSize = _getImageSize();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // mantiene bordes
          child: Stack(
            children: [
              // 🖼️ Imagen de fondo GRANDE y más “viva”
              Positioned.fill(
                child: Align(
                  alignment: _getImageAlignment(),
                  child: ColorFiltered(
                    colorFilter:
                        _vibranceFilter(), // 👉 quita esto si no lo quieres
                    child: Image.asset(
                      'assets/imagesG/imgcat.png',
                      width: imgSize,
                      height: imgSize,
                      fit: BoxFit.contain, // conserva proporciones
                      filterQuality: FilterQuality.high, // más nitidez
                      isAntiAlias: true,
                    ),
                  ),
                ),
              ),

              // ✏️ Texto encima (con sombra para legibilidad si la img es muy clara)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Flexo',
                      color: category.id == '4' ? Colors.black : Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      shadows: const [
                        Shadow(
                          blurRadius: 6,
                          offset: Offset(0, 2),
                          color: Color(0x66000000),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
