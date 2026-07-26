import 'package:flutter/material.dart';
import 'package:vibe_coding_test/core/theme/app_colors.dart';
import 'package:vibe_coding_test/core/theme/app_radius.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 4,
      shadowColor: AppColors.primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(32),
        child: child,
      ),
    );
  }
}
