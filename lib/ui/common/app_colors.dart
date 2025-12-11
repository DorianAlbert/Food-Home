// lib/theme/app_colors.dart
import 'package:flutter/material.dart';

/// Couleurs de base traduites depuis ton global CSS + ajustées
/// pour coller à la maquette Food Home (primary bleu).
class AppColors {
  // ===== Light mode (root) =====

  // Fond principal
  static const background = Color(0xFFFFFFFF); // --background
  static const foreground =
      Color(0xFF111111); // texte très sombre, proche de oklch(0.145 ...)

  static const card = Color(0xFFFFFFFF); // --card
  static const cardForeground = foreground;

  static const popover = Color(0xFFFFFFFF); // oklch(1 0 0) -> blanc
  static const popoverForeground = foreground;

  /// 🎯 Couleur primaire de la maquette (bleu Food Home)
  /// Remplace l'ancien #030213 pour tout ce qui est primary.
  static const primary = Color(0xFF26B4E6); // BLEU principal
  static const primaryForeground = Color(0xFFFFFFFF);

  // oklch(0.95 0.0058 264.53) -> gris très clair légèrement froid
  static const secondary = Color(0xFFF4F5FB);
  static const secondaryForeground = primary; // bleu comme accent

  static const muted = Color(0xFFECECF0); // --muted
  static const mutedForeground = Color(0xFF717182); // --muted-foreground

  static const accent = Color(0xFFE9EBEF); // --accent
  static const accentForeground = foreground; // texte foncé

  static const destructive = Color(0xFFD4183D); // --destructive
  static const destructiveForeground = Color(0xFFFFFFFF);

  static const border = Color(0x1A000000); // rgba(0,0,0,0.1)
  static const input = Colors.transparent; // --input
  static const inputBackground = Color(0xFFF3F3F5); // --input-background
  static const switchBackground = Color(0xFFCBCED4); // --switch-background

  // oklch(0.708 0 0) -> gris moyen clair, utilisé pour outlines
  static const ring = Color(0xFFB3B3B3);

  // Charts : approximations cohérentes
  static const chart1 = Color(0xFFF4A259);
  static const chart2 = Color(0xFF36A3E0);
  static const chart3 = Color(0xFF4B6CD9);
  static const chart4 = Color(0xFFF6C453);
  static const chart5 = Color(0xFFE68A2E);

  // Sidebar light
  static const sidebar = Color(0xFFFBFBFD); // très clair
  static const sidebarForeground = foreground;
  static const sidebarPrimary =
      primary; // on garde le bleu comme primary sidebar
  static const sidebarPrimaryForeground = sidebar;
  static const sidebarAccent = Color(0xFFF7F7FB);
  static const sidebarAccentForeground = Color(0xFF333333);
  static const sidebarBorder = Color(0xFFEAEAF0);
  static const sidebarRing = ring;

  // ===== Tokens UI Food Home supplémentaires (pastels / accents) =====
  // Pastels utilisés pour les cartes repas et tuiles d’actions
  static const pastelBlue = Color(0xFFE0F9FF);
  static const pastelPurple = Color(0xFFF4E8FF);
  static const pastelYellow = Color(0xFFFFF4E5);
  static const pastelGrey = Color(0xFFF2F4F7);

  // Accents (violet / jaune) pour icônes & labels
  static const accentPurple = Color(0xFF9B51E0);
  static const accentYellow = Color(0xFFF4A623);

  // Texte gris utilisé pour les icônes / labels secondaires
  static const textMuted = Color(0xFF6B7280);

  // ===== Dark mode (.dark) -> approximations propres =====
  static const darkBackground = Color(0xFF111111);
  static const darkForeground = Color(0xFFF5F5F5);

  static const darkCard = darkBackground;
  static const darkCardForeground = darkForeground;

  static const darkPopover = darkBackground;
  static const darkPopoverForeground = darkForeground;

  // En dark, on peut garder un primary clair (blanc) ou basculer vers le bleu.
  // Ici on reste proche de ta config initiale, tu pourras l’ajuster plus tard.
  static const darkPrimary = darkForeground;
  static const darkPrimaryForeground = Color(0xFF343434);

  static const darkSecondary = Color(0xFF2B2B2F);
  static const darkSecondaryForeground = darkForeground;

  static const darkMuted = Color(0xFF2B2B2F);
  static const darkMutedForeground = Color(0xFFB3B3B3);

  static const darkAccent = Color(0xFF2B2B2F);
  static const darkAccentForeground = darkForeground;

  static const darkDestructive = Color(0xFF8F1E2F);
  static const darkDestructiveForeground = Color(0xFFF2C0C0);

  static const darkBorder = Color(0xFF2B2B2F);
  static const darkInput = Color(0xFF2B2B2F);
  static const darkRing = Color(0xFF707070);

  // Sidebar dark
  static const darkSidebar = Color(0xFF232325);
  static const darkSidebarForeground = darkForeground;
  static const darkSidebarPrimary = Color(0xFF5460FF);
  static const darkSidebarPrimaryForeground = darkForeground;
  static const darkSidebarAccent = darkSecondary;
  static const darkSidebarAccentForeground = darkForeground;
  static const darkSidebarBorder = darkSecondary;
  static const darkSidebarRing = darkRing;
}
