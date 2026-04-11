import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/section_label.dart';
import '../widgets/cards/timeline_item.dart';

/// Experience section - work experience timeline
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: 'Experience'),
          const SizedBox(height: AppTokens.s48),
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
