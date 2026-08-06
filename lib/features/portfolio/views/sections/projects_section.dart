import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/section_label.dart';
import '../widgets/cards/project_card.dart';

/// Projects section - portfolio projects grid
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: 'Projects'),
          SizedBox(height: AppTokens.s48.h),

          Builder(
            builder: (_) {
              var cols = AppScreenUtil.screenWidth < 600
                  ? 1
                  : AppScreenUtil.screenWidth < 1000
                  ? 2
                  : 3;
              final items = ctrl.projects;
              if (cols > items.length) {
                cols = items.length;
              }
              final rows = (items.length / cols).ceil();

              return Column(
                children: List.generate(rows, (r) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: AppTokens.s24.h),
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
