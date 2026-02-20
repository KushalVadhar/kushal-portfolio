import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../data/models/experience_model.dart';
import '../common/glassmorphism_card.dart';
import '../common/tech_badge.dart';
import '../common/buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Professional experience timeline section
/// Optimized with RepaintBoundary for smooth performance
class ExperienceSection extends StatelessWidget {
  final List<ExperienceModel> experiences;

  const ExperienceSection({
    super.key,
    required this.experiences,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return GlassmorphismCard(
      child: Padding(
        padding: EdgeInsets.all(
          isMobile ? AppConstants.space24 : AppConstants.space32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Text(
              '💼 Experience',
              style: AppTextStyles.getSectionTitle(isMobile, isTablet),
            ),
            SizedBox(
                height: isMobile ? AppConstants.space20 : AppConstants.space24),

            // Timeline
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              separatorBuilder: (_, __) => SizedBox(
                height: isMobile ? AppConstants.space32 : AppConstants.space48,
              ),
              itemBuilder: (context, index) {
                return RepaintBoundary(
                  child: ExperienceCard(
                    experience: experiences[index],
                    isMobile: isMobile,
                    isTablet: isTablet,
                    isLast: index == experiences.length - 1,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual experience card with timeline marker
class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final bool isMobile;
  final bool isTablet;
  final bool isLast;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isMobile,
    required this.isTablet,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline marker
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: experience.isCurrent
                    ? const Color(0xFF4CAF50)
                    : Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: experience.isCurrent
                    ? [
                        BoxShadow(
                          color: const Color(0xFF4CAF50).withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Role & Company
              Row(
                children: [
                  Expanded(
                    child: Text(
                      experience.role,
                      style: AppTextStyles.subsectionMobile.copyWith(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (experience.isCurrent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.2),
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusSmall),
                        border: Border.all(
                          color: const Color(0xFF4CAF50).withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Current',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: const Color(0xFF4CAF50),
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),

              // Company name
              Text(
                experience.company,
                style: AppTextStyles.bodyMediumMobile.copyWith(
                  fontSize: isMobile ? 14 : 15,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),

              // Duration
              Text(
                experience.duration,
                style: AppTextStyles.captionMobile.copyWith(
                  fontSize: isMobile ? 12 : 13,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                experience.description,
                style: AppTextStyles.bodyMobile.copyWith(
                  fontSize: isMobile ? 13 : 14,
                  color: Colors.white.withOpacity(0.75),
                ),
              ),
              const SizedBox(height: 12),

              // Achievements
              ...experience.achievements.map((achievement) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFF667eea),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            achievement,
                            style: AppTextStyles.bodyMobile.copyWith(
                              fontSize: isMobile ? 13 : 14,
                              color: Colors.white.withOpacity(0.85),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

              const SizedBox(height: 12),

              // Technologies used
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: experience.technologiesUsed
                    .map((tech) => TechBadge(text: tech))
                    .toList(),
              ),

              if (experience.companyUrl != null) ...[
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SecondaryButton(
                    label: 'Visit',
                    icon: FontAwesomeIcons.arrowUpRightFromSquare,
                    onTap: () async {
                      final uri = Uri.parse(experience.companyUrl!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    isSmall: true,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
