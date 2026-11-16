import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_tokens.dart';

/// Font family options for centralized portfolio typography.
enum AppFontFamily { display, body, mono }

/// Centralized typography system using Space Grotesk (display),
/// Inter (body/UI), and JetBrains Mono (technical metadata).
class AppTextStyles {
  AppTextStyles._();

  /// Base style factory matching project typography guidelines.
  static TextStyle getTextStyle({
    AppFontFamily family = AppFontFamily.body,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppTokens.textPrimary,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) {
    return switch (family) {
      AppFontFamily.display => GoogleFonts.spaceGrotesk(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
          letterSpacing: letterSpacing,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
      AppFontFamily.body => GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
          letterSpacing: letterSpacing,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
      AppFontFamily.mono => GoogleFonts.jetBrainsMono(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
          letterSpacing: letterSpacing,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
    };
  }

  static TextStyle heroDisplay({required bool isMobile}) => getTextStyle(
        family: AppFontFamily.display,
        fontSize: isMobile ? 36 : 54,
        fontWeight: FontWeight.w700,
        color: AppTokens.textPrimary,
        height: 1.04,
        letterSpacing: isMobile ? -1.2 : -2.0,
      );

  static TextStyle heroStatement({required bool isMobile}) => getTextStyle(
        family: AppFontFamily.display,
        fontSize: isMobile ? 19 : 23,
        fontWeight: FontWeight.w500,
        color: AppTokens.textSecondary,
        height: 1.35,
        letterSpacing: -0.4,
      );

  static TextStyle sectionTitle({required bool isMobile}) => getTextStyle(
        family: AppFontFamily.display,
        fontSize: isMobile ? 26 : 34,
        fontWeight: FontWeight.w700,
        color: AppTokens.textPrimary,
        height: 1.12,
        letterSpacing: -1.0,
      );

  static TextStyle sectionSubtitle({required bool isMobile}) => getTextStyle(
        family: AppFontFamily.body,
        fontSize: isMobile ? 15 : 17,
        fontWeight: FontWeight.w500,
        color: AppTokens.textSecondary,
        height: 1.45,
      );

  static TextStyle cardTitle({double fontSize = 18}) => getTextStyle(
        family: AppFontFamily.display,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: AppTokens.textPrimary,
        height: 1.25,
        letterSpacing: -0.4,
      );

  static TextStyle body({
    double fontSize = 15,
    Color color = AppTokens.textSecondary,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.65,
  }) =>
      getTextStyle(
        family: AppFontFamily.body,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );

  static TextStyle mono({
    double fontSize = 12,
    Color color = AppTokens.textMuted,
    FontWeight fontWeight = FontWeight.w500,
    double? letterSpacing = 0.4,
    double? height,
  }) =>
      getTextStyle(
        family: AppFontFamily.mono,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static TextStyle button({
    double fontSize = 13,
    Color color = AppTokens.bg,
    FontWeight fontWeight = FontWeight.w600,
  }) =>
      getTextStyle(
        family: AppFontFamily.body,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: 0.1,
      );
}
