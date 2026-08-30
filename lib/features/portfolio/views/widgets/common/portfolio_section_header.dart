import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';

class PortfolioSectionHeader extends StatelessWidget {
  final String sectionIndex;
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? trailing;

  const PortfolioSectionHeader({
    super.key,
    required this.sectionIndex,
    required this.title,
    this.subtitle,
    this.description,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppTokens.sectionLeadWidth.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.only(bottom: AppTokens.s4.h),
                //   child: Text(
                //     sectionIndex,
                //     style: GoogleFonts.inter(
                //       color: AppTokens.textSecondary,
                //       fontSize: 12.sp,
                //       fontWeight: FontWeight.w600,
                //       letterSpacing: 3,
                //     ),
                //   ),
                // ),
                // SizedBox(height: AppTokens.s16.h),
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    color: AppTokens.textPrimary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.05,
                    letterSpacing: -1.2,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: AppTokens.s4.h),
                  Text(
                    subtitle!,
                    style: GoogleFonts.inter(
                      color: AppTokens.textSecondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (description != null) ...[
                  SizedBox(height: AppTokens.s8.h),
                  Text(
                    description!,
                    style: GoogleFonts.inter(
                      color: AppTokens.textMuted,
                      fontSize: 12.sp,
                      // height: 1.7,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (trailing != null) ...[SizedBox(width: AppTokens.s24.w), trailing!],
      ],
    );
  }
}
