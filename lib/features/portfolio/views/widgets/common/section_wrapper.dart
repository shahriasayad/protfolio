import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';

/// Visual surface tone for alternating editorial bands.
enum SectionTone { base, tinted, elevated }

/// Consistent max-width container, hairline band borders, and responsive padding.
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final SectionTone tone;
  final bool showTopBorder;

  const SectionWrapper({
    super.key,
    required this.child,
    this.padding,
    this.tone = SectionTone.base,
    this.showTopBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = AppScreenUtil.isMobileWidth(width);

    final backgroundColor = switch (tone) {
      SectionTone.base => Colors.transparent,
      SectionTone.tinted => AppTokens.surfaceSoft,
      SectionTone.elevated => AppTokens.surface,
    };

    final resolvedPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: isMobile ? AppTokens.s20 : AppTokens.s32,
          vertical: isMobile ? AppTokens.s48 : AppTokens.s72,
        );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: showTopBorder
            ? const Border(top: BorderSide(color: AppTokens.border))
            : null,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTokens.maxWidth),
          child: Padding(
            padding: resolvedPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
