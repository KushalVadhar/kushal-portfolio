import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../data/models/project_model.dart';
import '../common/glassmorphism_card.dart';
import '../common/tech_badge.dart';
import '../common/buttons.dart';

/// Enhanced projects section with detailed project cards
/// Optimized for performance with RepaintBoundary and const constructors
class EnhancedProjectsSection extends StatelessWidget {
  final List<ProjectModel> projects;
  final bool showAll;

  const EnhancedProjectsSection({
    super.key,
    required this.projects,
    this.showAll = true,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    final displayProjects =
        showAll ? projects : projects.where((p) => p.isFeatured).toList();

    return GlassmorphismCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // Determine columns based on available width, not screen width
          int columns = 3;
          if (width < 650) {
            columns = 1;
          } else if (width < 1100) {
            columns = 2;
          }

          final padding =
              isMobile ? AppConstants.space24 : AppConstants.space32;
          final availableWidth = width - (padding * 2);

          // Calculate item width
          // spacing = 16
          // total spacing = (cols - 1) * 16
          final totalSpacing = (columns - 1) * AppConstants.space16;
          final itemWidth = ((availableWidth - totalSpacing) / columns) - 0.1;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section header
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppConstants.space8,
                  runSpacing: AppConstants.space8,
                  children: [
                    Text(
                      '💼 Featured Projects',
                      style: AppTextStyles.getSectionTitle(isMobile, isTablet),
                    ),
                    if (!showAll)
                      TextButton(
                        onPressed: () {
                          // Navigate to all projects
                        },
                        child: const Text('View All →'),
                      ),
                  ],
                ),
                SizedBox(
                    height:
                        isMobile ? AppConstants.space16 : AppConstants.space24),

                // Projects Wrap
                Wrap(
                  spacing: AppConstants.space16,
                  runSpacing: AppConstants.space16,
                  children: displayProjects.map((project) {
                    return SizedBox(
                      width: itemWidth,
                      child: RepaintBoundary(
                        child: EnhancedProjectCard(
                          project: project,
                          isMobile: isMobile,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Individual project card with hover effects
/// Uses const constructor where possible for performance
class EnhancedProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isMobile;

  const EnhancedProjectCard({
    super.key,
    required this.project,
    this.isMobile = false,
  });

  @override
  State<EnhancedProjectCard> createState() => _EnhancedProjectCardState();
}

class _EnhancedProjectCardState extends State<EnhancedProjectCard> {
  bool _isHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: AppConstants.animationMedium),
        transform: Matrix4.identity()
          ..scale(_isHovered && !widget.isMobile ? 1.05 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(widget.isMobile ? 0.08 : 0.06),
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            border: Border.all(
              color: _isHovered
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project image placeholder
                _buildImagePlaceholder(),

                // Content
                Padding(
                  padding: const EdgeInsets.all(AppConstants.space16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.project.title,
                        style: AppTextStyles.subsectionMobile.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.space8),

                      // Short description
                      Text(
                        widget.project.shortDescription,
                        style: AppTextStyles.bodyMobile.copyWith(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.75),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.space12),

                      // Tech stack badges
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.techStack
                            .take(3)
                            .map((tech) => TechBadge(text: tech))
                            .toList(),
                      ),

                      const SizedBox(height: AppConstants.space24),

                      // Action buttons
                      Row(
                        children: [
                          if (widget.project.githubUrl != null)
                            Expanded(
                              child: SecondaryButton(
                                label: 'Code',
                                icon: FontAwesomeIcons.github,
                                onTap: () =>
                                    _launchURL(widget.project.githubUrl!),
                                isSmall: true,
                              ),
                            ),
                          if (widget.project.githubUrl != null)
                            const SizedBox(width: 8),

                          // Details button
                          Expanded(
                            child: SecondaryButton(
                              label: 'Details',
                              icon: Icons.info_outline,
                              onTap: _showDetails,
                              isSmall: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDetails() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 500,
          constraints: const BoxConstraints(maxHeight: 600),
          child: GlassmorphismCard(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.space24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.title,
                          style: AppTextStyles.subsectionMobile
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.space16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project.fullDescription,
                            style: AppTextStyles.bodyMobile.copyWith(
                              height: 1.5,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: AppConstants.space24),
                          Text(
                            'Key Features',
                            style: AppTextStyles.subsectionMobile
                                .copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: AppConstants.space8),
                          ...widget.project.keyFeatures
                              .map((feature) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle_outline,
                                            size: 16, color: Colors.blueAccent),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            feature,
                                            style: AppTextStyles.bodyMobile
                                                .copyWith(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                          const SizedBox(height: AppConstants.space24),
                          Text(
                            'Technologies',
                            style: AppTextStyles.subsectionMobile
                                .copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: AppConstants.space12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.project.techStack
                                .map((tech) =>
                                    TechBadge(text: tech, isSmall: false))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.space24),
                  Row(
                    children: [
                      if (widget.project.githubUrl != null)
                        Expanded(
                          child: SecondaryButton(
                            label: 'GitHub Repo',
                            icon: FontAwesomeIcons.github,
                            onTap: () {
                              _launchURL(widget.project.githubUrl!);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    if (widget.project.imageAsset != null) {
      return Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black26,
        ),
        child: widget.project.imageAsset!.startsWith('http')
            ? Image.network(
                widget.project.imageAsset!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderIcon(),
              )
            : Image.asset(
                widget.project.imageAsset!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderIcon(),
              ),
      );
    }
    return _buildPlaceholderIcon();
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667eea).withOpacity(0.6),
            const Color(0xFF764ba2).withOpacity(0.6),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          FontAwesomeIcons.laptopCode, // Changed icon
          size: 48,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
