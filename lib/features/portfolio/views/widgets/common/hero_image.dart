import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../../viewmodels/portfolio_controller.dart';

/// Hero image - Profile picture with animation
class HeroImage extends StatelessWidget {
  final PortfolioController ctrl;
  const HeroImage(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0.8, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) =>
          Transform.scale(scale: value, child: child),
      child: Container(
        constraints: BoxConstraints(maxWidth: 280.w, maxHeight: 280.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTokens.r24.r),
          border: Border.all(color: AppTokens.border, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppTokens.accent.withValues(alpha: 0.2),
              blurRadius: 40,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTokens.r24.r),
          child: Image.asset(
            ctrl.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (ctx, err, stack) => Container(
              color: AppTokens.surfaceAlt,
              child: Center(
                child: Icon(
                  Icons.person_outline,
                  size: 80,
                  color: AppTokens.accent.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
