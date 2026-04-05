import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  final AppStateNotifier notifier;

  const AppState({required this.notifier, required super.child, super.key});

  static AppStateNotifier of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(widget != null, 'AppState not found in context');
    return widget!.notifier;
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return oldWidget.notifier != notifier;
  }
}

class AppStateNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en');
  bool _isDarkTheme = false;

  Locale get locale => _locale;
  bool get isDarkTheme => _isDarkTheme;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }

  void setTheme(bool isDark) {
    if (_isDarkTheme != isDark) {
      _isDarkTheme = isDark;
      notifyListeners();
    }
  }
}
