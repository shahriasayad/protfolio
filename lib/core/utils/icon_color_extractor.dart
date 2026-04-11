import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

/// IconColorExtractor - Extract dominant color from icon images
class IconColorExtractor {
  static final Map<String, Color> _colorCache = {};

  static Future<Color> extractDominantColor(String iconPath) async {
    // Return cached color if available
    if (_colorCache.containsKey(iconPath)) {
      return _colorCache[iconPath]!;
    }

    try {
      final imageProvider = AssetImage(iconPath);
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        size: const Size(256, 256),
      );

      // Get the dominant color, fallback to a vibrant color, then to app accent
      const accentColor = Color(0xFF06D6A0);
      final dominantColor =
          paletteGenerator.dominantColor?.color ??
          paletteGenerator.vibrantColor?.color ??
          accentColor;

      _colorCache[iconPath] = dominantColor;
      return dominantColor;
    } catch (e) {
      // Fallback to accent color if extraction fails
      const accentColor = Color(0xFF06D6A0);
      _colorCache[iconPath] = accentColor;
      return accentColor;
    }
  }

  static Color? getCachedColor(String iconPath) {
    return _colorCache[iconPath];
  }

  static void clearCache() {
    _colorCache.clear();
  }
}
