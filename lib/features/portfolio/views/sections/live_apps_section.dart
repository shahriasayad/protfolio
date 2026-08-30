import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import 'package:my_portfolio/features/portfolio/views/widgets/cards/live_app_card.dart';
import 'package:my_portfolio/features/portfolio/views/widgets/common/portfolio_section_header.dart';
import 'package:my_portfolio/features/portfolio/views/widgets/common/section_wrapper.dart';

class LiveAppsSection extends StatelessWidget {
  const LiveAppsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.base,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '02', // Assuming it replaces Featured Projects which is 03? We'll let it share numbering or skip. Wait, Featured Projects is 03 in projects_section.dart. Let's not use an index if it's part of Projects, or just use 02.5. Let's omit sectionIndex.
            title: 'Live Apps',
            subtitle: 'Products I have built that are currently in production.',
          ),
          SizedBox(height: AppTokens.s16.h),
          
          // Live Apps Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: LiveAppCard(app: ctrl.liveApps[0])),
                    SizedBox(width: AppTokens.s16.w),
                    Expanded(child: LiveAppCard(app: ctrl.liveApps[1])),
                  ],
                );
              } else {
                return Column(
                  children: [
                    LiveAppCard(app: ctrl.liveApps[0]),
                    SizedBox(height: AppTokens.s16.h),
                    LiveAppCard(app: ctrl.liveApps[1]),
                  ],
                );
              }
            },
          ),
          
          SizedBox(height: AppTokens.s24.h),
          
          // Technology Stack & Integrations
          Container(
            padding: EdgeInsets.all(AppTokens.s20.w),
            decoration: BoxDecoration(
              color: AppTokens.surfaceAlt,
              borderRadius: BorderRadius.circular(AppTokens.r16.r),
              border: Border.all(
                color: AppTokens.border.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Technology Stack & Integrations',
                  style: GoogleFonts.inter(
                    color: AppTokens.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTokens.s12.h),
                ...ctrl.techIntegrations.map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: AppTokens.s8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: GoogleFonts.inter(
                            color: AppTokens.accent,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.inter(
                                color: AppTokens.textSecondary,
                                fontSize: 13.sp,
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(
                                  text: '${item['category']}: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppTokens.textPrimary,
                                  ),
                                ),
                                TextSpan(
                                  text: item['details'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
