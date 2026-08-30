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
            sectionIndex:
                '02', // Assuming it replaces Featured Projects which is 03? We'll let it share numbering or skip. Wait, Featured Projects is 03 in projects_section.dart. Let's not use an index if it's part of Projects, or just use 02.5. Let's omit sectionIndex.
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
        ],
      ),
    );
  }
}
