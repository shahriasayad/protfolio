import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/cards/achievement_card.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/common/section_wrapper.dart';

/// Achievements section - restrained highlights and recognitions.
class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '07',
            title: 'Featured Achievements',
            subtitle: 'A few things worth mentioning.',
            description:
                'Concise milestones from live deployment training and competitive problem solving.',
          ),
          const SizedBox(height: AppTokens.s36),
          Column(
            children: [
              for (var i = 0; i < ctrl.achievements.length; i++)
                AchievementCard(
                  item: ctrl.achievements[i],
                  index: i,
                  isLast: i == ctrl.achievements.length - 1,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
