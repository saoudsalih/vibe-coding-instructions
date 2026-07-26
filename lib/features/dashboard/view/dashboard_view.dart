import 'package:flutter/material.dart';
import 'package:vibe_coding_test/app/injection.dart';
import 'package:vibe_coding_test/app/routes.dart';
import 'package:vibe_coding_test/core/l10n/app_strings.dart';
import 'package:vibe_coding_test/core/navigation/navigation_service.dart';
import 'package:vibe_coding_test/core/theme/app_colors.dart';
import 'package:vibe_coding_test/core/theme/app_spacing.dart';
import 'package:vibe_coding_test/core/theme/app_text_styles.dart';
import 'package:vibe_coding_test/features/authentication/repository/login_repository.dart';

/// Post-login destination. Minimal placeholder for auth navigation.
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Future<void> _logout() async {
    await getIt<LoginRepository>().logout();
    await getIt<NavigationService>().pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.dashboardTitle, style: AppTextStyles.titleLarge),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        actions: [
          TextButton(
            onPressed: _logout,
            child: Text(AppStrings.logout, style: AppTextStyles.link),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Text(
          '${AppStrings.welcomeUser}!',
          style: AppTextStyles.headlineMedium,
        ),
      ),
    );
  }
}
