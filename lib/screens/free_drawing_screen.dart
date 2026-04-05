import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart' show Matrix4, Vector3;
import 'dart:io';
import '../l10n/app_localizations.dart';
import '../theme.dart';

class FreeDrawingScreen extends StatefulWidget {
  const FreeDrawingScreen({super.key});

  @override
  State<FreeDrawingScreen> createState() => _FreeDrawingScreenState();
}

class _FreeDrawingScreenState extends State<FreeDrawingScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final GlobalKey _canvasKey = GlobalKey();
  Color _selectedColor = Colors.blue;
  List<DrawingPoint?> _points = [];
  double _strokeWidth = 12.0;
  double _zoomLevel = 1.0;
  late TransformationController _transformationController;
  int _pointerCount = 0;
  bool _isDrawingMode = true; // Toggle between draw and pan mode

  final List<Color> _colors = [
    Colors.red.shade400,
    Colors.orange.shade400,
    Colors.yellow.shade600,
    Colors.green.shade400,
    Colors.blue.shade400,
    Colors.indigo.shade400,
    Colors.purple.shade400,
    Colors.pink.shade400,
    Colors.teal.shade400,
    Colors.brown.shade400,
    Colors.grey.shade700,
    Colors.white,
  ];

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

  void _clearCanvas() {
    setState(() {
      _points.clear();
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

  void _finishDrawing() async {
    try {
      // Reset zoom and transform before capturing
      _transformationController.value = Matrix4.identity();
      setState(() {
        _zoomLevel = 1.0;
      });

      // Small delay to ensure UI updates
      await Future.delayed(const Duration(milliseconds: 100));

      final image = await _screenshotController.capture();
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();

        // Create directory if it doesn't exist
        final saveDir = Directory(directory.path);
        if (!await saveDir.exists()) {
          await saveDir.create(recursive: true);
        }

        final imagePath =
            '${directory.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';
        final imageFile = File(imagePath);

        // Write the image file
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

  void _zoomIn() {
    final newZoom = (_zoomLevel + 0.2).clamp(1.0, 3.0);
    setState(() {
      _zoomLevel =
          newZoom; // Auto-switch to drawing mode when zoomed out to 100%
      if (newZoom == 1.0) {
        _isDrawingMode = true;
      } // Auto-switch to pan mode when zooming in
      if (newZoom > 1.01) {
        _isDrawingMode = false;
      }
    });
    // Apply transformation with proper zooming centered
    final scale = newZoom;
    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5, 0)
      ..scale(scale, scale, 1)
      ..translate(-0.5, -0.5, 0);
  }

  void _zoomOut() {
    final newZoom = (_zoomLevel - 0.2).clamp(1.0, 3.0);
    setState(() {
      _zoomLevel = newZoom;
      // Auto-switch to drawing mode when completely zoomed out
      if (newZoom <= 1.0) {
        _isDrawingMode = true;
      }
    });
    // Apply transformation with proper zooming centered
    final scale = newZoom;
    _transformationController.value = Matrix4.identity()
      ..translate(0.5, 0.5, 0)
      ..scale(scale, scale, 1)
      ..translate(-0.5, -0.5, 0);
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
    setState(() {
      _zoomLevel = 1.0;
      // Reset to drawing mode when zooming out completely
      _isDrawingMode = true;
    });
  }

  void _toggleDrawingMode() {
    setState(() {
      _isDrawingMode = !_isDrawingMode;
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).colorScheme.surface.withValues(alpha: 0.5),
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/icon/icon.png', width: 50, height: 50),
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
          Tooltip(
            message: l10n.translate('clear'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton.icon(
                onPressed: _clearCanvas,
                icon: const Icon(Icons.clear, size: 20),
                label: Text(
                  l10n.translate('clear'),
                  style: const TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                ),
              ),
            ),
          ),
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
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
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
          // Container(
          //   color: Colors.white,
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       IconButton(
          //         onPressed: _zoomOut,
          //         icon: Icon(
          //           Icons.zoom_out,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //         tooltip: 'Zoom Out',
          //       ),
          //       Text(
          //         '${(_zoomLevel * 100).toStringAsFixed(0)}%',
          //         style: const TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       IconButton(
          //         onPressed: _zoomIn,
          //         icon: Icon(
          //           Icons.zoom_in,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //         tooltip: 'Zoom In',
          //       ),
          //       const SizedBox(width: 16),
          //       IconButton(
          //         onPressed: _resetZoom,
          //         icon: const Icon(Icons.refresh, color: Colors.blue),
          //         tooltip: 'Reset Zoom',
          //       ),
          //       // const SizedBox(width: 24),
          //       // // Current color indicator
          //       // Container(
          //       //   padding: const EdgeInsets.symmetric(
          //       //     horizontal: 12,
          //       //     vertical: 6,
          //       //   ),
          //       //   decoration: BoxDecoration(
          //       //     color: _selectedColor,
          //       //     borderRadius: BorderRadius.circular(12),
          //       //     border: Border.all(color: Colors.grey.shade300, width: 2),
          //       //   ),
          //       //   child: const Icon(
          //       //     Icons.palette,
          //       //     color: Colors.white,
          //       //     size: 20,
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                        // Pan hint when zoomed in pan mode only
                        if (_zoomLevel > 1.01 && !_isDrawingMode)
                          Positioned(
                            top: 20,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.pan_tool,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      l10n.translate('pan_mode'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // The interactive drawing area with zoom
                        InteractiveViewer(
                          transformationController: _transformationController,
                          minScale: 1.0,
                          maxScale: 3.0,
                          boundaryMargin: const EdgeInsets.all(100),
                          panEnabled: !_isDrawingMode,
                          scaleEnabled: false,
                          onInteractionEnd: (details) {
                            final scale = _transformationController.value
                                .getMaxScaleOnAxis();
                            setState(() {
                              _zoomLevel = scale;
                            });
                          },
                          child: Listener(
                            onPointerDown: (event) {
                              if (!_isDrawingMode)
                                return; // Disable drawing when in pan mode
                              _pointerCount++;
                              // Use local position directly - no transformation needed
                              setState(() {
                                _points.add(
                                  DrawingPoint(
                                    offset: event.localPosition,
                                    paint: Paint()
                                      ..color = _selectedColor
                                      ..isAntiAlias = true
                                      ..strokeWidth = _strokeWidth
                                      ..strokeCap = StrokeCap.round,
                                  ),
                                );
                              });
                            },
                            onPointerMove: (event) {
                              if (!_isDrawingMode)
                                return; // Disable drawing when in pan mode
                              // Draw while not zoomed
                              if (_pointerCount == 1) {
                                // Use local position directly - no transformation needed
                                setState(() {
                                  _points.add(
                                    DrawingPoint(
                                      offset: event.localPosition,
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
                            onPointerUp: (event) {
                              if (!_isDrawingMode)
                                return; // Ignore when in pan mode
                              _pointerCount--;
                              if (_pointerCount == 0) {
                                _points.add(null);
                              }
                            },
                            onPointerCancel: (event) {
                              if (!_isDrawingMode)
                                return; // Ignore when in pan mode
                              _pointerCount--;
                              if (_pointerCount == 0) {
                                _points.add(null);
                              }
                            },
                            child: CustomPaint(
                              painter: DrawingPainter(points: _points),
                              size: Size.infinite,
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
          // Color and Tool Palette
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Draw/Pan Mode Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isDrawingMode
                          ? l10n.translate('draw_mode')
                          : l10n.translate('pan_mode'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: _toggleDrawingMode,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _isDrawingMode
                              ? AppTheme.primaryContainer
                              : AppTheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _isDrawingMode
                                ? AppTheme.primary
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          _isDrawingMode ? Icons.brush : Icons.pan_tool,
                          color: _isDrawingMode
                              ? AppTheme.onPrimaryContainer
                              : AppTheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Stroke Width Slider
                Row(
                  children: [
                    const Icon(Icons.brush, color: AppTheme.primary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Slider(
                        value: _strokeWidth,
                        min: 5,
                        max: 40,
                        divisions: 35,
                        label: _strokeWidth.toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() {
                            _strokeWidth = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Color Palette
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _colors.map((color) {
                      final isSelected = _selectedColor == color;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                          borderRadius: BorderRadius.circular(60),
                          child: Container(
                            width: isSelected ? 70 : 60,
                            height: isSelected ? 70 : 60,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: Colors.black, width: 4)
                                  : Border.all(
                                      color: Colors.grey[400]!,
                                      width: 2,
                                    ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.6),
                                        blurRadius: 12,
                                        spreadRadius: 3,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
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
        canvas.drawCircle(
          points[i]!.offset,
          points[i]!.paint.strokeWidth / 2,
          points[i]!.paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const gridSize = 20.0;
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.1)
      ..strokeWidth = 0.5;

    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) => false;
}
