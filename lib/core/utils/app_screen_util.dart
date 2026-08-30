import 'dart:math';
import 'package:flutter/material.dart';

class AppScreenUtil {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static Orientation orientation = Orientation.portrait;
  static bool _isInitialized = false;

  /// Maximum logical width before we stop scaling up to prevent tablet distortion.
  static const double _maxScalingConstraint = 500.0;

  /// Base generic mobile width for scaling calculations.
  static const double _mobileBaseline = 390.0;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Prevent initializing with 0.0 dimensions during early app startup / builder phase
    if (size.width == 0 || size.height == 0) return;

    final currentOrientation = MediaQuery.of(context).orientation;

    if (_isInitialized &&
        screenWidth == size.width &&
        screenHeight == size.height &&
        orientation == currentOrientation) {
      return;
    }

    screenWidth = size.width;
    screenHeight = size.height;
    orientation = currentOrientation;
    _isInitialized = true;
  }

  static double get scaleFactor {
    if (!_isInitialized) return 1.0;

    double shortestSide = min(screenWidth, screenHeight);

    double clampedSide = min(shortestSide, _maxScalingConstraint);

    return clampedSide / _mobileBaseline;
  }

  static double get textScaleFactor {
    if (!_isInitialized) return 1.0;

    double shortestSide = min(screenWidth, screenHeight);

    // Clamp text scaling heavily to prevent comically large fonts on desktop/tablet.
    double clampedSide = min(shortestSide, 420.0);
    return clampedSide / _mobileBaseline;
  }
}

extension ResponsiveExtension on num {
  double get w => this * AppScreenUtil.scaleFactor;

  double get h => this * AppScreenUtil.scaleFactor;

  double get sp => this * AppScreenUtil.textScaleFactor;

  double get r => this * AppScreenUtil.scaleFactor;

  Widget get vSpace => SizedBox(height: h);

  Widget get hSpace => SizedBox(width: w);
}
