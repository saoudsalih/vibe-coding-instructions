import 'package:flutter/material.dart';

/// Application colour tokens. Never use raw `Colors.*` in features.
abstract final class AppColors {
  static const Color primary = Color(0xFF0052FF);
  static const Color primaryDark = Color(0xFF003ECC);
  static const Color secondary = Color(0xFF1A3A6B);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF0288D1);

  static const Color background = Color(0xFFE8F0FE);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color hint = Color(0xFF9CA3AF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color brandingPanel = Color(0xFF0052FF);
}
