import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';

/// SectionWrapper - Consistent max-width + padding for all sections
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const SectionWrapper({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppTokens.maxWidth),
        child: Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: AppTokens.s24.w,
                vertical: AppTokens.s48.h,
              ),
          child: child,
        ),
      ),
    );
  }
}
