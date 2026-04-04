import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        title: Row(
          children: [
            Icon(Icons.star, color: colorScheme.primaryContainer),
            const SizedBox(width: 8),
            Text(
              l10n.appTitle,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                color: AppTheme.primaryContainer,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.primary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ready to create?",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Pick a world and start your colorful adventure today!",
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pushNamed(context, '/gallery'),
                          icon: const Icon(Icons.play_circle, size: 32),
                          label: Text(l10n.play, style: const TextStyle(fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: colorScheme.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Icon(Icons.brush, size: 100, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Categories
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _CategoryCard(
                  title: "Animals",
                  subtitle: "Lions, Birds & More",
                  icon: Icons.pets,
                  color: colorScheme.secondaryContainer,
                  onTap: () => Navigator.pushNamed(context, '/gallery'),
                ),
                _CategoryCard(
                  title: "Vehicles",
                  subtitle: "Cars & Planes",
                  icon: Icons.directions_car,
                  color: colorScheme.tertiaryContainer,
                  onTap: () {},
                ),
                _CategoryCard(
                  title: "Space",
                  subtitle: "Rockets & Stars",
                  icon: Icons.rocket_launch,
                  color: Colors.indigo.shade100,
                  onTap: () {},
                ),
                _CategoryCard(
                  title: "Shapes",
                  subtitle: "Circles & Squares",
                  icon: Icons.category,
                  color: colorScheme.surfaceVariant,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavBar(currentIndex: 0),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.secondary, size: 32),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const _BottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 100,
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(48)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            icon: Icons.play_arrow,
            label: l10n.play,
            isActive: currentIndex == 0,
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          _NavBarItem(
            icon: Icons.photo_library,
            label: l10n.gallery,
            isActive: currentIndex == 1,
            onTap: () => Navigator.pushNamed(context, '/gallery'),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: isActive ? 24 : 12, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? colorScheme.primaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey,
              size: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActive ? colorScheme.onSurface : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
