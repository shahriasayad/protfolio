import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/utils/app_screen_util.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/cards/education_card.dart';

/// Education section - education history
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

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
            sectionIndex: '05',
            title: 'Education',
            subtitle: 'Formal study and foundation for the product work above.',
          ),
          SizedBox(height: AppTokens.s48.h),
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
