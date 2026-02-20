import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../widgets/dock.dart';
import '../widgets/window.dart';
import '../widgets/responsive_top_bar.dart';

import '../apps/terminal.dart';
import '../providers/window_state.dart';
import '../widgets/custom_cursor.dart';
import 'new_portfolio_layout.dart';
import '../widgets/about_me_card.dart';
import '../widgets/projects_card.dart';
import '../widgets/skills_card.dart';
import '../widgets/contact_card.dart';
import '../widgets/overlays/spotlight_search.dart';
import '../apps/settings.dart';
import '../providers/theme_state.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> with SingleTickerProviderStateMixin {
  bool _showSpotlight = false;
  final FocusNode _keyboardFocusNode = FocusNode();

  // Keys for scrolling
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _heroKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Request focus for keyboard shortcuts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _keyboardFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  void _toggleSpotlight() {
    setState(() {
      _showSpotlight = !_showSpotlight;
    });
  }

  void _handleKeyEvent(RawKeyEvent event) {
    // Check for Cmd+K (Mac) or Ctrl+K (Windows)
    final isCommand = event.isMetaPressed || event.isControlPressed;
    if (event is RawKeyDownEvent &&
        isCommand &&
        event.logicalKey == LogicalKeyboardKey.keyK) {
      _toggleSpotlight();
    }
  }

  void _openApp(String appName) {
    if (appName == 'Spotlight') {
      _toggleSpotlight();
      return;
    }

    final windowState = Provider.of<WindowState>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 800;

    // IMPORTANT: On mobile, dock buttons for sections should SCROLL instead of opening windows
    if (isMobile) {
      if (appName == 'About') {
        _scrollToSection(_aboutKey);
        return;
      } else if (appName == 'Projects') {
        _scrollToSection(_projectsKey);
        return;
      } else if (appName == 'Skills') {
        _scrollToSection(_skillsKey);
        return;
      } else if (appName == 'Contact') {
        _scrollToSection(_contactKey);
        return;
      }
    }

    Widget content;
    Size initialSize = const Size(800, 600);
    Offset initialPos =
        Offset(screenSize.width * 0.15, screenSize.height * 0.15);

    if (isMobile) {
      // For apps that DO open windows on mobile (Terminal, Settings), make them nearly full screen
      initialSize = Size(screenSize.width * 0.9, screenSize.height * 0.7);
      initialPos = Offset(screenSize.width * 0.05, screenSize.height * 0.12);
    } else {
      double offset = windowState.openWindows.length * 30.0;
      initialPos += Offset(offset, offset);
    }

    switch (appName) {
      case 'About':
        content =
            const SingleChildScrollView(child: AboutMeCard(isCompact: false));
        initialSize = const Size(700, 500);
        break;
      case 'Projects':
        content = SingleChildScrollView(
            child: ProjectsCard(crossAxisCount: isMobile ? 1 : 2));
        if (!isMobile) initialSize = const Size(900, 700);
        break;
      case 'Skills':
        content =
            const SingleChildScrollView(child: SkillsCard(isCompact: false));
        if (!isMobile) initialSize = const Size(700, 600);
        break;
      case 'Contact':
        content =
            const SingleChildScrollView(child: ContactCard(isCompact: false));
        initialSize = const Size(500, 550);
        break;
      case 'Terminal':
        content = const TerminalApp();
        if (!isMobile) initialSize = const Size(600, 400);
        break;
      case 'Settings':
        content = const SettingsApp();
        if (!isMobile) initialSize = const Size(700, 500);
        break;
      default:
        content = Center(child: Text("$appName coming soon"));
    }

    windowState.openApp(appName, content,
        initialSize: initialSize, initialPosition: initialPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: _keyboardFocusNode,
        onKey: _handleKeyEvent,
        autofocus: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 1200;
            final isTablet =
                constraints.maxWidth >= 600 && constraints.maxWidth < 1200;
            final isMobile = constraints.maxWidth < 600;

            // Unified Layout for all screens (Mobile gets OS feel too!)
            return Stack(
              children: [
                // 1. Background
                _buildBackground(),

                // 2. Stars
                _buildStarsOverlay(),

                // 3. Desktop Content (Acts as wallpaper/background widgets)
                // For mobile, this shows the main "About Me" card effectively.
                isMobile
                    ? _buildResponsiveLayout(isDesktop, isTablet, isMobile)
                    : CustomCursor(
                        child: _buildResponsiveLayout(
                            isDesktop, isTablet, isMobile)),

                // 4. Windows Overlay (Now active on Mobile!)
                Consumer<WindowState>(
                  builder: (context, windowState, child) {
                    return Stack(
                      children: windowState.openWindows.map((entry) {
                        return Window(
                          key: ValueKey(entry.id),
                          title: entry.title,
                          initialSize: entry.initialSize,
                          initialPosition: entry.initialPosition,
                          onClose: () => windowState.closeApp(entry.id),
                          child: entry.content,
                        );
                      }).toList(),
                    );
                  },
                ),

                // 5. Responsive Top Bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ResponsiveTopBar(
                    onSearchTap: _toggleSpotlight,
                    onProjectsTap: () => _scrollToSection(_projectsKey),
                    onContactTap: () => _scrollToSection(_contactKey),
                  ),
                ),

                // 6. Dock (Unified: Replaces BottomNav on Mobile)
                Positioned(
                  bottom: isMobile ? 30 : 16, // Higher on mobile for safe area
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Dock(
                      onAppTap: _openApp,
                      isCompact: isMobile,
                    ),
                  ),
                ),

                // 7. Spotlight Search Overlay
                if (_showSpotlight)
                  Positioned.fill(
                    child: SpotlightSearch(
                      onClose: _toggleSpotlight,
                      onAppSelected: (appName) {
                        _openApp(appName);
                        _toggleSpotlight();
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(bool isDesktop, bool isTablet, bool isMobile) {
    // Switching to the new simplified single-page layout
    return NewPortfolioLayout(
      heroKey: _heroKey,
      aboutKey: _aboutKey,
      skillsKey: _skillsKey,
      projectsKey: _projectsKey,
      contactKey: _contactKey,
      onViewWork: () => _scrollToSection(_projectsKey),
      onContact: () => _scrollToSection(_contactKey),
    );
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.1, // Scroll slightly above
      );
    }
  }

  Widget _buildBackground() {
    return RepaintBoundary(
      child: Consumer<ThemeState>(
        builder: (context, themeState, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: themeState.currentWallpaper,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStarsOverlay() {
    return RepaintBoundary(
      child: Opacity(
        opacity: 0.6,
        child: CustomPaint(
          painter: StarsPainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

/// Custom painter for starry background
class StarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Generate deterministic star positions
    final stars = <Offset>[];
    for (int i = 0; i < 100; i++) {
      final x = (i * 137.5) % size.width;
      final y = (i * 73.3) % size.height;
      stars.add(Offset(x, y));
    }

    // Draw stars with varying sizes
    for (int i = 0; i < stars.length; i++) {
      final starSize = (i % 3 == 0)
          ? 2.0
          : (i % 2 == 0)
              ? 1.5
              : 1.0;
      final opacity = (i % 4 == 0)
          ? 0.8
          : (i % 3 == 0)
              ? 0.6
              : 0.4;
      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(stars[i], starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
