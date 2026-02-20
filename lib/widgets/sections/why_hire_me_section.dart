import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../common/glassmorphism_card.dart';

/// Why Hire Me section - Quick value propositions
/// Lightweight and optimized for performance
class WhyHireMeSection extends StatelessWidget {
  const WhyHireMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    // Calculate padding
    final padding = EdgeInsets.all(
      isMobile ? AppConstants.space24 : AppConstants.space32,
    );

    return GlassmorphismCard(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available width for the grid items
          final availableWidth = constraints.maxWidth;

          // Determine layout based on available width
          // When in desktop sidebar, width might be small even if screen is desktop
          int crossAxisCount = 4;
          if (availableWidth < 450) {
            crossAxisCount = 1;
          } else if (availableWidth < 900) {
            crossAxisCount = 2;
          }

          // Use column layout for single item (mobile/narrow style)
          if (crossAxisCount == 1) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '✨ Why Work With Me?',
                  style: AppTextStyles.getSectionTitle(isMobile, isTablet),
                ),
                SizedBox(
                    height:
                        isMobile ? AppConstants.space20 : AppConstants.space24),
                ..._valuePropositions.map((vp) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppConstants.space16),
                      child: _ValuePropCard(
                        icon: vp['icon'] as String,
                        title: vp['title'] as String,
                        description: vp['description'] as String,
                        isMobile: true, // Use simpler layout for narrow width
                      ),
                    )),
              ],
            );
          }

          // Optimized aspect ratio calculation to prevent overflow
          // Lower aspect ratio means taller cards
          final double childAspectRatio = availableWidth < 1200 ? 0.9 : 1.1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✨ Why Work With Me?',
                style: AppTextStyles.getSectionTitle(isMobile, isTablet),
              ),
              SizedBox(
                  height:
                      isMobile ? AppConstants.space20 : AppConstants.space24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppConstants.space16,
                  mainAxisSpacing: AppConstants.space16,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: _valuePropositions.length,
                itemBuilder: (context, index) {
                  final vp = _valuePropositions[index];
                  return RepaintBoundary(
                    child: _ValuePropCard(
                      icon: vp['icon'] as String,
                      title: vp['title'] as String,
                      description: vp['description'] as String,
                      isMobile: false,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  static final List<Map<String, String>> _valuePropositions = [
    {
      'icon': '🚀',
      'title': 'Fast Delivery',
      'description': 'I ship production-ready code on time, every time.',
    },
    {
      'icon': '💎',
      'title': 'Quality Focus',
      'description': 'Clean, maintainable code following best practices.',
    },
    {
      'icon': '📱',
      'title': 'User-Centric',
      'description': 'I build apps users love to use and recommend.',
    },
    {
      'icon': '🤝',
      'title': 'Great Communication',
      'description': 'Regular updates, clear documentation, team player.',
    },
  ];
}

/// Individual value proposition card
class _ValuePropCard extends StatefulWidget {
  final String icon;
  final String title;
  final String description;
  final bool isMobile;

  const _ValuePropCard({
    required this.icon,
    required this.title,
    required this.description,
    this.isMobile = false,
  });

  @override
  State<_ValuePropCard> createState() => _ValuePropCardState();
}

class _ValuePropCardState extends State<_ValuePropCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: AppConstants.animationMedium),
        padding: EdgeInsets.all(
            widget.isMobile ? AppConstants.space16 : AppConstants.space20),
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.white.withOpacity(0.1)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: _isHovered
                ? Colors.white.withOpacity(0.25)
                : Colors.white.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Text(
              widget.icon,
              style: TextStyle(
                fontSize: widget.isMobile ? 32 : 40,
              ),
            ),
            SizedBox(
                height: widget.isMobile
                    ? AppConstants.space12
                    : AppConstants.space16),

            // Title
            Text(
              widget.title,
              style: AppTextStyles.subsectionMobile.copyWith(
                fontSize: widget.isMobile ? 16 : 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppConstants.space8),

            // Description
            Text(
              widget.description,
              style: AppTextStyles.bodyMobile.copyWith(
                fontSize: widget.isMobile ? 13 : 14,
                color: Colors.white.withOpacity(0.75),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
