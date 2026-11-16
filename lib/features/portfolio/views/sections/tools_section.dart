import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/cards/tool_card.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/common/section_wrapper.dart';

/// Tools section - balanced developer workbench grid.
class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.base,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '06',
            title: 'Tech Stack',
            subtitle:
                'The tools I reach for when I need to ship quickly and cleanly.',
            description:
                'Compact, practical workflow tooling across IDEs, interface handoff, and API contract verification.',
          ),
          const SizedBox(height: AppTokens.s36),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = constraints.maxWidth >= 760
                  ? 3
                  : constraints.maxWidth >= 460
                  ? 2
                  : 1;
              const gap = AppTokens.s16;
              final tileWidth = (constraints.maxWidth - gap * (cols - 1)) / cols;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < ctrl.tools.length; i++)
                    SizedBox(
                      width: tileWidth,
                      child: ToolCard(tool: ctrl.tools[i], index: i),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
