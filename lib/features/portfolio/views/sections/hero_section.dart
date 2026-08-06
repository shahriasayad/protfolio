import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../widgets/common/hero_image.dart';
import '../widgets/common/hero_text_content.dart';

/// Hero section - main introduction with name, title, CTA
class HeroSection extends StatelessWidget {
  final VoidCallback onHire;
  final VoidCallback onProjects;

  const HeroSection({
    super.key,
    required this.onHire,
    required this.onProjects,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final isWide = AppScreenUtil.screenWidth > 900;
    final minHeight = math.max<double>(
      AppScreenUtil.screenHeight - AppTokens.s56.h,
      640.h,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppTokens.s24.w,
        AppTokens.s16.h,
        AppTokens.s24.w,
        AppTokens.s40.h,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 900),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 16),
                child: child,
              ),
            );
          },
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: HeroTextContent(
                        ctrl: ctrl,
                        onHire: onHire,
                        onProjects: onProjects,
                      ),
                    ),
                    SizedBox(width: AppTokens.s40.w),
                    Expanded(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.center,
                        child: _HeroVisualCluster(ctrl: ctrl),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeroTextContent(
                      ctrl: ctrl,
                      onHire: onHire,
                      onProjects: onProjects,
                    ),
                    SizedBox(height: AppTokens.s24.h),
                    _HeroVisualCluster(ctrl: ctrl),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroVisualCluster extends StatelessWidget {
  final PortfolioController ctrl;

  const _HeroVisualCluster({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroImage(ctrl),
        SizedBox(height: AppTokens.s16.h),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTokens.s12.w,
            vertical: AppTokens.s10.h,
          ),
          decoration: BoxDecoration(
            color: AppTokens.surfaceAlt.withValues(alpha: 0.56),
            borderRadius: BorderRadius.circular(AppTokens.r16.r),
            border: Border.all(
              color: AppTokens.borderStrong.withValues(alpha: 0.38),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Designing for clarity, shipping for speed, and building around measurable outcomes.',
                  style: TextStyle(
                    color: AppTokens.textSecondary,
                    fontSize: 12.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: AppTokens.s12.w),
              Container(
                padding: EdgeInsets.all(AppTokens.s8.w),
                decoration: BoxDecoration(
                  color: AppTokens.accent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_outward_rounded,
                  color: AppTokens.accent,
                  size: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
