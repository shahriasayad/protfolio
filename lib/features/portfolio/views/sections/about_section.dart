import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/portfolio_section_header.dart';

/// About section - bio/personal intro
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.base,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '01',
            title: 'About',
            subtitle: 'Who I am and how I like to build.',
          ),
          SizedBox(height: AppTokens.s24.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800.w),
            child: Obx(
              () => Text(
                ctrl.bio.value.trim(),
                style: GoogleFonts.inter(
                  color: AppTokens.textSecondary,
                  fontSize: 14.sp,
                  height: 1.6.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
