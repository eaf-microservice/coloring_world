import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'theme.dart';
import 'app_state.dart';
import 'screens/home_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/drawing_screen.dart';
import 'screens/free_drawing_screen.dart';
import 'screens/success_screen.dart';
import 'screens/settings_screen.dart';
import 'models/coloring_shape.dart';

void main() {
  runApp(const ColoringApp());
}

class ColoringApp extends StatefulWidget {
  const ColoringApp({super.key});

  @override
  State<ColoringApp> createState() => _ColoringAppState();
}

class _ColoringAppState extends State<ColoringApp> {
  final AppStateNotifier _appStateNotifier = AppStateNotifier();

  @override
  void initState() {
    super.initState();
    _appStateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _appStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppState(
      notifier: _appStateNotifier,
      child: MaterialApp(
        title: 'Coloring World',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _appStateNotifier.isDarkTheme
            ? ThemeMode.dark
            : ThemeMode.light,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar'), Locale('fr')],
        locale: _appStateNotifier.locale,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          }
          if (settings.name == '/settings') {
            return MaterialPageRoute(builder: (_) => const SettingsScreen());
          }
          if (settings.name == '/gallery') {
            final category = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (_) => GalleryScreen(category: category),
            );
          }
          if (settings.name == '/drawing') {
            final shape = settings.arguments as ColoringShape;
            return MaterialPageRoute(
              builder: (_) => DrawingScreen(shape: shape),
            );
          }
          if (settings.name == '/free-drawing') {
            return MaterialPageRoute(builder: (_) => const FreeDrawingScreen());
          }
          if (settings.name == '/success') {
            final imagePath = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => SuccessScreen(imagePath: imagePath),
            );
          }
          return null;
        },
      ),
    );
  }
}
