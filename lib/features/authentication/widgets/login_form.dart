import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_coding_test/core/l10n/app_strings.dart';
import 'package:vibe_coding_test/core/theme/app_colors.dart';
import 'package:vibe_coding_test/core/theme/app_radius.dart';
import 'package:vibe_coding_test/core/theme/app_spacing.dart';
import 'package:vibe_coding_test/core/theme/app_text_styles.dart';
import 'package:vibe_coding_test/core/widgets/app_text_field.dart';
import 'package:vibe_coding_test/core/widgets/primary_button.dart';
import 'package:vibe_coding_test/features/authentication/viewmodel/login_viewmodel.dart';

/// Login form matching ui_reference.png (right panel).
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final vm = context.read<LoginViewModel>();
    _emailController = TextEditingController(text: vm.email);
    _passwordController = TextEditingController(text: vm.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, vm, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppStrings.welcomeBack, style: AppTextStyles.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(AppStrings.pleaseLogin, style: AppTextStyles.bodyMedium),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              controller: _emailController,
              label: AppStrings.emailAddress,
              hint: 'admin@test.com',
              prefixIcon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              errorText: vm.emailError,
              enabled: !vm.isLoading,
              onChanged: vm.updateEmail,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _passwordController,
              label: AppStrings.password,
              prefixIcon: Icons.lock_outline,
              obscureText: vm.obscurePassword,
              errorText: vm.passwordError,
              enabled: !vm.isLoading,
              onChanged: vm.updatePassword,
              suffixIcon: IconButton(
                onPressed: vm.toggleObscurePassword,
                icon: Icon(
                  vm.obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Checkbox(
                  value: vm.rememberMe,
                  onChanged: vm.isLoading ? null : vm.toggleRememberMe,
                ),
                Text(AppStrings.rememberMe, style: AppTextStyles.bodyMedium),
                const Spacer(),
                TextButton(
                  onPressed: vm.isLoading ? null : () {},
                  child: Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyles.link,
                  ),
                ),
              ],
            ),
            if (vm.hasError) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                vm.errorMessage!,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: AppStrings.login,
              isLoading: vm.isLoading,
              onPressed: vm.login,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.divider)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(AppStrings.or, style: AppTextStyles.caption),
                ),
                const Expanded(child: Divider(color: AppColors.divider)),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SecondaryBiometricButton(enabled: !vm.isLoading),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(AppStrings.noAccount, style: AppTextStyles.bodyMedium),
                TextButton(
                  onPressed: vm.isLoading ? null : () {},
                  child: Text(
                    AppStrings.contactAdministrator,
                    style: AppTextStyles.link,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Biometric control from mock — UI only (out of module scope).
class SecondaryBiometricButton extends StatelessWidget {
  const SecondaryBiometricButton({required this.enabled, super.key});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: enabled ? () {} : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fingerprint, size: 22),
            const SizedBox(width: AppSpacing.sm),
            Text(
              AppStrings.loginWithBiometrics,
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
