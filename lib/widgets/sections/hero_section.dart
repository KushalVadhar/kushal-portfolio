import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/utils/file_downloader.dart';
import '../common/glassmorphism_card.dart';

/// Hero Section - First impression for recruiters
///  Hook them in 3 seconds with clear value proposition
class HeroSection extends StatefulWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onContact;

  const HeroSection({super.key, this.onViewWork, this.onContact});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GlassmorphismCard(
          child: Padding(
            padding: EdgeInsets.all(
              isMobile ? AppConstants.space32 : AppConstants.space48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Text(
                  '👋 Hi, I\'m ${AppConstants.fullName}',
                  style: AppTextStyles.getSubsectionTitle(isMobile, isTablet)
                      .copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                SizedBox(
                    height:
                        isMobile ? AppConstants.space12 : AppConstants.space16),

                // Main headline
                _TypewriterText(
                  text: AppConstants.title,
                  style: AppTextStyles.getHeroStyle(isMobile, isTablet),
                ),
                SizedBox(
                    height:
                        isMobile ? AppConstants.space16 : AppConstants.space24),

                // Tagline / Value proposition
                Text(
                  AppConstants.tagline,
                  style: AppTextStyles.getBodyText(isMobile, isTablet).copyWith(
                    fontSize: isMobile ? 15 : (isTablet ? 17 : 19),
                    height: 1.5,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                SizedBox(
                    height:
                        isMobile ? AppConstants.space32 : AppConstants.space40),

                // Social proof / Quick stats
                if (!isMobile) ...[
                  _buildStats(isTablet),
                  const SizedBox(height: AppConstants.space40),
                ],

                // CTA Buttons
                Wrap(
                  spacing: AppConstants.space12,
                  runSpacing: AppConstants.space12,
                  children: [
                    _buildPrimaryButton(
                      context,
                      'View My Work',
                      Icons.arrow_forward_rounded,
                      () {
                        widget.onViewWork?.call();
                      },
                    ),
                    _buildResumeButton(
                      context,
                      'Download Resume',
                      Icons.download_rounded,
                      () => FileDownloader.downloadFile(AppConstants.resumeUrl,
                          filename: 'Kushal_Vadhar_Resume.pdf'),
                    ),
                    _buildSecondaryButton(
                      context,
                      'Let\'s Talk',
                      FontAwesomeIcons.envelope,
                      () {
                        if (widget.onContact != null) {
                          widget.onContact!.call();
                        } else {
                          _launchURL('mailto:${AppConstants.email}');
                        }
                      },
                    ),
                  ],
                ),

                // Social proof on mobile (below CTAs)
                if (isMobile) ...[
                  const SizedBox(height: AppConstants.space32),
                  _buildStats(isTablet),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStats(bool isTablet) {
    final now = DateTime.now();
    final start = AppConstants.careerStartDate;
    int totalMonths = (now.year - start.year) * 12 + now.month - start.month;
    if (now.day < start.day) totalMonths--;

    final int displayYears = totalMonths ~/ 12;
    final int displayMonths = totalMonths % 12;

    final String yearsStr =
        displayYears > 0 ? '$displayYears.$displayMonths' : '0.$displayMonths';

    return Wrap(
      spacing: AppConstants.space24,
      runSpacing: AppConstants.space16,
      children: [
        _buildStatItem(
          value: '${yearsStr}+',
          label: 'Years Experience',
          color: const Color(0xFF667eea),
        ),
        _buildStatItem(
          value: '5+',
          label: 'Projects Shipped',
          color: const Color(0xFF764ba2),
        ),
        _buildStatItem(
          value: '10K+',
          label: 'Downloads',
          color: const Color(0xFF6e8efb),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required Color color,
  }) {
    return _StatItem(
      value: value,
      label: label,
      color: color,
    );
  }

  /// Primary CTA button
  Widget _buildPrimaryButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.space24,
            vertical: AppConstants.space12,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF667eea),
                Color(0xFF764ba2),
              ],
            ),
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667eea).withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.buttonPrimary,
              ),
              const SizedBox(width: 8),
              Icon(icon, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  /// Secondary CTA button
  Widget _buildSecondaryButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.space20,
            vertical: AppConstants.space12,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: Colors.white.withOpacity(0.9)),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.buttonSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Specific Resume Button with distinct style
  Widget _buildResumeButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.space24,
            vertical: AppConstants.space12,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            border: Border.all(
              color: const Color(0xFF667eea).withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667eea).withOpacity(0.1),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.buttonSecondary.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatefulWidget {
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  State<_StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<_StatItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  widget.color,
                  _isHovered ? Colors.white : widget.color.withOpacity(0.7)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _isHovered
                    ? Colors.white.withOpacity(0.9)
                    : Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const _TypewriterText({
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration * widget.text.length,
      vsync: this,
    );
    _characterCount = IntTween(begin: 0, end: widget.text.length).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _characterCount,
      builder: (context, child) {
        String text = widget.text.substring(0, _characterCount.value);
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(text: text, style: widget.style),
              if (_characterCount.value < widget.text.length)
                TextSpan(
                  text: '|',
                  style: widget.style.copyWith(color: const Color(0xFF667eea)),
                ),
            ],
          ),
        );
      },
    );
  }
}
