import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/utils/app_screen_util.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/cards/timeline_item.dart';

/// Experience section - work experience timeline
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
            sectionIndex: '02',
            title: 'Experience Timeline',
            subtitle: 'The work history that shaped my product instincts.',
            description:
                'I focus on outcomes, team leverage, and consistent delivery. The timeline shows progression in scope and responsibility, not just job titles.',
          ),
          SizedBox(height: AppTokens.s48.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...ctrl.experience.asMap().entries.map(
                (e) => TimelineItem(
                  item: e.value,
                  isLast: e.key == ctrl.experience.length - 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
