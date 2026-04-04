import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/drawing_screen.dart';
import 'screens/free_drawing_screen.dart';
import 'screens/success_screen.dart';
import 'models/coloring_shape.dart';

void main() {
  runApp(const ColoringApp());
}

class ColoringApp extends StatelessWidget {
  const ColoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tactile Playground',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('fr')],
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
        if (settings.name == '/gallery') {
          final category = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => GalleryScreen(category: category),
          );
        }
        if (settings.name == '/drawing') {
          final shape = settings.arguments as ColoringShape;
          return MaterialPageRoute(builder: (_) => DrawingScreen(shape: shape));
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
    );
  }
}
