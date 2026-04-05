# Coloring World 🎨

A delightful, kid-friendly coloring app built with Flutter that lets children create beautiful artwork with intuitive drawing and panning features.

## Features ✨

- **Interactive Drawing Canvas**: Draw freely on a blank canvas with a variety of colors
- **Pre-made Designs**: Color beautiful pre-drawn designs
- **Zoom & Pan**: Zoom in to work on details, pan to see the full picture
- **Smart Mode Toggle**: Automatic switching between Drawing and Pan modes based on zoom level
- **Rich Color Palette**: 12 vibrant kid-friendly colors to choose from
- **Adjustable Brush Sizes**: Control brush width from fine lines to bold strokes
- **Undo Feature**: Undo strokes to fix mistakes
- **Save & Share**: Save your artwork to the gallery or share with friends and family
- **Multi-language Support**: English, French, and Arabic localization
- **Kid-Friendly Dark Theme**: Vibrant colors (Pink #FF6B9D, Cyan #64D5FF, Lime #9FFF59) on a soft purple-gray background

## Getting Started

### Prerequisites
- Flutter SDK (3.11.1 or higher)
- Dart SDK
- Android SDK (for Android builds) or Xcode (for iOS)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/eaf-microservice/coloring_world.git
   cd coloring
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── theme.dart             # Theme configuration (kid-friendly dark theme)
├── models/
│   └── coloring_shape.dart    # Data model for coloring designs
├── screens/
│   ├── home_screen.dart       # Home/gallery selection screen
│   ├── drawing_screen.dart    # Pre-made design coloring screen
│   ├── free_drawing_screen.dart # Blank canvas drawing screen
│   ├── gallery_screen.dart    # Saved drawings gallery
│   ├── success_screen.dart    # Success/save/share screen
│   └── settings_screen.dart   # Language and theme settings
└── l10n/
    └── app_localizations.dart # Multi-language support
```

## Key Technologies

- **Flutter**: Cross-platform mobile app framework
- **Material Design 3**: Modern UI design system
- **Provider Pattern**: State management
- **Screenshot Package**: Capture canvas artwork
- **Image Gallery Saver Plus**: Save to device gallery
- **Share Plus**: Share functionality
- **Google Fonts**: Beautiful typography

## Theme Colors

The app uses a vibrant, kid-friendly dark theme:
- **Primary**: Bright Pink (#FF6B9D) - Engaging and playful
- **Secondary**: Bright Cyan (#64D5FF) - Energetic interactions
- **Tertiary**: Lime Green (#9FFF59) - Fun accents
- **Surface**: Purple-Gray (#2A2233) - Easy on young eyes

## Drawing Features

### Drawing/Pan Mode Toggle
- **Drawing Mode** (Brush enabled): Touch the canvas to draw
- **Pan Mode** (Disabled): Zoom and pan to navigate the canvas

### Auto Mode Switching
- Zoom in beyond 101% → Auto-switches to Pan Mode
- Zoom out to 100% → Auto-switches to Drawing Mode
- Manual toggle preserves zoom level

### Coordinate System
- Direct local position handling for accurate drawing at any zoom level
- No transformation artifacts when working with zoomed content

## Localization

The app supports three languages:
- 🇬🇧 English
- 🇫🇷 Français (French)
- 🇸🇦 العربية (Arabic)

## Building for Release

### Android
```bash
flutter build apk --release
# or for App Bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Privacy & Data

This app:
- ✅ Does NOT collect personal data
- ✅ Does NOT require internet connection
- ✅ Does NOT track user activity
- ✅ Stores drawings locally on device only
- ✅ Respects child privacy (COPPA compliant)

See [Privacy Policy](https://eaf-microservice.github.io/support/pages/privacy_policy_coloring_world.html) for complete details.

## Permissions

- **Storage**: Only for saving and sharing artwork (stored in app-specific directory)
- No other permissions required

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues, feature requests, or questions, please open an issue on the repository.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design guidelines
- All contributors who help make this app better

---

**Coloring World** - Where creativity has no limits! 🎨✨
