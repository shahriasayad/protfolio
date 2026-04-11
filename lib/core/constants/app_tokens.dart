import 'package:flutter/material.dart';

/// AppTokens - Single source of truth for every color,
/// spacing, and radius value used across the entire app.
class AppTokens {
  // Colors - Modern gradient palette
  static const bg = Color(0xFF05080F); // deep navy-black
  static const surface = Color(0xFF0F1419); // slightly lighter for depth
  static const surfaceAlt = Color(0xFF1A202D); // elevated surface
  static const border = Color(0xFF2D3748); // more visible borders
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

  // Spacing scale
  static const s4 = 4.0;
  static const s8 = 8.0;
  static const s12 = 12.0;
  static const s16 = 16.0;
  static const s24 = 24.0;
  static const s32 = 32.0;
  static const s48 = 48.0;
  static const s64 = 64.0;
  static const s96 = 96.0;

  // Radii
  static const r8 = 8.0;
  static const r12 = 12.0;
  static const r16 = 16.0;
  static const r24 = 24.0;
  static const r999 = 999.0;

  // Max content width - better for web
  static const maxWidth = 1200.0;
  static const maxWidthNarrow = 900.0;
}
