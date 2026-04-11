import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
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
          const SizedBox(height: AppTokens.s48),

          // Responsive grid
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive column count
              int cols;
              if (constraints.maxWidth < 600) {
                cols = 1;
              } else if (constraints.maxWidth < 1000) {
                cols = 2;
              } else {
                cols = 3;
              }

              final items = ctrl.projects;
              if (cols > items.length) cols = items.length;
              final rows = (items.length / cols).ceil();

              return Column(
                children: List.generate(rows, (r) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppTokens.s24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(cols, (c) {
                        final idx = r * cols + c;
                        if (idx >= items.length)
                          return Expanded(child: Container());
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: c < cols - 1 ? AppTokens.s16 : 0,
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
