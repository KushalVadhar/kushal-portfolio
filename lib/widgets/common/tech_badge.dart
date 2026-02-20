import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';

class TechBadge extends StatelessWidget {
  final String text;
  final bool isSmall;

  const TechBadge({
    super.key,
    required this.text,
    this.isSmall = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 12,
        vertical: isSmall ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 0.5,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(fontSize: isSmall ? 10 : 12),
      ),
    );
  }
}
