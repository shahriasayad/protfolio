import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

/// Hero text content - Name, title, intro, and CTAs
class HeroTextContent extends StatelessWidget {
  final PortfolioController ctrl;
  final VoidCallback onHire;
  final VoidCallback onProjects;

  const HeroTextContent({
    super.key,
    required this.ctrl,
    required this.onHire,
    required this.onProjects,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppScreenUtil.screenWidth < 640;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name with animated gradient
        Obx(
          () => AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                ctrl.name.value,
                textStyle: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 48.sp : 64.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -1.5,
                ),
                colors: [
                  AppTokens.accent,
                  AppTokens.accentBlue,
                  AppTokens.accentPurple,
                  AppTokens.accentPink,
                ],
                speed: const Duration(milliseconds: 400),
              ),
            ],
            isRepeatingAnimation: true,
            pause: const Duration(milliseconds: 1200),
            displayFullTextOnTap: true,
          ),
        ),
        SizedBox(height: AppTokens.s16.h),

        // Title with accent
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTokens.s16.w,
              vertical: AppTokens.s8.h,
            ),
            decoration: BoxDecoration(
              color: AppTokens.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTokens.r12.r),
              border: Border.all(
                color: AppTokens.accent.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              ctrl.title.value,
              style: GoogleFonts.inter(
                color: AppTokens.accent,
                fontSize: isMobile ? 16.sp : 18.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        SizedBox(height: AppTokens.s32.h),

        // Intro/Bio with typing animation
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600.w),
          child: Obx(
            () => AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  ctrl.intro.value,
                  textStyle: GoogleFonts.inter(
                    color: AppTokens.textSecondary,
                    fontSize: isMobile ? 16.sp : 18.sp,
                    height: 1.8.h,
                    fontWeight: FontWeight.w400,
                  ),
                  speed: const Duration(milliseconds: 38),
                  cursor: '|',
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
              pause: const Duration(milliseconds: 800),
            ),
          ),
        ),
        SizedBox(height: AppTokens.s48.h),

        // CTA Buttons
        Wrap(
          spacing: AppTokens.s16.w,
          runSpacing: AppTokens.s16.h,
          children: [
            PrimaryButton(label: 'View My Work', onTap: onProjects),
            SecondaryButton(label: 'Get In Touch', onTap: onHire),
          ],
        ),
      ],
    );
  }
}
