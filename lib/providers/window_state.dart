import 'package:flutter/material.dart';

class WindowState extends ChangeNotifier {
  final List<WindowEntry> _openWindows = [];

  List<WindowEntry> get openWindows => List.unmodifiable(_openWindows);

  void openApp(String appName, Widget content,
      {Size? initialSize, Offset? initialPosition}) {
    // Check if window is already open
    final existingIndex = _openWindows.indexWhere((w) => w.title == appName);

    if (existingIndex != -1) {
      // Bring to front
      final entry = _openWindows.removeAt(existingIndex);
      _openWindows.add(entry);
      notifyListeners();
      return;
    }

    // Create new window
    _openWindows.add(
      WindowEntry(
        id: DateTime.now().toString(),
        title: appName,
        content: content,
        initialSize: initialSize ?? const Size(800, 500),
        initialPosition: initialPosition ?? const Offset(100, 100),
      ),
    );
    notifyListeners();
  }

  void closeApp(String id) {
    final initialLength = _openWindows.length;
    _openWindows.removeWhere((w) => w.id == id);
    if (_openWindows.length != initialLength) {
      notifyListeners();
    }
  }

  void bringToFront(String id) {
    final index = _openWindows.indexWhere((w) => w.id == id);
    if (index != -1 && index != _openWindows.length - 1) {
      final entry = _openWindows.removeAt(index);
      _openWindows.add(entry);
      notifyListeners();
    }
  }
}

class WindowEntry {
  final String id;
  final String title;
  final Widget content;
  final Size initialSize;
  final Offset initialPosition;

  const WindowEntry({
    required this.id,
    required this.title,
    required this.content,
    this.initialSize = const Size(600, 400),
    this.initialPosition = const Offset(100, 100),
  });
}
