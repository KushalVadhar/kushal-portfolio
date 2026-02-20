import 'package:flutter/material.dart';
import '../widgets/about_me_card.dart';
import '../widgets/skills_card.dart';
import '../widgets/projects_card.dart';
import '../widgets/contact_card.dart';

/// Desktop layout with two-column design (1200px+)
class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(80, 100, 80, 120),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - About Me (larger)
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AboutMeCard(isCompact: false),
                SizedBox(height: 24),
                ContactCard(isCompact: false),
              ],
            ),
          ),
          SizedBox(width: 24),
          // Right Column - Skills & Projects
          Expanded(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SkillsCard(isCompact: false),
                SizedBox(height: 24),
                ProjectsCard(crossAxisCount: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Tablet layout with stacked cards (600px - 1200px)
class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(40, 100, 40, 120),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AboutMeCard(isCompact: false),
          SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SkillsCard(isCompact: false)),
                SizedBox(width: 20),
                Expanded(child: ContactCard(isCompact: true)),
              ],
            ),
          ),
          SizedBox(height: 20),
          ProjectsCard(crossAxisCount: 3),
        ],
      ),
    );
  }
}

/// Mobile layout with tab switching (<600px)
class MobileLayout extends StatelessWidget {
  final int currentTabIndex;

  const MobileLayout({super.key, this.currentTabIndex = 0});

  @override
  Widget build(BuildContext context) {
    // Map index to specific view content
    Widget content;
    switch (currentTabIndex) {
      case 0:
        // Home uses the About Me card details but as the main view
        content = const AboutMeCard(isCompact: false);
        break;
      case 1:
        // Projects view
        content = const ProjectsCard(crossAxisCount: 1, showViewAll: true);
        break;
      case 2:
        // Skills view - show full details
        content = const SkillsCard(isCompact: false);
        break;
      case 3:
        // Contact view
        content = const ContactCard(isCompact: false);
        break;
      default:
        content = const AboutMeCard(isCompact: false);
    }

    return SingleChildScrollView(
      // Add padding to account for Dynamic Island (top) and Floating Nav (bottom)
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 100),
      child: content,
    );
  }
}
