import 'dart:io';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme.dart';

class SuccessScreen extends StatelessWidget {
  final String imagePath;
  const SuccessScreen({super.key, required this.imagePath});

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
        title: Row(
          children: [
            Icon(Icons.star, color: colorScheme.primaryContainer),
            const SizedBox(width: 8),
            Text(
              l10n.translate('appTitle'),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                color: AppTheme.primaryContainer,
              ),
            ),
          ],
        ),
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Celebration
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.celebration,
                    size: 48,
                    color: AppTheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.translate('greatJob'),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primary,
                  ),
                ),
                Text(
                  l10n.translate('youDidIt'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Artwork Preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(File(imagePath), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 48),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: l10n.translate('save'),
                    icon: Icons.photo_camera,
                    color: AppTheme.primaryContainer,
                    onTap: () => _saveToGallery(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ActionButton(
                    label: l10n.translate('share'),
                    icon: Icons.share,
                    color: AppTheme.secondaryContainer,
                    onTap: () => _shareArtwork(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                ),
                icon: const Icon(Icons.brush, size: 28),
                label: Text(
                  l10n.translate('newDrawing'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.tertiaryContainer,
                  foregroundColor: AppTheme.onTertiaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveToGallery(BuildContext context) async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final result = await ImageGallerySaverPlus.saveFile(imagePath);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['isSuccess'] ? 'Saved to Gallery!' : 'Failed to save',
            ),
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Permission denied')));
      }
    }
  }

  Future<void> _shareArtwork(BuildContext context) async {
    await Share.shareXFiles([
      XFile(imagePath),
    ], text: 'Check out my masterpiece!');
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
