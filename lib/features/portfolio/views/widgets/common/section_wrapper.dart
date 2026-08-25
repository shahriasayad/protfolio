import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';

/// SectionWrapper - Consistent max-width + padding for all sections
enum SectionTone { base, tinted, elevated }

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final SectionTone tone;

  const SectionWrapper({
    super.key,
    required this.child,
    this.padding,
    this.tone = SectionTone.base,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (tone) {
      SectionTone.base => Colors.transparent,
      SectionTone.tinted => AppTokens.surface.withValues(alpha: 0.32),
      SectionTone.elevated => AppTokens.surfaceAlt.withValues(alpha: 0.32),
    };

    return Center(
      child: Container(
        width: double.infinity,
        color: backgroundColor,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTokens.maxWidth),
          child: Padding(
            padding:
                padding ??
                EdgeInsets.symmetric(
                  horizontal: AppTokens.s24.w,
                  vertical: AppTokens.s24.h,
                ),
            child: child,
          ),
        ),
      ),
    );
  }
}
