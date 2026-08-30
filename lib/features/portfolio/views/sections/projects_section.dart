import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/cards/project_card.dart';

/// Projects section - portfolio projects grid
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.elevated,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '03',
            title: 'Featured Projects',
            subtitle: 'The work that best shows my range and product thinking.',
            description:
                'One primary case study leads the section so the most meaningful work gets the strongest placement. Supporting projects stay visible without competing for attention.',
          ),
          SizedBox(height: AppTokens.s16.h),

          Builder(
            builder: (_) {
              final cols = AppScreenUtil.screenWidth < 700
                  ? 1
                  : AppScreenUtil.screenWidth < 1100
                  ? 2
                  : 3;
              final items = ctrl.supportingProjects;
              final rows = (items.length / cols).ceil();

              return Column(
                children: List.generate(rows, (r) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: r == rows - 1 ? 0 : AppTokens.s16.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(cols, (c) {
                        final idx = r * cols + c;
                        if (idx >= items.length) {
                          return const Expanded(child: SizedBox.shrink());
                        }
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: c < cols - 1 ? AppTokens.s16.w : 0,
                            ),
                            child: ProjectCard(project: items[idx]),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
