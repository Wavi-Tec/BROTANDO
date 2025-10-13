README.md — Brotando 🌱

Gamifica el aprendizaje y el uso de tu billetera: gana puntos por responder trivias, cuídalos con árboles virtuales y canjea por cupones, donaciones o ¡plantar un árbol real!

🎯 Visión

Brotando es una app (Flutter) que convierte acciones cotidianas en impacto positivo.
Aprendes (trivias), te premias (puntos → monedas), haces compras con beneficios y apoyas causas reales (plantación de árboles con ONG aliadas).

✨ Qué hace el usuario

Juega y aprende: trivias/encuestas en tres ejes:

Finanzas

Cuidado del medioambiente

Equidad de género

Gana puntos por:

Responder correctamente

Completar misiones/encuestas

(Opcional) Realizar transacciones en la billetera aliada

Cuidar su bosque virtual (árboles que generan puntos pasivos)

Convierte puntos → monedas (tasa configurable).

Canjea monedas por:

Árboles de diferentes rarezas (producen más puntos)

Cupones/Descuentos de comercios aliados

Donaciones o Árbol Real con ONG (foto, ubicación y certificado digital)

🧭 Flujo del producto

Registro/Login
Se guarda un token de sesión de forma segura (SecureStorage).

Bootstrap /me
La app trae perfil, puntos, monedas, bosque y canjes.

Juego (Quiz/Encuestas)
Enviar respuesta → validar → sumar puntos → mostrar explicación.

Conversión
Puntos → Monedas (registra en libros/ledger).

Compras internas
Comprar árboles (se agregan a tu bosque y generan puntos pasivos).

Canjes externos
Cupones/Descuentos, Donaciones o Árbol Real (ONG sube foto/GPS/certificado).

Notificaciones (opcional)
Avisos de canje cumplido, bonus, nuevas misiones.

🏗️ Arquitectura (alto nivel)
Flutter App (Android/Web)
  ├─ UI: Login | Quiz | Bosque | Canjes | Perfil
  ├─ SecureStorage: token de sesión
  └─ API REST: Authorization: Bearer <token>
               ↓
Backend (a elección del equipo)
  A) PostgREST/Supabase (rápido para MVP)
     - Auth + RLS
     - Tablas y RPC
     - Storage (fotos/certificados)
  ó
  B) NestJS Game API (modular)
     - Guards (token), Scopes (permisos)
     - Módulos: game, wallet, trees, rewards, users
     - DB: PostgreSQL
               ↓
PostgreSQL (datos)
  - users, profiles
  - points_ledger (inmutable)
  - coin_wallet + coin_ledger (inmutable)
  - tree_catalog, user_trees
  - rewards, redemptions
  - partners, real_tree_plantings (foto/GPS/certificado)

🗃️ Modelo de datos (resumen funcional)

users / profiles: identidad del jugador y progreso.

points_ledger: cada movimiento de puntos (suma/resta) para auditoría.

coin_wallet / coin_ledger: monedas del usuario y su histórico.

tree_catalog: lista de árboles (rareza, producción por hora, precio en monedas).

user_trees: árboles adquiridos por cada usuario (etapa, última producción).

rewards / redemptions: catálogo y canjes (COUPON, DISCOUNT, DONATION, REAL_TREE).

partners / real_tree_plantings: ONG/comercio y pruebas del impacto real.

🔐 Seguridad (cliente)

SecureStorage para token (Android Keystore / iOS Keychain / Web secure alternatives).

Todos los requests llevan Authorization: Bearer <token>.

📱 Módulos de la app (Flutter)

Home/Bosque: estado general, árboles, puntos/monedas.

Jugar: categorías → preguntas → explicación → progreso.

Canjear: catálogo (árboles, cupones, donaciones, árbol real).

Perfil/Historial: ledger de puntos y monedas, logros.

Navegación: go_router.

🧩 Integración con aliados

Comercios: emiten cupones/beneficios (QR/código).

ONG: validan plantaciones reales y cargan foto + ubicación + certificado.

Panel (opcional, con Next.js): administración de contenido, catálogos y redenciones.

📚 Instalación y ejecución

➡️ Sigue INSTALL.md
 para instalar dependencias y ejecutar el proyecto.