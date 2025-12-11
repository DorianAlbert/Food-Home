// lib/theme/app_theme_extras.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Extension de thème pour les tokens qui ne rentrent pas directement
/// dans ColorScheme / TextTheme.
@immutable
class AppThemeExtras extends ThemeExtension<AppThemeExtras> {
  final Color inputBackground;
  final Color switchBackground;

  final Color sidebar;
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarPrimaryForeground;
  final Color sidebarAccent;
  final Color sidebarAccentForeground;
  final Color sidebarBorder;
  final Color sidebarRing;

  final double radiusSm;
  final double radiusMd;
  final double radiusLg;
  final double radiusXl;

  const AppThemeExtras({
    required this.inputBackground,
    required this.switchBackground,
    required this.sidebar,
    required this.sidebarForeground,
    required this.sidebarPrimary,
    required this.sidebarPrimaryForeground,
    required this.sidebarAccent,
    required this.sidebarAccentForeground,
    required this.sidebarBorder,
    required this.sidebarRing,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
  });

  /// Version "root" (light) — basée sur :root de ton CSS
  factory AppThemeExtras.light() {
    // --radius: 0.625rem; base 16px → ~10px
    // radius-sm: radius-4px ≈ 6px, md ≈ 8px, lg ≈10px, xl ≈14px
    return const AppThemeExtras(
      inputBackground: AppColors.inputBackground,
      switchBackground: AppColors.switchBackground,
      sidebar: AppColors.sidebar,
      sidebarForeground: AppColors.sidebarForeground,
      sidebarPrimary: AppColors.sidebarPrimary,
      sidebarPrimaryForeground: AppColors.sidebarPrimaryForeground,
      sidebarAccent: AppColors.sidebarAccent,
      sidebarAccentForeground: AppColors.sidebarAccentForeground,
      sidebarBorder: AppColors.sidebarBorder,
      sidebarRing: AppColors.sidebarRing,
      radiusSm: 6.0,
      radiusMd: 8.0,
      radiusLg: 10.0,
      radiusXl: 14.0,
    );
  }

  /// Version ".dark" — basée sur tes tokens dark
  factory AppThemeExtras.dark() {
    return const AppThemeExtras(
      inputBackground: AppColors.darkInput,
      switchBackground: AppColors.switchBackground, // peu ou prou identique
      sidebar: AppColors.darkSidebar,
      sidebarForeground: AppColors.darkSidebarForeground,
      sidebarPrimary: AppColors.darkSidebarPrimary,
      sidebarPrimaryForeground: AppColors.darkSidebarPrimaryForeground,
      sidebarAccent: AppColors.darkSidebarAccent,
      sidebarAccentForeground: AppColors.darkSidebarAccentForeground,
      sidebarBorder: AppColors.darkSidebarBorder,
      sidebarRing: AppColors.darkSidebarRing,
      radiusSm: 6.0,
      radiusMd: 8.0,
      radiusLg: 10.0,
      radiusXl: 14.0,
    );
  }

  @override
  AppThemeExtras copyWith({
    Color? inputBackground,
    Color? switchBackground,
    Color? sidebar,
    Color? sidebarForeground,
    Color? sidebarPrimary,
    Color? sidebarPrimaryForeground,
    Color? sidebarAccent,
    Color? sidebarAccentForeground,
    Color? sidebarBorder,
    Color? sidebarRing,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? radiusXl,
  }) {
    return AppThemeExtras(
      inputBackground: inputBackground ?? this.inputBackground,
      switchBackground: switchBackground ?? this.switchBackground,
      sidebar: sidebar ?? this.sidebar,
      sidebarForeground: sidebarForeground ?? this.sidebarForeground,
      sidebarPrimary: sidebarPrimary ?? this.sidebarPrimary,
      sidebarPrimaryForeground:
          sidebarPrimaryForeground ?? this.sidebarPrimaryForeground,
      sidebarAccent: sidebarAccent ?? this.sidebarAccent,
      sidebarAccentForeground:
          sidebarAccentForeground ?? this.sidebarAccentForeground,
      sidebarBorder: sidebarBorder ?? this.sidebarBorder,
      sidebarRing: sidebarRing ?? this.sidebarRing,
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
      radiusXl: radiusXl ?? this.radiusXl,
    );
  }

  @override
  AppThemeExtras lerp(ThemeExtension<AppThemeExtras>? other, double t) {
    if (other is! AppThemeExtras) return this;

    return AppThemeExtras(
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t) ??
          inputBackground,
      switchBackground:
          Color.lerp(switchBackground, other.switchBackground, t) ??
              switchBackground,
      sidebar: Color.lerp(sidebar, other.sidebar, t) ?? sidebar,
      sidebarForeground:
          Color.lerp(sidebarForeground, other.sidebarForeground, t) ??
              sidebarForeground,
      sidebarPrimary:
          Color.lerp(sidebarPrimary, other.sidebarPrimary, t) ?? sidebarPrimary,
      sidebarPrimaryForeground: Color.lerp(
              sidebarPrimaryForeground, other.sidebarPrimaryForeground, t) ??
          sidebarPrimaryForeground,
      sidebarAccent:
          Color.lerp(sidebarAccent, other.sidebarAccent, t) ?? sidebarAccent,
      sidebarAccentForeground: Color.lerp(
              sidebarAccentForeground, other.sidebarAccentForeground, t) ??
          sidebarAccentForeground,
      sidebarBorder:
          Color.lerp(sidebarBorder, other.sidebarBorder, t) ?? sidebarBorder,
      sidebarRing: Color.lerp(sidebarRing, other.sidebarRing, t) ?? sidebarRing,
      radiusSm: lerpDouble(radiusSm, other.radiusSm, t),
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t),
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t),
      radiusXl: lerpDouble(radiusXl, other.radiusXl, t),
    );
  }

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
