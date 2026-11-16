import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../../viewmodels/portfolio_controller.dart';

/// Developer spec-framed hero portrait with minimal IDE header and metadata bar.
class HeroImage extends StatelessWidget {
  final PortfolioController ctrl;

  const HeroImage(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final reducedMotion = AppScreenUtil.reducedMotion(context);

    final frame = Container(
      constraints: const BoxConstraints(maxWidth: 380),
      decoration: BoxDecoration(
        color: AppTokens.surface,
        borderRadius: BorderRadius.circular(AppTokens.r12),
        border: Border.all(color: AppTokens.borderStrong),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top minimal editor-inspired header bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.s14,
              vertical: AppTokens.s10,
            ),
            decoration: const BoxDecoration(
              color: AppTokens.surfaceAlt,
              border: Border(bottom: BorderSide(color: AppTokens.border)),
            ),
            child: Row(
              children: [
                const _WindowDots(),
                const SizedBox(width: AppTokens.s10),
                Expanded(
                  child: Text(
                    'shahria_sayad.dart',
                    style: AppTextStyles.mono(
                      fontSize: 11,
                      color: AppTokens.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTokens.s8,
                    vertical: AppTokens.s2,
                  ),
                  decoration: BoxDecoration(
                    color: AppTokens.accentSoft,
                    borderRadius: BorderRadius.circular(AppTokens.r4),
                  ),
                  child: Text(
                    'FLUTTER',
                    style: AppTextStyles.mono(
                      fontSize: 10,
                      color: AppTokens.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Portrait
          AspectRatio(
            aspectRatio: 4 / 4.3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  ctrl.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  cacheWidth: kIsWeb ? null : 900,
                  errorBuilder: (context, error, stackTrace) => const ColoredBox(
                    color: AppTokens.surfaceAlt,
                    child: Center(
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 72,
                        color: AppTokens.textMuted,
                      ),
                    ),
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, AppTokens.scrimDark],
                    ),
                  ),
                ),
                Positioned(
                  left: AppTokens.s14,
                  right: AppTokens.s14,
                  bottom: AppTokens.s12,
                  child: Row(
                    children: [
                      const _LiveDot(),
                      const SizedBox(width: AppTokens.s8),
                      Expanded(
                        child: Text(
                          'Flutter · Dart · Cross-Platform',
                          style: AppTextStyles.mono(
                            fontSize: 11,
                            color: AppTokens.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Spec footer line
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.s14,
              vertical: AppTokens.s12,
            ),
            decoration: const BoxDecoration(
              color: AppTokens.surface,
              border: Border(top: BorderSide(color: AppTokens.border)),
            ),
            child: Text(
              'Designing for clarity, shipping for speed, and building around measurable outcomes.',
              style: AppTextStyles.body(
                fontSize: 12,
                color: AppTokens.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );

    if (reducedMotion) return frame;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 520),
      tween: Tween<double>(begin: 0.96, end: 1.0),
      curve: Curves.easeOutCubic,
      child: frame,
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
    );
  }
}

class _WindowDots extends StatelessWidget {
  const _WindowDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(AppTokens.borderStrong),
        const SizedBox(width: AppTokens.s5),
        _dot(AppTokens.borderStrong),
        const SizedBox(width: AppTokens.s5),
        _dot(AppTokens.accent),
      ],
    );
  }

  Widget _dot(Color color) => Container(
    width: 7,
    height: 7,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _LiveDot extends StatelessWidget {
  const _LiveDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppTokens.statusLive,
        shape: BoxShape.circle,
      ),
    );
  }
}
