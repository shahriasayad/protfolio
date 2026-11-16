import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_tokens.dart';

/// Viewport metrics, responsive breakpoints, and proportional scaling helpers.
class AppScreenUtil {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static Orientation orientation = Orientation.portrait;
  static bool _isInitialized = false;

  /// Maximum logical width before we stop scaling up to prevent distortion.
  static const double _maxScalingConstraint = 500.0;

  /// Base mobile width for scaling calculations.
  static const double _mobileBaseline = 390.0;

  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size.width == 0 || size.height == 0) return;

    final currentOrientation = MediaQuery.orientationOf(context);

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

  static bool isMobileWidth(double width) => width < AppTokens.mobileBreakpoint;

  static bool isTabletWidth(double width) =>
      width >= AppTokens.mobileBreakpoint && width < AppTokens.tabletBreakpoint;

  static bool isDesktopWidth(double width) =>
      width >= AppTokens.tabletBreakpoint;

  static bool get isMobile => isMobileWidth(screenWidth);

  static bool get isTablet => isTabletWidth(screenWidth);

  static bool get isDesktop => isDesktopWidth(screenWidth);

  static bool reducedMotion(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context);

  static double get scaleFactor {
    if (!_isInitialized) return 1.0;

    final shortestSide = min(screenWidth, screenHeight);
    final clampedSide = min(shortestSide, _maxScalingConstraint);
    return clampedSide / _mobileBaseline;
  }

  static double get textScaleFactor {
    if (!_isInitialized) return 1.0;

    final shortestSide = min(screenWidth, screenHeight);
    final clampedSide = min(shortestSide, 420.0);
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
