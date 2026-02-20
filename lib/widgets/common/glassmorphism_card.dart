import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive_utils.dart';

/// Optimized glassmorphism card with responsive blur
/// Uses RepaintBoundary and adaptive blur for performance
class GlassmorphismCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final bool showTrafficLights;
  final VoidCallback? onClose;
  final bool enableBlur;

  const GlassmorphismCard({
    super.key,
    required this.child,
    this.title,
    this.width,
    this.height,
    this.padding,
    this.showTrafficLights = false,
    this.onClose,
    this.enableBlur = true,
  });

  @override
  Widget build(BuildContext context) {
    final blurAmount =
        enableBlur ? ResponsiveUtils.getBlurAmount(context) : 0.0;
    final glassOpacity = ResponsiveUtils.getGlassOpacity(context);

    return RepaintBoundary(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          child: enableBlur && blurAmount > 0
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: blurAmount,
                    sigmaY: blurAmount,
                  ),
                  child: _buildContent(glassOpacity),
                )
              : _buildContent(glassOpacity),
        ),
      ),
    );
  }

  Widget _buildContent(double glassOpacity) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(glassOpacity),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(
          color: Colors.white.withOpacity(AppConstants.borderOpacity),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || showTrafficLights) _buildTitleBar(),
          Flexible(
            child: SingleChildScrollView(
              padding: padding ?? const EdgeInsets.all(AppConstants.space20),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.space12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (showTrafficLights) ...[
            _TrafficLight(
              color: const Color(0xFFFF5F57),
              onTap: onClose,
            ),
            const SizedBox(width: 8),
            const _TrafficLight(color: Color(0xFFFEBC2E)),
            const SizedBox(width: 8),
            const _TrafficLight(color: Color(0xFF28C840)),
          ],
          if (title != null) ...[
            const Spacer(),
            Text(
              title!,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            if (showTrafficLights) const SizedBox(width: 52),
          ],
        ],
      ),
    );
  }
}

/// macOS-style traffic light button
class _TrafficLight extends StatefulWidget {
  final Color color;
  final VoidCallback? onTap;

  const _TrafficLight({required this.color, this.onTap});

  @override
  State<_TrafficLight> createState() => _TrafficLightState();
}

class _TrafficLightState extends State<_TrafficLight> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: _isHovered && widget.onTap != null
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.6),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}
