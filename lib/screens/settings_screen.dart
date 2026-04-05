import 'package:coloring/widgets/about.dart';
import 'package:flutter/material.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppStateNotifier _appState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appState = AppState.of(context);
    _appState.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _appState.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appState = AppState.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        title: Text(
          l10n.translate('settings'),
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            color: colorScheme.primary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Settings Section
            _buildSectionTitle(context, l10n.translate('language')),
            const SizedBox(height: 12),
            _buildLanguageOption(
              context,
              'English',
              const Locale('en'),
              appState,
              l10n,
            ),
            _buildLanguageOption(
              context,
              'Français',
              const Locale('fr'),
              appState,
              l10n,
            ),
            _buildLanguageOption(
              context,
              'العربية',
              const Locale('ar'),
              appState,
              l10n,
            ),
            const SizedBox(height: 32),

            // Theme Settings Section
            _buildSectionTitle(context, l10n.translate('theme')),
            const SizedBox(height: 12),
            _buildThemeOption(context, l10n, appState, false),
            _buildThemeOption(context, l10n, appState, true),
            const SizedBox(height: 32),

            // About Section
            _buildSectionTitle(context, l10n.translate('aboutApp')),
            const SizedBox(height: 12),
            _buildAboutCard(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String label,
    Locale locale,
    AppStateNotifier appState,
    AppLocalizations l10n,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = appState.locale.languageCode == locale.languageCode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: RadioListTile<Locale>(
          value: locale,
          groupValue: appState.locale,
          onChanged: (value) {
            if (value != null) {
              appState.setLocale(value);
            }
          },
          title: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : Colors.black87,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          activeColor: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    AppLocalizations l10n,
    AppStateNotifier appState,
    bool isDarkTheme,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = appState.isDarkTheme == isDarkTheme;
    final label = isDarkTheme
        ? l10n.translate('darkTheme')
        : l10n.translate('lightTheme');
    final icon = isDarkTheme ? Icons.dark_mode : Icons.light_mode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected ? colorScheme.onPrimaryContainer : Colors.black87,
            size: 28,
          ),
          title: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : Colors.black87,
            ),
          ),
          trailing: Radio<bool>(
            value: isDarkTheme,
            groupValue: appState.isDarkTheme,
            onChanged: (value) {
              if (value != null) {
                appState.setTheme(value);
              }
            },
            activeColor: colorScheme.onPrimaryContainer,
          ),
          onTap: () => appState.setTheme(isDarkTheme),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Title
          Text(
            l10n.translate('appTitle'),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w800,
            ),
          ),
          // const SizedBox(height: 8),

          // // Version
          // Text(
          //   l10n.translate('appVersion'),
          //   style: TextStyle(
          //     fontSize: 14,
          //     color: colorScheme.onPrimaryContainer,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          const SizedBox(height: 16),

          // Description
          Text(
            l10n.translate('appDescription'),
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onPrimaryContainer,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              // Open GitHub repo or website
              _showAboutMe();
            },
            child: Text(
              l10n.translate('learnMore'),
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Developed By
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.translate('developedBy'),
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showAboutMe() async {
    await AboutMe(
      applicationName: AppLocalizations.of(context)!.translate('appTitle'),
      version: '0.0.2',
      logo: Image.asset('assets/icon/icon.png', width: 100, height: 100),
      description: AppLocalizations.of(context)!.translate('appDescription'),
    ).showCustomAbout(context);
  }
}
