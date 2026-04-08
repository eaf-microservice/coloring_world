import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
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
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Icon(Icons.star, color: colorScheme.primaryContainer),
        //     const SizedBox(width: 8),
        //     Text(
        //       l10n.translate('appTitle'),
        //       style: TextStyle(
        //         fontStyle: FontStyle.italic,
        //         fontWeight: FontWeight.w800,
        //         color: colorScheme.primaryContainer,
        //       ),
        //     ),
        //   ],
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: colorScheme.primary),
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
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
                    color: Colors.black.withValues(alpha: 0.1),
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
                          l10n.translate('ready_to_create'),
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.translate('pick_a_world'),
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer.withValues(
                              alpha: 0.8,
                            ),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/free-drawing'),
                          icon: const Icon(Icons.play_circle, size: 32),
                          label: Text(
                            l10n.translate('play'),
                            style: const TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
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
                  title: l10n.translate('arabicAlphabetCategory'),
                  subtitle: l10n.translate('arabicAlphabetSubtitle'),
                  icon: Icons.description,
                  color: Colors.green.shade100,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: 'arabic_alphabet',
                  ),
                ),
                _CategoryCard(
                  title: l10n.translate('englishAlphabetCategory'),
                  subtitle: l10n.translate('englishAlphabetSubtitle'),
                  icon: Icons.text_fields,
                  color: Colors.amber.shade100,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: 'english_alphabet',
                  ),
                ),
                _CategoryCard(
                  title: l10n.translate('numbersCategory'),
                  subtitle: l10n.translate('numbersSubtitle'),
                  icon: Icons.numbers,
                  color: Colors.orange.shade100,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: 'numbers',
                  ),
                ),
                _CategoryCard(
                  title: l10n.translate('animalsCategory'),
                  subtitle: l10n.translate('animalsSubtitle'),
                  icon: Icons.pets,
                  color: colorScheme.secondaryContainer,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: 'animals',
                  ),
                ),
                _CategoryCard(
                  title: l10n.translate('vehiclesCategory'),
                  subtitle: l10n.translate('vehiclesSubtitle'),
                  icon: Icons.directions_car,
                  color: colorScheme.tertiaryContainer,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: 'vehicles',
                  ),
                ),
                // _CategoryCard(
                //   title: l10n.translate('spaceCategory'),
                //   subtitle: l10n.translate('spaceSubtitle'),
                //   icon: Icons.rocket_launch,
                //   color: Colors.indigo.shade100,
                //   onTap: () => Navigator.pushNamed(
                //     context,
                //     '/gallery',
                //     arguments: 'space',
                //   ),
                // ),
                _CategoryCard(
                  title: l10n.translate('shapesCategory'),
                  subtitle: l10n.translate('shapesSubtitle'),
                  icon: Icons.category,
                  color: colorScheme.surfaceContainerHighest,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: 'shapes',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //bottomNavigationBar: _BottomNavBar(currentIndex: 0),
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
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.secondary,
                size: 32,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withValues(alpha: 0.5),
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

// class _BottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   const _BottomNavBar({required this.currentIndex});

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;
//     return Container(
//       height: 100,
//       padding: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.9),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(48)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 20,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _NavBarItem(
//             icon: Icons.play_arrow,
//             label: l10n.translate('play'),
//             isActive: currentIndex == 0,
//             onTap: () => Navigator.pushReplacementNamed(context, '/'),
//           ),
//           _NavBarItem(
//             icon: Icons.photo_library,
//             label: l10n.translate('gallery'),
//             isActive: currentIndex == 1,
//             onTap: () => Navigator.pushNamed(context, '/gallery'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _NavBarItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isActive;
//   final VoidCallback onTap;

//   const _NavBarItem({
//     required this.icon,
//     required this.label,
//     required this.isActive,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: isActive ? 24 : 12,
//               vertical: 8,
//             ),
//             decoration: BoxDecoration(
//               color: isActive
//                   ? colorScheme.primaryContainer
//                   : Colors.transparent,
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: Icon(
//               icon,
//               color: isActive ? Colors.white : Colors.grey,
//               size: 28,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               color: isActive ? colorScheme.onSurface : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
