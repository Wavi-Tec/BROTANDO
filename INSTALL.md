INSTALL.md — Brotando | Guía rápida de instalación
✅ Requisitos

Flutter SDK (estable) y Dart
Verifica:

flutter doctor

Android Studio (si compilas para Android) o Chrome (para Web).

Acceso a Internet para descargar paquetes de pub.dev.

Si tu red bloquea pub.dev, usa el mirror al final (Troubleshooting).
Abre tu proyecto en VS Code (la carpeta BROTANDO).

Abre pubspec.yaml.

En la esquina superior derecha del editor verás un ícono de descarga ⬇️.

Haz clic ahí.

VS Code ejecutará flutter pub get por ti.

Espera el mensaje en la barra de estado/terminal: “Pub get succeeded” (o similar).

Cuando termine, ejecuta el proyecto:

Opción rápida: presiona F5 (Run > Start Debugging).

O el botón de ▶ Run en la barra superior.

Si vas a web: selecciona Chrome en la barra de dispositivos de VS Code antes de correr.

Listo. Si el botón no aparece o falla la red, abre la terminal integrada y corre flutter pub get, pero con el botón debería bastar.

Este INSTALL.md cubre solo la app Flutter.

Para el backend (Supabase/NestJS), Tiene su propio README.