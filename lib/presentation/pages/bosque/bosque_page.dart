import 'dart:async';
import 'dart:math' as math; // sqrt, pow
import 'dart:math' show Point; // Point<int>
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BosquePage());
}

class BosquePage extends StatelessWidget {
  const BosquePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bosque Isométrico 5x5',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E3D34),
        useMaterial3: true,
      ),
      home: const IsometricTerrainScreen(),
    );
  }
}

/// Tipos de árbol (paleta)
class _TreeType {
  final int id;
  final String name;
  final Color trunk;
  final Color foliage;
  const _TreeType({
    required this.id,
    required this.name,
    required this.trunk,
    required this.foliage,
  });
}

/// Estado de un árbol plantado
class PlantedTree {
  final int typeId;
  final DateTime plantedAt;
  int stage; // 0 semilla, 1 plántula, 2 árbol
  DateTime nextPayoutAt;

  PlantedTree({
    required this.typeId,
    required this.plantedAt,
    required this.stage,
    required this.nextPayoutAt,
  });

  PlantedTree copyWith({
    int? typeId,
    DateTime? plantedAt,
    int? stage,
    DateTime? nextPayoutAt,
  }) => PlantedTree(
    typeId: typeId ?? this.typeId,
    plantedAt: plantedAt ?? this.plantedAt,
    stage: stage ?? this.stage,
    nextPayoutAt: nextPayoutAt ?? this.nextPayoutAt,
  );
}

class IsometricTerrainScreen extends StatefulWidget {
  const IsometricTerrainScreen({Key? key}) : super(key: key);

  @override
  State<IsometricTerrainScreen> createState() => _IsometricTerrainScreenState();
}

class _IsometricTerrainScreenState extends State<IsometricTerrainScreen> {
  // --- Transform/pan/zoom
  double _offsetX = 0.0;
  double _offsetY = 0.0;
  double _startX = 0.0;
  double _startY = 0.0;
  double _scale = 1.0;

  // Terreno fijo 5x5
  static const int _gridSize = 5;
  double _tileSize = 48;

  final GlobalKey _paintKey = GlobalKey();

  // Catálogo de árboles
  final List<_TreeType> _treeTypes = const [
    _TreeType(
      id: 0,
      name: 'Pino',
      trunk: Color(0xFF6B4423),
      foliage: Color(0xFF2E7D32),
    ),
    _TreeType(
      id: 1,
      name: 'Álamo',
      trunk: Color(0xFF704214),
      foliage: Color(0xFF66BB6A),
    ),
    _TreeType(
      id: 2,
      name: 'Cerezo',
      trunk: Color(0xFF5D4037),
      foliage: Color(0xFFF06292),
    ),
  ];
  int _selectedTreeId = 0;

  // Árboles plantados
  Map<Point<int>, PlantedTree> _planted = {};

  // Monedas
  int _coins = 0;

  // ---- Ajustes de crecimiento y pagos (modificar) ----
  static const Duration kToStage1 = Duration(
    seconds: 20,
  ); // tiempo Semilla -> Plántula
  static const Duration kToStage2 = Duration(
    seconds: 40,
  ); // tiempo Plántula -> Árbol (desde inicio total 60s)

  // Intervalos de pago por etapa (0 no paga, 1 y 2 sí)
  static const Duration kPayoutStage1Every = Duration(seconds: 15);
  static const Duration kPayoutStage2Every = Duration(seconds: 10);

  // Monedas por pago según etapa
  static const int kCoinsStage1 = 1;
  static const int kCoinsStage2 = 3;

  Timer? _tick;

  static const double minScale = 0.5;
  static const double maxScale = 2.5;

  @override
  void initState() {
    super.initState();
    // Timer de juego (tick) — revisa crecimiento y pagos
    _tick = Timer.periodic(const Duration(seconds: 1), (_) => _gameTick());
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  void _gameTick() {
    if (_planted.isEmpty) return;

    final now = DateTime.now();
    bool changed = false;
    int coinsEarned = 0;

    final updated = <Point<int>, PlantedTree>{};

    for (final entry in _planted.entries) {
      final key = entry.key;
      final tree = entry.value;

      // Actualizar etapa según tiempo transcurrido
      final elapsed = now.difference(tree.plantedAt);
      int stage = tree.stage;
      if (elapsed >= kToStage2) {
        stage = 2;
      } else if (elapsed >= kToStage1) {
        stage = 1;
      } else {
        stage = 0;
      }

      // Procesar pago si corresponde
      DateTime nextPayout = tree.nextPayoutAt;
      Duration? interval;
      int reward = 0;
      if (stage == 1) {
        interval = kPayoutStage1Every;
        reward = kCoinsStage1;
      } else if (stage == 2) {
        interval = kPayoutStage2Every;
        reward = kCoinsStage2;
      }

      if (interval != null) {
        // Si no se ha definido nextPayout aún (ej: venía de etapa 0)
        if (nextPayout.isBefore(now.subtract(const Duration(days: 365)))) {
          nextPayout = now.add(interval);
          changed = true;
        }
        // Pagar si pasó el tiempo (puede haberse acumulado más de un intervalo)
        while (now.isAfter(nextPayout) || now.isAtSameMomentAs(nextPayout)) {
          coinsEarned += reward;
          nextPayout = nextPayout.add(interval);
          changed = true;
        }
      } else {
        // Etapa 0: no paga. Poner nextPayout "vacío"
        nextPayout = DateTime.fromMillisecondsSinceEpoch(0);
      }

      // Guardar actualizado
      final newTree = tree.copyWith(stage: stage, nextPayoutAt: nextPayout);
      updated[key] = newTree;
    }

    if (changed || coinsEarned > 0) {
      setState(() {
        _planted = Map.of(updated);
        _coins += coinsEarned;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    _tileSize = math.max(28.0, deviceWidth / (_gridSize * 1.6));

    return Scaffold(
      body: Stack(
        children: [
          // Área interactiva
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (details) {
              _startX = details.globalPosition.dx - _offsetX;
              _startY = details.globalPosition.dy - _offsetY;
            },
            onPanUpdate: (details) {
              setState(() {
                _offsetX = details.globalPosition.dx - _startX;
                _offsetY = details.globalPosition.dy - _startY;
              });
            },
            onTapDown: _handleTapDown, // plantar semilla
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    Color(0xFF10B3A9), // tono principal azul verdoso
                    Color(0xFF15CFC2), // tono más claro
                    Color(0xFF0E8C83), // tono más oscuro
                    Color(0xFFEFBB17),
                  ],
                ),
              ),
              child: Center(
                child: Transform.scale(
                  scale: _scale,
                  child: Transform.translate(
                    offset: Offset(_offsetX, _offsetY),
                    child: IsometricTerrain(
                      key: _paintKey,
                      gridSize: _gridSize,
                      tileSize: _tileSize,
                      scale: _scale,
                      offsetX: _offsetX,
                      offsetY: _offsetY,
                      planted: _planted,
                      palette: {for (final t in _treeTypes) t.id: t},
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Selector de árbol
          Positioned(
            left: 16,
            top: 16 + MediaQuery.of(context).padding.top,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xCC0E1E19),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedTreeId,
                    items: _treeTypes.map((t) {
                      return DropdownMenuItem(
                        value: t.id,
                        child: Row(
                          children: [
                            _TreePreviewDot(foliage: t.foliage),
                            const SizedBox(width: 8),
                            Text(t.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => _selectedTreeId = v ?? 0),
                  ),
                ),
              ),
            ),
          ),

          // HUD de monedas
          Positioned(
            right: 16,
            top: 16 + MediaQuery.of(context).padding.top,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xCC0E1E19),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.monetization_on,
                    size: 18,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$_coins',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // Controles zoom/centrar
          Positioned(
            right: 16,
            bottom: 16 + MediaQuery.of(context).padding.bottom,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  onPressed: () => setState(() {
                    _scale = (_scale + 0.2).clamp(minScale, maxScale);
                  }),
                  backgroundColor: const Color(0xFFEFBB17),
                  child: const Icon(Icons.add, size: 20, color: Colors.white),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  onPressed: () => setState(() {
                    _scale = (_scale - 0.2).clamp(minScale, maxScale);
                  }),
                  backgroundColor: const Color(0xFFEFBB17),
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'center',
                  onPressed: () => setState(() {
                    _offsetX = 0.0;
                    _offsetY = 0.0;
                    _scale = 1.0;
                  }),
                  backgroundColor: const Color(0xFFEFBB17),
                  child: const Icon(
                    Icons.center_focus_strong,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTapDown(TapDownDetails details) {
    final renderObject = _paintKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox) return;

    final localInPaint = renderObject.globalToLocal(details.globalPosition);
    final size = renderObject.size;
    final canvasPoint = Offset(
      localInPaint.dx - size.width / 2,
      localInPaint.dy - size.height / 4,
    );

    const terrainHeight = IsometricTerrainPainter.terrainHeight;

    for (int y = 0; y < _gridSize; y++) {
      for (int x = 0; x < _gridSize; x++) {
        final isoX = (x - y) * _tileSize;
        final isoY = (x + y) * _tileSize * 0.5;

        final path = Path()
          ..moveTo(isoX, isoY - terrainHeight)
          ..lineTo(isoX + _tileSize, isoY + _tileSize * 0.5 - terrainHeight)
          ..lineTo(isoX, isoY + _tileSize - terrainHeight)
          ..lineTo(isoX - _tileSize, isoY + _tileSize * 0.5 - terrainHeight)
          ..close();

        if (path.contains(canvasPoint)) {
          final key = Point<int>(x, y);

          // Plantar nueva semilla
          final now = DateTime.now();
          final newTree = PlantedTree(
            typeId: _selectedTreeId,
            plantedAt: now,
            stage: 0, // semilla
            nextPayoutAt: DateTime.fromMillisecondsSinceEpoch(0), // aún no paga
          );

          // Reemplazamos el mapa para forzar repaint inmediato
          setState(() {
            _planted = {..._planted, key: newTree};
          });
          return;
        }
      }
    }
  }
}

class _TreePreviewDot extends StatelessWidget {
  final Color foliage;
  const _TreePreviewDot({required this.foliage, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: foliage,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24),
      ),
    );
  }
}

class IsometricTerrain extends StatelessWidget {
  final int gridSize;
  final double tileSize;
  final double scale;
  final double offsetX;
  final double offsetY;

  final Map<Point<int>, PlantedTree> planted;
  final Map<int, _TreeType> palette;

  const IsometricTerrain({
    Key? key,
    required this.gridSize,
    required this.tileSize,
    this.scale = 1.0,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    required this.planted,
    required this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        key: key,
        size: Size(gridSize * tileSize * 1.8, gridSize * tileSize * 1.8),
        painter: IsometricTerrainPainter(
          gridSize: gridSize,
          tileSize: tileSize,
          scale: scale,
          offsetX: offsetX,
          offsetY: offsetY,
          planted: planted,
          palette: palette,
        ),
      ),
    );
  }
}

class TileCullInfo {
  final bool isVisible;
  final bool drawTop;
  final bool drawRight;
  final bool drawLeft;

  const TileCullInfo({
    required this.isVisible,
    required this.drawTop,
    required this.drawRight,
    required this.drawLeft,
  });
}

class IsometricTerrainPainter extends CustomPainter {
  final int gridSize;
  final double tileSize;
  final double scale;
  final double offsetX;
  final double offsetY;

  final Map<Point<int>, PlantedTree> planted;
  final Map<int, _TreeType> palette;

  static const double terrainHeight = 12.0;

  IsometricTerrainPainter({
    required this.gridSize,
    required this.tileSize,
    this.scale = 1.0,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    required this.planted,
    required this.palette,
  });

  List<TileCullInfo>? _cachedCullInfo;
  Rect? _cachedViewport;

  static final _rightFacePaint = Paint()
    ..shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF7D5A3C), Color(0xFF6B4423), Color(0xFF5A3818)],
    ).createShader(Rect.fromLTWH(0, 0, 1, 1));

  static final _leftFacePaint = Paint()
    ..shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF9B6E4A), Color(0xFF8B5A3C), Color(0xFF7D5A3C)],
    ).createShader(Rect.fromLTWH(0, 0, 1, 1));

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 4);

    _drawShadow(canvas);

    final viewport = _calculateViewport(size);
    if (_cachedCullInfo == null || _cachedViewport != viewport) {
      _cachedCullInfo = _calculateCull(viewport);
      _cachedViewport = viewport;
    }

    final cull = _cachedCullInfo!;
    int i = 0;
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        final info = cull[i++];
        if (!info.isVisible) continue;
        _drawTile(canvas, x, y, info);
      }
    }

    // Dibujar árboles plantados por encima
    for (final entry in planted.entries) {
      final x = entry.key.x;
      final y = entry.key.y;
      if (x < 0 || y < 0 || x >= gridSize || y >= gridSize) continue;

      final isoX = (x - y) * tileSize;
      final isoY = (x + y) * tileSize * 0.5;
      final centerTop = Offset(isoX, isoY + tileSize * 0.5 - terrainHeight);
      _drawTree(canvas, centerTop, entry.value);
    }
  }

  Rect _calculateViewport(Size size) {
    final margin = 100.0 / scale;
    final width = (size.width / scale);
    final height = (size.height / scale);
    final cx = -offsetX / scale;
    final cy = -offsetY / scale;
    return Rect.fromCenter(
      center: Offset(cx, cy),
      width: width + margin * 2,
      height: height + margin * 2,
    );
  }

  List<TileCullInfo> _calculateCull(Rect viewport) {
    final list = <TileCullInfo>[];
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        final isoX = (x - y) * tileSize;
        final isoY = (x + y) * tileSize * 0.5;

        final rect = Rect.fromCenter(
          center: Offset(isoX, isoY),
          width: tileSize * 2,
          height: tileSize + terrainHeight * 2,
        );

        final visible = viewport.overlaps(rect);
        bool drawRight = x == gridSize - 1 || y == gridSize - 1
            ? true
            : !(x < gridSize - 1 && y < gridSize - 1);
        bool drawLeft = y == gridSize - 1 || x == 0
            ? true
            : !(x > 0 && y < gridSize - 1);

        list.add(
          TileCullInfo(
            isVisible: visible,
            drawTop: true,
            drawRight: drawRight,
            drawLeft: drawLeft,
          ),
        );
      }
    }
    return list;
  }

  void _drawShadow(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.30)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(0, gridSize * tileSize * 0.6),
        width: gridSize * tileSize * 1.3,
        height: gridSize * tileSize * 0.5,
      ),
      paint,
    );
  }

  void _drawTile(Canvas canvas, int x, int y, TileCullInfo info) {
    final isoX = (x - y) * tileSize;
    final isoY = (x + y) * tileSize * 0.5;

    if (info.drawTop) _drawTop(canvas, isoX, isoY, x, y);
    if (info.drawRight) _drawRight(canvas, isoX, isoY);
    if (info.drawLeft) _drawLeft(canvas, isoX, isoY);
    if (info.drawTop) _drawGrass(canvas, isoX, isoY, x, y);
  }

  void _drawTop(Canvas canvas, double isoX, double isoY, int x, int y) {
    final path = Path()
      ..moveTo(isoX, isoY - terrainHeight)
      ..lineTo(isoX + tileSize, isoY + tileSize * 0.5 - terrainHeight)
      ..lineTo(isoX, isoY + tileSize - terrainHeight)
      ..lineTo(isoX - tileSize, isoY + tileSize * 0.5 - terrainHeight)
      ..close();

    final paint = Paint()
      ..color = _grassColor(x, y)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  void _drawRight(Canvas canvas, double isoX, double isoY) {
    final path = Path()
      ..moveTo(isoX, isoY + tileSize - terrainHeight)
      ..lineTo(isoX + tileSize, isoY + tileSize * 0.5 - terrainHeight)
      ..lineTo(isoX + tileSize, isoY + tileSize * 0.5 + terrainHeight)
      ..lineTo(isoX, isoY + tileSize + terrainHeight)
      ..close();
    canvas.drawPath(path, _rightFacePaint);
  }

  void _drawLeft(Canvas canvas, double isoX, double isoY) {
    final path = Path()
      ..moveTo(isoX, isoY + tileSize - terrainHeight)
      ..lineTo(isoX - tileSize, isoY + tileSize * 0.5 - terrainHeight)
      ..lineTo(isoX - tileSize, isoY + tileSize * 0.5 + terrainHeight)
      ..lineTo(isoX, isoY + tileSize + terrainHeight)
      ..close();
    canvas.drawPath(path, _leftFacePaint);
  }

  Color _grassColor(int x, int y) {
    final seed = (x * 7 + y * 13) % 10;
    const colors = [
      Color(0xFFA3D95A),
      Color(0xFF9FD64A),
      Color(0xFF8BC34A),
      Color(0xFFAED581),
      Color(0xFF7CB342),
      Color(0xFF9CCC65),
    ];
    return colors[seed % colors.length];
  }

  void _drawGrass(Canvas canvas, double isoX, double isoY, int x, int y) {
    final seed = (x * 11 + y * 17);
    final center = gridSize / 2;
    final dist = math.sqrt(math.pow(x - center, 2) + math.pow(y - center, 2));
    final detail = dist < gridSize * 0.3
        ? (gridSize > 15 ? 6 : (gridSize > 10 ? 8 : 10))
        : dist < gridSize * 0.6
        ? (gridSize > 15 ? 4 : (gridSize > 10 ? 6 : 8))
        : (gridSize > 15 ? 2 : (gridSize > 10 ? 4 : 6));

    final grassPaint = Paint()
      ..color = Colors.green.shade900.withOpacity(0.3)
      ..strokeWidth = 0.9
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < detail; i++) {
      final dx = ((seed + i * 7) % 50 - 25).toDouble();
      final dy = ((seed + i * 11) % 35 - 17).toDouble();
      canvas.drawLine(
        Offset(isoX + dx, isoY + tileSize * 0.5 + dy - terrainHeight),
        Offset(isoX + dx + 1, isoY + tileSize * 0.5 + dy - terrainHeight - 3),
        grassPaint,
      );
    }
  }

  void _drawTree(Canvas canvas, Offset centerTop, PlantedTree tree) {
    final t = palette[tree.typeId];
    if (t == null) return;

    // Tamaños base
    double trunkH = tileSize * 0.32;
    double trunkW = tileSize * 0.10;
    double crownR = tileSize * 0.32;

    // Escala por etapa (0 semilla, 1 plántula, 2 árbol)
    if (tree.stage == 0) {
      // Semilla: pequeño brote y semilla
      final seedPaint = Paint()..color = t.trunk.withOpacity(0.9);
      final sproutPaint = Paint()..color = t.foliage;

      // Semilla
      canvas.drawCircle(
        centerTop.translate(0, -tileSize * 0.05),
        tileSize * 0.05,
        seedPaint,
      );
      // Brote (dos hojas)
      canvas.drawCircle(
        centerTop.translate(-tileSize * 0.06, -tileSize * 0.15),
        tileSize * 0.06,
        sproutPaint,
      );
      canvas.drawCircle(
        centerTop.translate(tileSize * 0.06, -tileSize * 0.15),
        tileSize * 0.06,
        sproutPaint,
      );
      return;
    } else if (tree.stage == 1) {
      // Plántula
      trunkH *= 0.6;
      trunkW *= 0.8;
      crownR *= 0.6;
    } else {
      // Árbol final
      // (sin cambios)
    }

    final trunkPaint = Paint()..color = t.trunk;
    final foliagePaint = Paint()
      ..color = t.foliage
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);

    // Tronco
    final trunkRect = Rect.fromCenter(
      center: Offset(centerTop.dx, centerTop.dy - trunkH * 0.2),
      width: trunkW,
      height: trunkH,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(trunkRect, const Radius.circular(2)),
      trunkPaint,
    );

    // Copa
    canvas.drawCircle(
      Offset(centerTop.dx, centerTop.dy - trunkH - crownR * 0.1),
      crownR,
      foliagePaint,
    );
    canvas.drawCircle(
      Offset(centerTop.dx - crownR * 0.6, centerTop.dy - trunkH),
      crownR * 0.75,
      foliagePaint,
    );
    canvas.drawCircle(
      Offset(centerTop.dx + crownR * 0.6, centerTop.dy - trunkH),
      crownR * 0.75,
      foliagePaint,
    );
  }

  @override
  bool shouldRepaint(covariant IsometricTerrainPainter oldDelegate) =>
      oldDelegate.gridSize != gridSize ||
      oldDelegate.tileSize != tileSize ||
      oldDelegate.scale != scale ||
      oldDelegate.offsetX != offsetX ||
      oldDelegate.offsetY != offsetY ||
      !mapEquals(oldDelegate.planted, planted); // ✅ repinta si cambia contenido
}
