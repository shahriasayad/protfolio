import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/section_label.dart';
import '../widgets/cards/tool_card.dart';

/// Tools section - development tools grid
class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final isWide = AppScreenUtil.screenWidth > 700;

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: 'Tools'),
          SizedBox(height: AppTokens.s48.h),
          Builder(
            builder: (_) {
              final cols = isWide ? 4 : 2;
              final items = ctrl.tools;
              final rows = (items.length / cols).ceil();
              return Column(
                children: List.generate(rows, (r) {
                  return Row(
                    children: List.generate(cols, (c) {
                      final idx = r * cols + c;
                      if (idx >= items.length) {
                        return const Expanded(child: SizedBox.shrink());
                      }
                      final tool = items[idx];
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: c < cols - 1 ? AppTokens.s16.w : 0,
                            bottom: AppTokens.s24.h,
                          ),
                          child: ToolCard(
                            name: tool['name'] as String,
                            icon: tool['icon'] as String,
                            color: tool['color'] as Color,
                          ),
                        ),
                      );
                    }),
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
