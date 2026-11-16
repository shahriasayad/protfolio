import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/cards/timeline_item.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/common/section_wrapper.dart';

/// Experience section - work history timeline.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.base,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '02',
            title: 'Experience',
            subtitle: 'The roles that shaped how I think about building products.',
            description:
                'I focus on outcomes, team leverage, and consistent delivery across mobile releases.',
          ),
          const SizedBox(height: AppTokens.s36),
          Column(
            children: [
              for (var i = 0; i < ctrl.experience.length; i++)
                TimelineItem(
                  item: ctrl.experience[i],
                  isLast: i == ctrl.experience.length - 1,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
