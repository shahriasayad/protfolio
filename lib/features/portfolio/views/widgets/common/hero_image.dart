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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 320.w, maxHeight: 380.h),
            padding: EdgeInsets.all(AppTokens.s16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTokens.r24.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTokens.surfaceGlass,
                  AppTokens.surfaceAlt.withValues(alpha: 0.88),
                ],
              ),
              border: Border.all(
                color: AppTokens.borderStrong.withValues(alpha: 0.8),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTokens.accent.withValues(alpha: 0.16),
                  blurRadius: 50,
                  offset: const Offset(0, 24),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTokens.r20.r),
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
          Positioned(
            left: -AppTokens.s12.w,
            top: AppTokens.s16.h,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppTokens.s12.w,
                vertical: AppTokens.s8.h,
              ),
              decoration: BoxDecoration(
                color: AppTokens.surfaceGlass,
                borderRadius: BorderRadius.circular(AppTokens.r999.r),
                border: Border.all(
                  color: AppTokens.borderStrong.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
          Positioned(
            right: -AppTokens.s8.w,
            bottom: AppTokens.s24.h,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppTokens.s12.w,
                vertical: AppTokens.s8.h,
              ),
              decoration: BoxDecoration(
                color: AppTokens.accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(AppTokens.r12.r),
                border: Border.all(
                  color: AppTokens.accent.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                'Product-focused UI',
                style: TextStyle(
                  color: AppTokens.accent,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
