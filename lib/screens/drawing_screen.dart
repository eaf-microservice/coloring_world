import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_math/vector_math_64.dart' show Matrix4, Vector3;
import '../l10n/app_localizations.dart';
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
  late TransformationController _transformationController;
  Color _selectedColor = Colors.yellow;
  List<DrawingPoint?> _points = [];
  double _strokeWidth = 10.0;
  double _zoomLevel = 1.0;
  int _pointerCount = 0;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.translate('appTitle'),
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
            color: AppTheme.primaryContainer,
          ),
        ),
        actions: [
          Tooltip(
            message: l10n.translate('undo'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton.icon(
                onPressed: _undo,
                icon: const Icon(Icons.undo, size: 20),
                label: Text(
                  l10n.translate('undo'),
                  style: const TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                ),
              ),
            ),
          ),
          // Tooltip(
          //   message: l10n.translate('clear'),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 4),
          //     child: ElevatedButton.icon(
          //       onPressed: () => setState(() => _points.clear()),
          //       icon: const Icon(Icons.refresh, size: 20),
          //       label: Text(
          //         l10n.translate('clear'),
          //         style: const TextStyle(fontSize: 12),
          //       ),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.orange,
          //         foregroundColor: Colors.black,
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 8,
          //           vertical: 8,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Tooltip(
            message: l10n.translate('done'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton.icon(
                onPressed: _finishDrawing,
                icon: const Icon(Icons.check_circle, size: 20),
                label: Text(
                  l10n.translate('done'),
                  style: const TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.tertiary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Zoom Controls
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _zoomOut,
                  icon: const Icon(Icons.zoom_out, color: AppTheme.primary),
                  tooltip: 'Zoom Out',
                ),
                Text(
                  '${(_zoomLevel * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _zoomIn,
                  icon: const Icon(Icons.zoom_in, color: AppTheme.primary),
                  tooltip: 'Zoom In',
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _resetZoom,
                  icon: const Icon(Icons.refresh, color: Colors.blue),
                  tooltip: 'Reset Zoom',
                ),
              ],
            ),
          ),
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
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        // Grid background pattern
                        Positioned.fill(
                          child: CustomPaint(painter: GridPainter()),
                        ),
                        // The interactive drawing area with zoom
                        InteractiveViewer(
                          transformationController: _transformationController,
                          minScale: 1.0,
                          maxScale: 3.0,
                          boundaryMargin: const EdgeInsets.all(20),
                          onInteractionEnd: (details) {
                            final scale = _transformationController.value
                                .getMaxScaleOnAxis();
                            setState(() {
                              _zoomLevel = scale;
                            });
                          },
                          child: Listener(
                            onPointerDown: (event) {
                              _pointerCount++;
                            },
                            onPointerUp: (event) {
                              _pointerCount--;
                              if (_pointerCount == 0) {
                                _points.add(null);
                              }
                            },
                            onPointerCancel: (event) {
                              _pointerCount--;
                              if (_pointerCount == 0) {
                                _points.add(null);
                              }
                            },
                            child: GestureDetector(
                              onPanStart: (details) {
                                // Allow drawing only when not zoomed (at 100%)
                                // When zoomed, 1-finger panning is handled by InteractiveViewer
                                if (_pointerCount == 1 && _zoomLevel <= 1.01) {
                                  final transformedOffset =
                                      _getTransformedOffset(
                                        details.localPosition,
                                      );
                                  setState(() {
                                    _points.add(
                                      DrawingPoint(
                                        offset: transformedOffset,
                                        paint: Paint()
                                          ..color = _selectedColor
                                          ..isAntiAlias = true
                                          ..strokeWidth = _strokeWidth
                                          ..strokeCap = StrokeCap.round,
                                      ),
                                    );
                                  });
                                }
                              },
                              onPanUpdate: (details) {
                                // Allow drawing only when not zoomed (at 100%)
                                // When zoomed, 1-finger panning is handled by InteractiveViewer
                                if (_pointerCount == 1 && _zoomLevel <= 1.01) {
                                  final transformedOffset =
                                      _getTransformedOffset(
                                        details.localPosition,
                                      );
                                  setState(() {
                                    _points.add(
                                      DrawingPoint(
                                        offset: transformedOffset,
                                        paint: Paint()
                                          ..color = _selectedColor
                                          ..isAntiAlias = true
                                          ..strokeWidth = _strokeWidth
                                          ..strokeCap = StrokeCap.round,
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  CustomPaint(
                                    painter: DrawingPainter(points: _points),
                                    size: Size.infinite,
                                  ),
                                  // The outline image
                                  Center(
                                    child: IgnorePointer(
                                      child: Opacity(
                                        opacity: 0.8,
                                        child: SvgPicture.asset(
                                          widget.shape.imageUrl,
                                          fit: BoxFit.contain,
                                          colorFilter: const ColorFilter.mode(
                                            Colors.black,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
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
          ),
          // Tool Palette at Bottom
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ToolButton(icon: Icons.brush, isActive: true, onTap: () {}),
                const SizedBox(width: 16),
                _ToolButton(
                  icon: Icons.format_paint,
                  isActive: false,
                  onTap: () {},
                ),
                const SizedBox(width: 16),
                _ToolButton(
                  icon: Icons.auto_fix_normal,
                  isActive: false,
                  onTap: () => setState(() => _points.clear()),
                ),
              ],
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
                      l10n.translate('chooseColor'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
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
                      _Crayon(
                        color: Colors.red,
                        isSelected: _selectedColor == Colors.red,
                        onTap: () => _setColor(Colors.red),
                      ),
                      _Crayon(
                        color: Colors.orange,
                        isSelected: _selectedColor == Colors.orange,
                        onTap: () => _setColor(Colors.orange),
                      ),
                      _Crayon(
                        color: Colors.yellow,
                        isSelected: _selectedColor == Colors.yellow,
                        onTap: () => _setColor(Colors.yellow),
                      ),
                      _Crayon(
                        color: Colors.green,
                        isSelected: _selectedColor == Colors.green,
                        onTap: () => _setColor(Colors.green),
                      ),
                      _Crayon(
                        color: Colors.blue,
                        isSelected: _selectedColor == Colors.blue,
                        onTap: () => _setColor(Colors.blue),
                      ),
                      _Crayon(
                        color: Colors.purple,
                        isSelected: _selectedColor == Colors.purple,
                        onTap: () => _setColor(Colors.purple),
                      ),
                      _Crayon(
                        color: Colors.pink,
                        isSelected: _selectedColor == Colors.pink,
                        onTap: () => _setColor(Colors.pink),
                      ),
                      _Crayon(
                        color: Colors.brown,
                        isSelected: _selectedColor == Colors.brown,
                        onTap: () => _setColor(Colors.brown),
                      ),
                      _Crayon(
                        color: Colors.black,
                        isSelected: _selectedColor == Colors.black,
                        onTap: () => _setColor(Colors.black),
                      ),
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

  void _zoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + 0.2).clamp(1.0, 3.0);
      _transformationController.value = Matrix4.identity()..scale(_zoomLevel);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - 0.2).clamp(1.0, 3.0);
      _transformationController.value = Matrix4.identity()..scale(_zoomLevel);
    });
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
    setState(() {
      _zoomLevel = 1.0;
    });
  }

  void _undo() {
    if (_points.isEmpty) return;

    setState(() {
      // Find the last null marker (end of last stroke)
      int lastNullIndex = -1;
      for (int i = _points.length - 1; i >= 0; i--) {
        if (_points[i] == null) {
          lastNullIndex = i;
          break;
        }
      }

      // Remove the last stroke
      if (lastNullIndex >= 0) {
        // Remove from last null to the previous null (or to start)
        int previousNullIndex = -1;
        for (int i = lastNullIndex - 1; i >= 0; i--) {
          if (_points[i] == null) {
            previousNullIndex = i;
            break;
          }
        }

        // Remove the stroke
        _points.removeRange(previousNullIndex + 1, _points.length);
      } else {
        // No null markers, remove the last point
        _points.removeLast();
      }
    });
  }

  Offset _getTransformedOffset(Offset rawOffset) {
    // Get the transformation matrix from the InteractiveViewer
    final matrix = _transformationController.value;

    // Create the inverse matrix to transform screen coords back to canvas coords
    final inverse = Matrix4.copy(matrix)..invert();

    // Create a vector for the touch position
    final vector = Vector3(rawOffset.dx, rawOffset.dy, 0);

    // Transform the vector using the inverse matrix
    inverse.transform3(vector);

    // Return the transformed offset
    return Offset(vector.x, vector.y);
  }

  Future<void> _finishDrawing() async {
    try {
      // Reset zoom before capturing
      _transformationController.value = Matrix4.identity();
      setState(() {
        _zoomLevel = 1.0;
      });

      // Small delay to ensure UI updates
      await Future.delayed(const Duration(milliseconds: 100));

      final image = await _screenshotController.capture();
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            '${directory.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(image);

        if (mounted) {
          Navigator.pushNamed(context, '/success', arguments: imagePath);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving drawing: $e')));
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
          color: isActive
              ? AppTheme.primaryContainer
              : AppTheme.surfaceContainerHighest,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive
              ? AppTheme.onPrimaryContainer
              : AppTheme.onSurfaceVariant,
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
                color: AppTheme.primary.withValues(alpha: 0.3),
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
        canvas.drawLine(
          points[i]!.offset,
          points[i + 1]!.offset,
          points[i]!.paint,
        );
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(ui.PointMode.points, [
          points[i]!.offset,
        ], points[i]!.paint);
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
      ..color = Colors.grey.withValues(alpha: 0.1)
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
