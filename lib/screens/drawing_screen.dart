import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/coloring_shape.dart';
import '../theme.dart';

class DrawingScreen extends StatefulWidget {
  final ColoringShape shape;
  const DrawingScreen({super.key, required this.shape});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  Color _selectedColor = Colors.yellow;
  List<DrawingPoint?> _points = [];
  double _strokeWidth = 10.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.appTitle,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
            color: AppTheme.primaryContainer,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: _finishDrawing,
              icon: const Icon(Icons.check_circle),
              label: Text(l10n.done),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.tertiary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Screenshot(
                controller: _screenshotController,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Grid background pattern
                      Positioned.fill(
                        child: CustomPaint(
                          painter: GridPainter(),
                        ),
                      ),
                      // The drawing area
                      GestureDetector(
                        onPanStart: (details) {
                          setState(() {
                            _points.add(
                              DrawingPoint(
                                offset: details.localPosition,
                                paint: Paint()
                                  ..color = _selectedColor
                                  ..isAntiAlias = true
                                  ..strokeWidth = _strokeWidth
                                  ..strokeCap = StrokeCap.round,
                              ),
                            );
                          });
                        },
                        onPanUpdate: (details) {
                          setState(() {
                            _points.add(
                              DrawingPoint(
                                offset: details.localPosition,
                                paint: Paint()
                                  ..color = _selectedColor
                                  ..isAntiAlias = true
                                  ..strokeWidth = _strokeWidth
                                  ..strokeCap = StrokeCap.round,
                              ),
                            );
                          });
                        },
                        onPanEnd: (details) {
                          setState(() {
                            _points.add(null);
                          });
                        },
                        child: CustomPaint(
                          painter: DrawingPainter(points: _points),
                          size: Size.infinite,
                        ),
                      ),
                      // The outline image (using mixBlendMode to allow drawing "under" or "over" it)
                      // In a real app, you might want to use a transparent PNG or an SVG.
                      Center(
                        child: IgnorePointer(
                          child: Opacity(
                            opacity: 0.8,
                            child: Image.network(
                              widget.shape.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      // Floating Toolbar Left
                      Positioned(
                        left: 16,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(48),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _ToolButton(
                                  icon: Icons.brush,
                                  isActive: true,
                                  onTap: () {},
                                ),
                                const SizedBox(height: 12),
                                _ToolButton(
                                  icon: Icons.format_paint,
                                  isActive: false,
                                  onTap: () {},
                                ),
                                const SizedBox(height: 12),
                                _ToolButton(
                                  icon: Icons.auto_fix_normal,
                                  isActive: false,
                                  onTap: () => setState(() => _points.clear()),
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
            ),
          ),
          // Color Palette
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.chooseColor,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.palette, color: AppTheme.primary),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _Crayon(color: Colors.red, isSelected: _selectedColor == Colors.red, onTap: () => _setColor(Colors.red)),
                      _Crayon(color: Colors.orange, isSelected: _selectedColor == Colors.orange, onTap: () => _setColor(Colors.orange)),
                      _Crayon(color: Colors.yellow, isSelected: _selectedColor == Colors.yellow, onTap: () => _setColor(Colors.yellow)),
                      _Crayon(color: Colors.green, isSelected: _selectedColor == Colors.green, onTap: () => _setColor(Colors.green)),
                      _Crayon(color: Colors.blue, isSelected: _selectedColor == Colors.blue, onTap: () => _setColor(Colors.blue)),
                      _Crayon(color: Colors.purple, isSelected: _selectedColor == Colors.purple, onTap: () => _setColor(Colors.purple)),
                      _Crayon(color: Colors.pink, isSelected: _selectedColor == Colors.pink, onTap: () => _setColor(Colors.pink)),
                      _Crayon(color: Colors.brown, isSelected: _selectedColor == Colors.brown, onTap: () => _setColor(Colors.brown)),
                      _Crayon(color: Colors.black, isSelected: _selectedColor == Colors.black, onTap: () => _setColor(Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  Future<void> _finishDrawing() async {
    final image = await _screenshotController.capture();
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);
      
      if (mounted) {
        Navigator.pushNamed(context, '/success', arguments: imagePath);
      }
    }
  }
}

class _ToolButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _ToolButton({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryContainer : AppTheme.surfaceContainerHighest,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? AppTheme.onPrimaryContainer : AppTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _Crayon extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _Crayon({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 40,
        height: isSelected ? 110 : 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
        ),
      ),
    );
  }
}

class DrawingPoint {
  final Offset offset;
  final Paint paint;
  DrawingPoint({required this.offset, required this.paint});
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> points;
  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!.offset, points[i + 1]!.offset, points[i]!.paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(ui.PointMode.points, [points[i]!.offset], points[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 1.0;

    const spacing = 24.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
