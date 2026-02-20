import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/utils/responsive_utils.dart';
import '../data/portfolio_data.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/enhanced_projects_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/why_hire_me_section.dart';
import '../widgets/skills_card.dart';
import '../widgets/contact_card.dart';

/// New responsive portfolio layout - Optimized for performance
/// Uses responsive utilities and proper spacing
class NewPortfolioLayout extends StatelessWidget {
  final GlobalKey? heroKey;
  final GlobalKey? aboutKey;
  final GlobalKey? projectsKey;
  final GlobalKey? skillsKey;
  final GlobalKey? contactKey;
  final VoidCallback? onViewWork;
  final VoidCallback? onContact;

  const NewPortfolioLayout({
    super.key,
    this.heroKey,
    this.aboutKey,
    this.projectsKey,
    this.skillsKey,
    this.contactKey,
    this.onViewWork,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = ResponsiveUtils.isMobile(context);
        final isTablet = ResponsiveUtils.isTablet(context);

        if (isMobile) {
          return _buildMobileLayout();
        } else if (isTablet) {
          return _buildTabletLayout();
        } else {
          return _buildDesktopLayout();
        }
      },
    );
  }

  /// Mobile layout: Single column, stacked sections
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.space16,
        AppConstants.space80,
        AppConstants.space16,
        AppConstants.space96,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RepaintBoundary(
            key: heroKey,
            child: HeroSection(
              onViewWork: onViewWork,
              onContact: onContact,
            ),
          ),
          const SizedBox(height: AppConstants.space24),

          // About/Skills
          RepaintBoundary(
            key: skillsKey,
            child: const SkillsCard(isCompact: true),
          ),
          const SizedBox(height: AppConstants.space24),

          // Experience
          RepaintBoundary(
            child: ExperienceSection(experiences: PortfolioData.experiences),
          ),
          const SizedBox(height: AppConstants.space24),

          // Projects
          RepaintBoundary(
            key: projectsKey,
            child: EnhancedProjectsSection(
              projects: PortfolioData.featuredProjects,
              showAll: false,
            ),
          ),
          const SizedBox(height: AppConstants.space24),

          // Why Hire Me
          RepaintBoundary(key: aboutKey, child: const WhyHireMeSection()),
          const SizedBox(height: AppConstants.space24),

          // Contact
          RepaintBoundary(
              key: contactKey, child: const ContactCard(isCompact: false)),
        ],
      ),
    );
  }

  /// Tablet layout: Two column adaptive
  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.space40,
        AppConstants.space96,
        AppConstants.space40,
        AppConstants.space96,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero Section (full width)
          RepaintBoundary(
            key: heroKey,
            child: HeroSection(
              onViewWork: onViewWork,
              onContact: onContact,
            ),
          ),
          const SizedBox(height: AppConstants.space32),

          // Two column: Experience + Skills
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: RepaintBoundary(
                  child: ExperienceSection(
                    experiences: PortfolioData.experiences,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.space24),
              Expanded(
                flex: 2,
                child: RepaintBoundary(
                  key: skillsKey,
                  child: const SkillsCard(isCompact: false),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.space32),

          // Projects (full width)
          RepaintBoundary(
            key: projectsKey,
            child: EnhancedProjectsSection(
              projects: PortfolioData.projects,
              showAll: true,
            ),
          ),
          const SizedBox(height: AppConstants.space32),

          // Why Hire Me (full width)
          RepaintBoundary(key: aboutKey, child: const WhyHireMeSection()),
          const SizedBox(height: AppConstants.space32),

          // Contact (full width)
          RepaintBoundary(
              key: contactKey, child: const ContactCard(isCompact: false)),
        ],
      ),
    );
  }

  /// Desktop layout: Optimized multi-column
  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.space80,
        AppConstants.space96,
        AppConstants.space80,
        AppConstants.space96,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero Section (full width)
          RepaintBoundary(
            key: heroKey,
            child: HeroSection(
              onViewWork: onViewWork,
              onContact: onContact,
            ),
          ),
          const SizedBox(height: AppConstants.space48),

          // Two column: Experience + Skills
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RepaintBoundary(
                      child: ExperienceSection(
                        experiences: PortfolioData.experiences,
                      ),
                    ),
                    const SizedBox(height: AppConstants.space32),
                    RepaintBoundary(
                      key: projectsKey,
                      child: EnhancedProjectsSection(
                        projects: PortfolioData.projects,
                        showAll: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.space32),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RepaintBoundary(
                      key: skillsKey,
                      child: const SkillsCard(isCompact: false),
                    ),
                    const SizedBox(height: AppConstants.space32),
                    RepaintBoundary(
                        key: aboutKey, child: const WhyHireMeSection()),
                    const SizedBox(height: AppConstants.space32),
                    RepaintBoundary(
                      key: contactKey,
                      child: const ContactCard(isCompact: false),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
