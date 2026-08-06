import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../widgets/common/section_wrapper.dart';
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
    final isMobile = AppScreenUtil.screenWidth < 640;

    return SectionWrapper(
      padding: EdgeInsets.symmetric(
        horizontal: AppTokens.s24.w,
        vertical: isMobile ? AppTokens.s64.h : AppTokens.s96.h,
      ),
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
                  Flexible(
                    flex: 1,
                    child: HeroTextContent(
                      ctrl: ctrl,
                      onHire: onHire,
                      onProjects: onProjects,
                    ),
                  ),
                  SizedBox(width: AppTokens.s96.w),
                  Flexible(flex: 1, child: HeroImage(ctrl)),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile) HeroImage(ctrl),
                  if (!isMobile) SizedBox(height: AppTokens.s64.h),
                  HeroTextContent(
                    ctrl: ctrl,
                    onHire: onHire,
                    onProjects: onProjects,
                  ),
                  if (isMobile) SizedBox(height: AppTokens.s48.h),
                  if (isMobile) Center(child: HeroImage(ctrl)),
                ],
              ),
      ),
    );
  }
}
