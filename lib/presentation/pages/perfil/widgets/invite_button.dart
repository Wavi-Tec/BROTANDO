import 'package:flutter/material.dart';

class InviteButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const InviteButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF004D40), // Verde muy oscuro
                Color(0xFF00796B), // Verde medio
                Color(0xFF26A69A), // Verde claro
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Texto a la izquierda
              const Expanded(
                child: Text(
                  'Invita a un amigo',
                  style: TextStyle(
                    fontFamily: 'Flexo',
                    fontSize: 24,
                    fontWeight: FontWeight.w900, // ExtraBold
                    color: Color(0xFFFDD835), // Amarillo vibrante
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Logo a la derecha
              Image.asset(
                'assets/logoYasta.png',
                height: 45, // Ajusta el tamaño según necesites
                width: 45,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
