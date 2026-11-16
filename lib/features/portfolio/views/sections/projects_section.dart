import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../models/project_model.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/cards/project_card.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/common/section_wrapper.dart';

/// Featured Projects section - primary spotlight case study and supporting project grid.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final featured = ctrl.featuredProjects;
    final supporting = ctrl.supportingProjects;

    return SectionWrapper(
      tone: SectionTone.base,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '04',
            title: 'Featured Projects',
            subtitle:
                'Work that shows my range and how I approach product problems.',
            description:
                'One primary case study leads the section so the most meaningful work gets strongest placement, followed by focused open-source builds.',
          ),
          const SizedBox(height: AppTokens.s36),
          if (featured.isNotEmpty) ...[
            ProjectCard(
              project: featured.first,
              index: 0,
              isFeatured: true,
            ),
            if (supporting.isNotEmpty) const SizedBox(height: AppTokens.s24),
          ],
          if (supporting.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 720) {
                  return Column(
                    children: [
                      for (var i = 0; i < supporting.length; i++) ...[
                        ProjectCard(
                          project: supporting[i],
                          index: i + 1,
                        ),
                        if (i < supporting.length - 1)
                          const SizedBox(height: AppTokens.s20),
                      ],
                    ],
                  );
                }

                return _PairedProjectGrid(supporting: supporting);
              },
            ),
        ],
      ),
    );
  }
}

class _PairedProjectGrid extends StatelessWidget {
  final List<ProjectModel> supporting;

  const _PairedProjectGrid({required this.supporting});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    var i = 0;

    while (i < supporting.length) {
      final hasPair = i + 1 < supporting.length;
      if (hasPair) {
        final leftIndex = i;
        final rightIndex = i + 1;
        rows.add(
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ProjectCard(
                    project: supporting[leftIndex],
                    index: leftIndex + 1,
                  ),
                ),
                const SizedBox(width: AppTokens.s20),
                Expanded(
                  child: ProjectCard(
                    project: supporting[rightIndex],
                    index: rightIndex + 1,
                  ),
                ),
              ],
            ),
          ),
        );
        i += 2;
      } else {
        rows.add(
          ProjectCard(
            project: supporting[i],
            index: i + 1,
            horizontalLayout: true,
          ),
        );
        i += 1;
      }

      if (i < supporting.length) {
        rows.add(const SizedBox(height: AppTokens.s20));
      }
    }

    return Column(children: rows);
  }
}
