import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../l10n/app_localizations.dart';
import '../models/coloring_shape.dart';

class GalleryScreen extends StatefulWidget {
  final String? category;
  const GalleryScreen({super.key, this.category});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category ?? 'animals';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    // Filter shapes by category
    final filteredShapes = sampleShapes
        .where((shape) => shape.category == selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          l10n.translate('appTitle'),
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
            color: colorScheme.primaryContainer,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Text(
              l10n.translate('chooseShape'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 24),
            // Category Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _CategoryTab(
                    label: l10n.translate('arabicAlphabetCategory'),
                    isSelected: selectedCategory == 'arabic_alphabet',
                    onTap: () {
                      setState(() => selectedCategory = 'arabic_alphabet');
                    },
                  ),
                  _CategoryTab(
                    label: l10n.translate('englishAlphabetCategory'),
                    isSelected: selectedCategory == 'english_alphabet',
                    onTap: () {
                      setState(() => selectedCategory = 'english_alphabet');
                    },
                  ),
                  _CategoryTab(
                    label: l10n.translate('numbersCategory'),
                    isSelected: selectedCategory == 'numbers',
                    onTap: () {
                      setState(() => selectedCategory = 'numbers');
                    },
                  ),
                  //==============================================
                  _CategoryTab(
                    label: l10n.translate('animalsCategory'),
                    isSelected: selectedCategory == 'animals',
                    onTap: () {
                      setState(() => selectedCategory = 'animals');
                    },
                  ),
                  _CategoryTab(
                    label: l10n.translate('vehiclesCategory'),
                    isSelected: selectedCategory == 'vehicles',
                    onTap: () {
                      setState(() => selectedCategory = 'vehicles');
                    },
                  ),
                  // _CategoryTab(
                  //   label: l10n.translate('spaceCategory'),
                  //   isSelected: selectedCategory == 'space',
                  //   onTap: () {
                  //     setState(() => selectedCategory = 'space');
                  //   },
                  // ),
                  _CategoryTab(
                    label: l10n.translate('shapesCategory'),
                    isSelected: selectedCategory == 'shapes',
                    onTap: () {
                      setState(() => selectedCategory = 'shapes');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: filteredShapes.length,
              itemBuilder: (context, index) {
                final shape = filteredShapes[index];
                return _ShapeCard(shape: shape);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _ShapeCard extends StatelessWidget {
  final ColoringShape shape;
  const _ShapeCard({required this.shape});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    // Use translate to get localized name
    String getName() {
      return l10n.translate(shape.nameKey);
    }

    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/drawing', arguments: shape),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _BuildImageFromUrl(imageUrl: shape.imageUrl),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      getName(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.brush,
                      size: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildImageFromUrl extends StatelessWidget {
  final String imageUrl;
  const _BuildImageFromUrl({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // Check file extension to determine how to load
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.asset(
        imageUrl,
        fit: BoxFit.contain,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      );
    } else {
      // For PNG and other image formats
      return Image.asset(imageUrl, fit: BoxFit.contain);
    }
  }
}
