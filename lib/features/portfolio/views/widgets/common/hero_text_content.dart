import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import 'portfolio_stat_card.dart';

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
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTokens.s12.w,
            vertical: AppTokens.s6.h,
          ),
          decoration: BoxDecoration(
            color: AppTokens.surfaceGlass,
            borderRadius: BorderRadius.circular(AppTokens.r999.r),
            border: Border.all(
              color: AppTokens.borderStrong.withValues(alpha: 0.55),
            ),
          ),
          child: Text(
            'Flutter developer · Product builder · UI systems',
            style: GoogleFonts.inter(
              color: AppTokens.textSecondary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
            ),
          ),
        ),
        SizedBox(height: AppTokens.s12.h),
        // Name with animated gradient
        Text(
          ctrl.name.value,
          style: GoogleFonts.spaceGrotesk(
            color: AppTokens.textPrimary,
            fontSize: isMobile ? 32.sp : 43.sp,
            fontWeight: FontWeight.w700,
            height: 1.0,
            letterSpacing: -1.5,
          ),
        ),
        SizedBox(height: AppTokens.s8.h),

        Text(
          ctrl.brandHeadline,
          style: GoogleFonts.spaceGrotesk(
            color: AppTokens.textPrimary,
            fontSize: isMobile ? 16.sp : 18.sp,
            fontWeight: FontWeight.w600,
            // height: 1.25,
          ),
        ),
        SizedBox(height: AppTokens.s12.h),

        Text(
          ctrl.brandSummary,
          style: GoogleFonts.inter(
            color: AppTokens.textSecondary,
            fontSize: isMobile ? 14.sp : 14.sp,
            // height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
        Wrap(
          spacing: AppTokens.s12.w,
          runSpacing: AppTokens.s12.h,
          children: ctrl.heroStats
              .map(
                (stat) => SizedBox(
                  width: isMobile ? double.infinity : 180.w,
                  child: PortfolioStatCard(stat: stat),
                ),
              )
              .toList(),
        ),

        SizedBox(height: AppTokens.s16.h),

        Container(
          padding: EdgeInsets.all(AppTokens.s16.w),
          decoration: BoxDecoration(
            color: AppTokens.surfaceGlass,
            borderRadius: BorderRadius.circular(AppTokens.r24.r),
            border: Border.all(
              color: AppTokens.borderStrong.withValues(alpha: 0.55),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      ctrl.availabilityNote,
                      style: GoogleFonts.inter(
                        color: AppTokens.textPrimary,
                        fontSize: 12.sp,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: AppTokens.s12.w),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppTokens.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTokens.s16.h),
              Wrap(
                spacing: AppTokens.s12.w,
                runSpacing: AppTokens.s12.h,
                children: [
                  PrimaryButton(label: 'View Featured Work', onTap: onProjects),
                  SecondaryButton(label: 'Start a Conversation', onTap: onHire),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
