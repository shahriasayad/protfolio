import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/section_label.dart';
import '../widgets/cards/education_card.dart';

/// Education section - education history
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: 'Education'),
          const SizedBox(height: AppTokens.s48),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...ctrl.education.asMap().entries.map(
                (e) => EducationCard(
                  item: e.value,
                  isLast: e.key == ctrl.education.length - 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
