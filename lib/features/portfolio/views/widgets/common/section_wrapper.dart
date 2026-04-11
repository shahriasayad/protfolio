import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';

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
              const EdgeInsets.symmetric(
                horizontal: AppTokens.s24,
                vertical: AppTokens.s48,
              ),
          child: child,
        ),
      ),
    );
  }
}
