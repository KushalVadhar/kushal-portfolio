import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSmall;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? AppConstants.space16 : AppConstants.space24,
            vertical: isSmall ? AppConstants.space8 : AppConstants.space12,
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
                style: isSmall
                    ? AppTextStyles.buttonPrimary.copyWith(fontSize: 13)
                    : AppTextStyles.buttonPrimary,
              ),
              const SizedBox(width: 8),
              Icon(icon, size: isSmall ? 14 : 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSmall;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : AppConstants.space20,
            vertical: isSmall ? 8 : AppConstants.space12,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isSmall ? 0.08 : 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            border: Border.all(
              color: Colors.white.withOpacity(isSmall ? 0.15 : 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: isSmall ? 12 : 14,
                  color: Colors.white.withOpacity(0.9)),
              SizedBox(width: isSmall ? 6 : 8),
              Text(
                label,
                style: isSmall
                    ? AppTextStyles.buttonSecondary.copyWith(fontSize: 11)
                    : AppTextStyles.buttonSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
