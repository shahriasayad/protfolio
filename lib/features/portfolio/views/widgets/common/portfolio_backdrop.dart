import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';

/// Minimal architectural backdrop with subtle top radial light and max-width guides.
class PortfolioBackdrop extends StatelessWidget {
  const PortfolioBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppTokens.bg),
          const Align(
            alignment: Alignment.topCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.35, -1.0),
                  radius: 1.15,
                  colors: [
                    AppTokens.heroBackdropGlow,
                    Colors.transparent,
                  ],
                ),
              ),
              child: SizedBox(width: double.infinity, height: 680),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppTokens.maxWidth),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(color: AppTokens.gridLine),
                  ),
                ),
                child: SizedBox.expand(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
