/// Application-wide constants for consistency and maintainability
class AppConstants {
  AppConstants._(); // Private constructor to prevent instantiation

  // ========== RESPONSIVE BREAKPOINTS ==========
  /// Small devices (phones, 0-600px)
  static const double mobileBreakpoint = 600;

  /// Medium devices (tablets, 600-1024px)
  static const double tabletBreakpoint = 1024;

  /// Large devices (desktops, 1024px+)
  static const double desktopBreakpoint = 1024;

  /// Extra large devices (wide monitors, 1440px+)
  static const double wideBreakpoint = 1440;

  // ========== SPACING SYSTEM (4px base unit) ==========
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space64 = 64.0;
  static const double space80 = 80.0;
  static const double space96 = 96.0;

  // ========== BORDER RADIUS ==========
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusRound = 999.0;

  // ========== GLASSMORPHISM EFFECTS ==========
  /// Desktop blur sigma (full effect)
  static const double blurDesktop = 20.0;

  /// Tablet blur sigma (moderate effect)
  static const double blurTablet = 15.0;

  /// Mobile blur sigma (reduced for performance)
  static const double blurMobile = 8.0;

  /// Glass opacity desktop
  static const double glassOpacityDesktop = 0.12;

  /// Glass opacity tablet
  static const double glassOpacityTablet = 0.15;

  /// Glass opacity mobile (more solid for readability)
  static const double glassOpacityMobile = 0.20;

  /// Border opacity
  static const double borderOpacity = 0.2;

  // ========== ANIMATION DURATIONS ==========
  static const int animationFast = 200;
  static const int animationMedium = 300;
  static const int animationSlow = 500;

  // ========== GRID COLUMNS ==========
  static const int gridColumnsMobile = 1;
  static const int gridColumnsTablet = 2;
  static const int gridColumnsDesktop = 3;

  // ========== CONTENT MAX WIDTH ==========
  static const double maxContentWidth = 1400.0;
  static const double maxCardWidth = 800.0;

  // ========== Z-INDEX / LAYERS ==========
  static const int layerBackground = 0;
  static const int layerContent = 1;
  static const int layerCards = 2;
  static const int layerWindows = 3;
  static const int layerNavigation = 4;
  static const int layerDock = 5;
  static const int layerOverlay = 10;

  // ========== CONTACT INFORMATION ==========
  static const String email = 'kushalvadhar@gmail.com';
  static const String linkedIn = 'https://www.linkedin.com/in/kushal-vadhar';
  static const String github = 'https://github.com/kushald';
  static const String resumeUrl = 'assets/resume/Resume.pdf';

  // ========== PERSONAL INFO ==========
  static const String fullName = 'Kushal Vadhar';
  static const String title = 'Flutter Architect & AI Enthusiast';
  static const String tagline =
      'A lifelong student and AI innovator, specialized in building high-performance Flutter applications integrated with LLMs and Computer Vision, while actively learning RAG architectures since May 2024.';
  static const String location = 'India';

  // ========== PERSONALIZATION PILLARS ==========
  static const String mySkills =
      'Flutter Expert | AI Engineering (LLMs, RAG) | Computer Vision | Node.js | Python';
  static const String myJourney =
      'Since May 2024, I have evolved into an AI-first developer, shipping complex industrial and consumer applications with intelligent features.';
  static const String myAim =
      'To pioneer the next generation of intuitive, AI-powered software that bridges the gap between complex ML models and seamless user experiences.';
  static const String myFuture =
      'Expanding into Rust for high-performance backends and leading AI-first engineering teams.';

  // ========== TYPOGRAPHY ==========
  static const String fontFamily = 'San Francisco';
  static final DateTime careerStartDate = DateTime(2024, 1);
}
