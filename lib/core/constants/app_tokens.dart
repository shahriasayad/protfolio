import 'package:flutter/material.dart';

class AppTokens {
  // Colors - Modern gradient palette
  static const bg = Color(0xFF05080F); // deep navy-black
  static const surface = Color(0xFF0F1419); // slightly lighter for depth
  static const surfaceAlt = Color(0xFF1A202D); // elevated surface
  static const surfaceGlass = Color(0xCC0F1419);
  static const surfaceSoft = Color(0xFF101725);
  static const border = Color(0xFF2D3748); // more visible borders
  static const borderStrong = Color(0xFF425067);
  static const textPrimary = Color(0xFFF7FAFC);
  static const textSecondary = Color(0xFF9CA3AF);
  static const textMuted = Color(0xFF6B7280);

  // Primary accent - vibrant cyan-green
  static const accent = Color(0xFF06D6A0); // brighter, more vibrant
  static const accentDim = Color(0xFF0D4D37); // darker for depth

  // Secondary accents for variety
  static const accentPurple = Color(0xFF9F7AEA); // purple
  static const accentBlue = Color(0xFF5B9FFF); // bright blue
  static const accentOrange = Color(0xFFFF8C5A); // warm orange
  static const accentPink = Color(0xFFFF6B9D); // vibrant pink
  static const accentTeal = Color(0xFF38D6C2);

  static const glowCyan = Color(0x2206D6A0);
  static const glowBlue = Color(0x205B9FFF);
  static const glowPink = Color(0x20FF6B9D);

  // Spacing scale
  static const s4 = 4.0;
  static const s5 = 5.0;
  static const s6 = 6.0;
  static const s8 = 8.0;
  static const s10 = 10.0;
  static const s12 = 12.0;
  static const s14 = 14.0;
  static const s16 = 16.0;
  static const s20 = 20.0;
  static const s24 = 24.0;
  static const s28 = 28.0;
  static const s32 = 32.0;
  static const s36 = 36.0;
  static const s40 = 40.0;
  static const s48 = 48.0;
  static const s56 = 56.0;
  static const s64 = 64.0;
  static const s72 = 72.0;
  static const s96 = 96.0;
  static const s104 = 104.0;

  // Radii
  static const r8 = 8.0;
  static const r12 = 12.0;
  static const r16 = 16.0;
  static const r20 = 20.0;
  static const r24 = 24.0;
  static const r999 = 999.0;

  // Max content width - better for web
  static const maxWidth = 1200.0;
  static const maxWidthNarrow = 900.0;
  static const maxWidthWide = 1280.0;
  static const heroContentWidth = 640.0;
  static const sectionLeadWidth = 720.0;
  static const featuredCardHeight = 440.0;
}
