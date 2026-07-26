import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_coding_test/app/injection.dart';
import 'package:vibe_coding_test/core/l10n/app_strings.dart';
import 'package:vibe_coding_test/core/theme/app_colors.dart';
import 'package:vibe_coding_test/core/theme/app_spacing.dart';
import 'package:vibe_coding_test/core/theme/app_text_styles.dart';
import 'package:vibe_coding_test/core/widgets/app_card.dart';
import 'package:vibe_coding_test/core/widgets/loading_overlay.dart';
import 'package:vibe_coding_test/features/authentication/viewmodel/login_viewmodel.dart';
import 'package:vibe_coding_test/features/authentication/widgets/login_branding_panel.dart';
import 'package:vibe_coding_test/features/authentication/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) {
        final vm = getIt<LoginViewModel>();
        vm.init();
        return vm;
      },
      child: const _LoginViewBody(),
    );
  }
}

class _LoginViewBody extends StatelessWidget {
  const _LoginViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<LoginViewModel>(
        builder: (context, vm, _) {
          return LoadingOverlay(
            isLoading: vm.isLoading,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;
                if (isWide) {
                  return Row(
                    children: [
                      const Expanded(flex: 4, child: LoginBrandingPanel()),
                      Expanded(
                        flex: 6,
                        child: _FormPane(maxWidth: 480),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: LoginBrandingPanel(),
                    ),
                    Expanded(child: _FormPane(maxWidth: 420)),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _FormPane extends StatelessWidget {
  const _FormPane({required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: const AppCard(child: LoginForm()),
            ),
          ),
        ),
        Positioned(
          right: AppSpacing.lg,
          bottom: AppSpacing.lg,
          child: Text(AppStrings.version, style: AppTextStyles.caption),
        ),
      ],
    );
  }
}
