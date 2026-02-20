import 'package:flutter/material.dart';

class ThemeState extends ChangeNotifier {
  int _currentWallpaperIndex = 0;

  static const List<LinearGradient> wallpapers = [
    // 1. Deep Space (Default)
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF1a1a2e),
        Color(0xFF16213e),
        Color(0xFF0f3460),
        Color(0xFF533483),
        Color(0xFF4a3f6b),
        Color(0xFF2c2c54),
      ],
      stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
    ),
    // 2. Midnight Purple
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF2E0249),
        Color(0xFF570A57),
        Color(0xFFA91079),
      ],
    ),
    // 3. Ocean Blue
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF051937),
        Color(0xFF004d7a),
        Color(0xFF008793),
        Color(0xFF00bf72),
      ],
    ),
    // 4. Sunset
    LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFF833ab4),
        Color(0xFFfd1d1d),
        Color(0xFFfcb045),
      ],
    ),
  ];

  LinearGradient get currentWallpaper => wallpapers[_currentWallpaperIndex];
  int get currentWallpaperIndex => _currentWallpaperIndex;

  void setWallpaper(int index) {
    if (index >= 0 && index < wallpapers.length) {
      _currentWallpaperIndex = index;
      notifyListeners();
    }
  }
}
