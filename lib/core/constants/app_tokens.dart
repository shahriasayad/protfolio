import 'package:flutter/material.dart';

/// Centralized design tokens for colors, spacing, radii, and layout widths.
class AppTokens {
  AppTokens._();

  // ── Surfaces & Backgrounds ─────────────────────────────────
  static const Color bg = Color(0xFF0B0D10);
  static const Color surface = Color(0xFF111419);
  static const Color surfaceAlt = Color(0xFF171B22);
  static const Color surfaceElevated = Color(0xFF1D222B);
  static const Color surfaceSoft = Color(0xFF0E1115);
  static const Color surfaceGlass = Color(0xEB0B0D10);

  // ── Hairlines & Borders ────────────────────────────────────
  static const Color border = Color(0xFF212733);
  static const Color borderStrong = Color(0xFF323B4C);

  // ── Typography Colors ──────────────────────────────────────
  static const Color textPrimary = Color(0xFFF4F6F9);
  static const Color textSecondary = Color(0xFFA0AAB8);
  static const Color textMuted = Color(0xFF6B7586);

  // ── Developer Accents ──────────────────────────────────────
  static const Color accent = Color(0xFF38BDF8);
  static const Color accentDim = Color(0xFF1E3A5F);
  static const Color accentSoft = Color(0x1938BDF8);

  static const Color statusLive = Color(0xFF34D399);
  static const Color statusLiveSoft = Color(0x1A34D399);

  static const Color accentWarm = Color(0xFFFBBF24);
  static const Color accentWarmSoft = Color(0x1AFBBF24);

  static const Color error = Color(0xFFF87171);

  // Backward-compatible semantic aliases pointing to restrained palette.
  static const Color accentBlue = accent;
  static const Color accentPurple = Color(0xFF818CF8);
  static const Color accentPink = accentWarm;
  static const Color accentTeal = statusLive;
  static const Color accentOrange = accentWarm;

  // ── Overlay & Subtle Grid Lines ────────────────────────────
  static const Color gridLine = Color(0x0AFFFFFF);
  static const Color heroBackdropGlow = Color(0x1238BDF8);
  static const Color scrimDark = Color(0xCC07090C);
  static const Color scrimLight = Color(0x3307090C);

  // ── Spacing Scale ──────────────────────────────────────────
  static const double s2 = 2.0;
  static const double s4 = 4.0;
  static const double s5 = 5.0;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s28 = 28.0;
  static const double s32 = 32.0;
  static const double s36 = 36.0;
  static const double s40 = 40.0;
  static const double s48 = 48.0;
  static const double s56 = 56.0;
  static const double s64 = 64.0;
  static const double s72 = 72.0;
  static const double s80 = 80.0;
  static const double s96 = 96.0;

  // ── Radii ──────────────────────────────────────────────────
  static const double r4 = 4.0;
  static const double r6 = 6.0;
  static const double r8 = 8.0;
  static const double r10 = 10.0;
  static const double r12 = 12.0;
  static const double r16 = 16.0;
  static const double r20 = 20.0;
  static const double r999 = 999.0;

  // ── Layout Dimensions & Breakpoints ────────────────────────
  static const double maxWidth = 1160.0;
  static const double maxWidthNarrow = 880.0;
  static const double sectionLeadWidth = 680.0;
  static const double navHeight = 64.0;

  static const double mobileBreakpoint = 640.0;
  static const double tabletBreakpoint = 940.0;
}
