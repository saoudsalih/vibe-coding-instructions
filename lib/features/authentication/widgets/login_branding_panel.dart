import 'package:flutter/material.dart';
import 'package:vibe_coding_test/core/l10n/app_strings.dart';
import 'package:vibe_coding_test/core/theme/app_colors.dart';
import 'package:vibe_coding_test/core/theme/app_radius.dart';
import 'package:vibe_coding_test/core/theme/app_spacing.dart';
import 'package:vibe_coding_test/core/theme/app_text_styles.dart';

/// Left branding panel from ui_reference.png.
class LoginBrandingPanel extends StatelessWidget {
  const LoginBrandingPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.brandingPanel,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.onPrimary, width: 2),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'E',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.company,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.onPrimary,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        AppStrings.appName,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.onPrimary.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Icon(
                  Icons.security,
                  size: 120,
                  color: AppColors.onPrimary.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                AppStrings.slogan,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                AppStrings.sloganSubtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onPrimary.withValues(alpha: 0.9),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
