import 'package:flutter/material.dart';
import 'dart:ui';

class AppTheme {
  // Glassmorphism Effect
  static BoxDecoration glassEffect({
    double opacity = 0.3,
    double blur = 20,
    Color? color,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    return BoxDecoration(
      color: (color ?? Colors.white).withOpacity(opacity),
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      border: border ??
          Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // Backdrop Filter for Glass Effect
  static Widget glassContainer({
    required Widget child,
    double sigmaX = 20,
    double sigmaY = 20,
    double opacity = 0.3,
    Color? color,
    BorderRadius? borderRadius,
    Border? border,
    EdgeInsets? padding,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(
          decoration: glassEffect(
            opacity: opacity,
            color: color,
            borderRadius: borderRadius,
            border: border,
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }

  // macOS Big Sur Colors
  static const Color macOSPink = Color(0xFFFF6B9D);
  static const Color macOSOrange = Color(0xFFFFA06B);
  static const Color macOSYellow = Color(0xFFFFC46B);
  static const Color macOSBlue = Color(0xFF6BC5FF);
  static const Color macOSPurple = Color(0xFF9B6BFF);

  // Dock Glassmorphism
  static BoxDecoration dockGlassEffect() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white.withOpacity(0.3),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  // Window Glassmorphism
  static BoxDecoration windowGlassEffect() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.white.withOpacity(0.5),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 30,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}
