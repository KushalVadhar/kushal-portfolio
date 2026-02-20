import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Utility class for responsive design helpers
class ResponsiveUtils {
  /// Private constructor to prevent instantiation
  ResponsiveUtils._();

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.desktopBreakpoint;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;
  }

  /// Check if current screen is wide desktop
  static bool isWideDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.wideBreakpoint;
  }

  /// Get responsive value based on screen size
  static T valueBasedOnScreen<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return desktop;
    }
  }

  /// Get responsive padding based on screen size
  static EdgeInsets responsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(
        horizontal: AppConstants.space16,
        vertical: AppConstants.space20,
      );
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(
        horizontal: AppConstants.space32,
        vertical: AppConstants.space40,
      );
    } else {
      return const EdgeInsets.symmetric(
        horizontal: AppConstants.space64,
        vertical: AppConstants.space48,
      );
    }
  }

  /// Get responsive horizontal padding
  static double responsiveHorizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return AppConstants.space16;
    } else if (isTablet(context)) {
      return AppConstants.space40;
    } else {
      return AppConstants.space80;
    }
  }

  /// Get responsive vertical spacing between sections
  static double responsiveVerticalSpacing(BuildContext context) {
    if (isMobile(context)) {
      return AppConstants.space24;
    } else if (isTablet(context)) {
      return AppConstants.space32;
    } else {
      return AppConstants.space48;
    }
  }

  /// Get blur amount based on screen size (performance optimization)
  static double getBlurAmount(BuildContext context) {
    if (isMobile(context)) {
      return AppConstants.blurMobile;
    } else if (isTablet(context)) {
      return AppConstants.blurTablet;
    } else {
      return AppConstants.blurDesktop;
    }
  }

  /// Get glass opacity based on screen size
  static double getGlassOpacity(BuildContext context) {
    if (isMobile(context)) {
      return AppConstants.glassOpacityMobile;
    } else if (isTablet(context)) {
      return AppConstants.glassOpacityTablet;
    } else {
      return AppConstants.glassOpacityDesktop;
    }
  }

  /// Get grid column count based on screen size
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) {
      return AppConstants.gridColumnsMobile;
    } else if (isTablet(context)) {
      return AppConstants.gridColumnsTablet;
    } else {
      return AppConstants.gridColumnsDesktop;
    }
  }

  /// Scale font size responsively
  static double scaleFontSize(BuildContext context, double baseMobile,
      {double? tablet, double? desktop}) {
    if (isMobile(context)) {
      return baseMobile;
    } else if (isTablet(context)) {
      return tablet ?? baseMobile * 1.1;
    } else {
      return desktop ?? baseMobile * 1.25;
    }
  }

  /// Get appropriate icon size
  static double getIconSize(BuildContext context,
      {double mobile = 20, double tablet = 24, double desktop = 28}) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  /// Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Calculate adaptive width percentage
  static double widthPercent(BuildContext context, double percent) {
    return screenWidth(context) * (percent / 100);
  }

  /// Calculate adaptive height percentage
  static double heightPercent(BuildContext context, double percent) {
    return screenHeight(context) * (percent / 100);
  }
}
