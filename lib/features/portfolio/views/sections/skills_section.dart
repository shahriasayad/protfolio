import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/section_label.dart';
import '../widgets/cards/skill_card.dart';

/// Skills section - technical skills grouped by category
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    // Group skills by category
    final Map<String, List> grouped = {};
    for (final skill in ctrl.skills) {
      grouped.putIfAbsent(skill.category, () => []).add(skill);
    }

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: 'Skills'),
          const SizedBox(height: AppTokens.s16),
          Text(
            'A snapshot of my technical strengths',
            style: GoogleFonts.inter(
              color: AppTokens.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: AppTokens.s48),
          ...grouped.entries.map(
            (entry) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppTokens.s16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.s12,
                      vertical: AppTokens.s4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTokens.surfaceAlt,
                      borderRadius: BorderRadius.circular(AppTokens.r8),
                    ),
                    child: Text(
                      entry.key,
                      style: GoogleFonts.inter(
                        color: AppTokens.accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                ...entry.value.map(
                  (skill) => Padding(
                    padding: const EdgeInsets.only(bottom: AppTokens.s24),
                    child: SkillCard(skill: skill),
                  ),
                ),
                const SizedBox(height: AppTokens.s32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
