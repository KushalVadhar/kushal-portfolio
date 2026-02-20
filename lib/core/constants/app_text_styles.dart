import 'package:flutter/material.dart';

/// Centralized text styles for the application
/// Follow responsive typography scale
class AppTextStyles {
  AppTextStyles._(); // Private constructor

  // Font family
  static const String fontFamily = 'San Francisco';

  // ========== HERO / DISPLAY TEXT ==========

  /// Hero headline - Mobile
  static const TextStyle heroMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
    color: Colors.white,
  );

  /// Hero headline - Tablet
  static const TextStyle heroTablet = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -1.0,
    color: Colors.white,
  );

  /// Hero headline - Desktop
  static const TextStyle heroDesktop = TextStyle(
    fontFamily: fontFamily,
    fontSize: 64,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -1.5,
    color: Colors.white,
  );

  // ========== SECTION TITLES ==========

  /// Section title - Mobile
  static const TextStyle sectionTitleMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.3,
    color: Colors.white,
  );

  /// Section title - Tablet
  static const TextStyle sectionTitleTablet = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.4,
    color: Colors.white,
  );

  /// Section title - Desktop
  static const TextStyle sectionTitleDesktop = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.5,
    color: Colors.white,
  );

  // ========== SUBSECTION TITLES ==========

  /// Subsection title - Mobile
  static const TextStyle subsectionMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: Colors.white,
  );

  /// Subsection title - Tablet
  static const TextStyle subsectionTablet = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: Colors.white,
  );

  /// Subsection title - Desktop
  static const TextStyle subsectionDesktop = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: Colors.white,
  );

  // ========== BODY TEXT ==========

  /// Body text - Mobile
  static TextStyle bodyMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: Colors.white.withOpacity(0.9),
  );

  /// Body text - Tablet
  static TextStyle bodyTablet = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: Colors.white.withOpacity(0.9),
  );

  /// Body text - Desktop
  static TextStyle bodyDesktop = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: Colors.white.withOpacity(0.9),
  );

  // ========== BODY TEXT MEDIUM ==========

  /// Body medium - Mobile
  static TextStyle bodyMediumMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: Colors.white.withOpacity(0.95),
  );

  /// Body medium - Tablet
  static TextStyle bodyMediumTablet = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: Colors.white.withOpacity(0.95),
  );

  /// Body medium - Desktop
  static TextStyle bodyMediumDesktop = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: Colors.white.withOpacity(0.95),
  );

  // ========== CAPTION TEXT ==========

  /// Caption - Mobile
  static TextStyle captionMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: Colors.white.withOpacity(0.7),
  );

  /// Caption - Tablet
  static TextStyle captionTablet = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: Colors.white.withOpacity(0.7),
  );

  /// Caption - Desktop
  static TextStyle captionDesktop = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: Colors.white.withOpacity(0.7),
  );

  // ========== LABELS ==========

  /// Label - Small (tags, badges)
  static TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
    color: Colors.white.withOpacity(0.85),
  );

  /// Label - Medium
  static TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.3,
    color: Colors.white.withOpacity(0.9),
  );

  // ========== BUTTON TEXT ==========

  /// Button text - Primary
  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  /// Button text - Secondary
  static TextStyle buttonSecondary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
    color: Colors.white.withOpacity(0.9),
  );

  // ========== HELPER METHODS ==========

  /// Get hero style based on screen type
  static TextStyle getHeroStyle(bool isMobile, bool isTablet) {
    if (isMobile) return heroMobile;
    if (isTablet) return heroTablet;
    return heroDesktop;
  }

  /// Get section title based on screen type
  static TextStyle getSectionTitle(bool isMobile, bool isTablet) {
    if (isMobile) return sectionTitleMobile;
    if (isTablet) return sectionTitleTablet;
    return sectionTitleDesktop;
  }

  /// Get subsection title based on screen type
  static TextStyle getSubsectionTitle(bool isMobile, bool isTablet) {
    if (isMobile) return subsectionMobile;
    if (isTablet) return subsectionTablet;
    return subsectionDesktop;
  }

  /// Get body text based on screen type
  static TextStyle getBodyText(bool isMobile, bool isTablet) {
    if (isMobile) return bodyMobile;
    if (isTablet) return bodyTablet;
    return bodyDesktop;
  }

  /// Get body medium based on screen type
  static TextStyle getBodyMedium(bool isMobile, bool isTablet) {
    if (isMobile) return bodyMediumMobile;
    if (isTablet) return bodyMediumTablet;
    return bodyMediumDesktop;
  }

  /// Get caption based on screen type
  static TextStyle getCaption(bool isMobile, bool isTablet) {
    if (isMobile) return captionMobile;
    if (isTablet) return captionTablet;
    return captionDesktop;
  }
}
