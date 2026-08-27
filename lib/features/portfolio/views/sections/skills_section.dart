import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/utils/app_screen_util.dart';
import '../../models/skill_model.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/cards/skill_card.dart';

/// Skills section - technical skills grouped by category
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.tinted,
      child: Obx(() {
        final _ = ctrl.skillPaletteReady.value;
        final Map<String, List<SkillModel>> grouped =
            <String, List<SkillModel>>{};
        for (final skill in ctrl.skills) {
          grouped.putIfAbsent(skill.category, () => <SkillModel>[]).add(skill);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PortfolioSectionHeader(
              sectionIndex: '04',
              title: 'Technical Skills',
              subtitle: 'A focused stack rather than a long checklist.',
              description:
                  'The stack below is organized around what I actually use to ship polished Flutter products and the systems that support them.',
            ),
            const SizedBox(height: AppTokens.s12),
            Wrap(
              spacing: AppTokens.s8.w,
              runSpacing: AppTokens.s8.h,
              children: grouped.entries
                  .map(
                    (entry) => Container(
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
                        '${entry.key} • ${entry.value.length}',
                        style: GoogleFonts.inter(
                          color: AppTokens.textPrimary,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: AppTokens.s16.h),
            ...grouped.entries.indexed.map((item) {
              final isLast = item.$1 == grouped.entries.length - 1;
              final entry = item.$2;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : AppTokens.s12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: AppTokens.s8.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTokens.s10.w,
                          vertical: AppTokens.s4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTokens.surfaceGlass,
                          borderRadius: BorderRadius.circular(AppTokens.r999.r),
                          border: Border.all(
                            color: AppTokens.borderStrong.withValues(
                              alpha: 0.55,
                            ),
                          ),
                        ),
                        child: Text(
                          entry.key,
                          style: GoogleFonts.inter(
                            color: AppTokens.accent,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cols = constraints.maxWidth < 600
                            ? 1
                            : (constraints.maxWidth < 900 ? 2 : 3);
                        final width =
                            (constraints.maxWidth -
                                (AppTokens.s8.w * (cols - 1))) /
                            cols;

                        return Wrap(
                          spacing: AppTokens.s8.w,
                          runSpacing: AppTokens.s6.h,
                          children: entry.value
                              .map(
                                (skill) => SizedBox(
                                  width: width,
                                  child: SkillCard(skill: skill),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      }),
    );
  }
}
