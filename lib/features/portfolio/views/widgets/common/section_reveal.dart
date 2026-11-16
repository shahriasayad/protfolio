import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';

/// Subtle one-shot entrance transition that respects reduced-motion preferences.
class SectionReveal extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offsetY;

  const SectionReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 420),
    this.offsetY = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    if (AppScreenUtil.reducedMotion(context)) {
      return child;
    }

    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      child: child,
      builder: (context, value, animatedChild) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1.0 - value) * offsetY),
            child: animatedChild,
          ),
        );
      },
    );
  }
}
