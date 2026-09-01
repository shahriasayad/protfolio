import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/utils/app_screen_util.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/cards/achievement_card.dart';

/// Achievements section - achievements and honors
class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.tinted,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '06',
            title: 'Featured Achievements',
            subtitle: 'A few things worth mentioning.',
            description:
                'These highlights are kept concise so they support the narrative without turning the page into a résumé dump.',
          ),
          SizedBox(height: AppTokens.s48.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...ctrl.achievements.asMap().entries.map(
                (e) => AchievementCard(
                  item: e.value,
                  isLast: e.key == ctrl.achievements.length - 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
