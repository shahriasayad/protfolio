import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/skill_model.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/cards/skill_card.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/common/section_wrapper.dart';

/// Technical Skills section - structured capability matrix grouped by discipline.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final grouped = ctrl.groupedSkills;
    final entries = grouped.entries.toList();

    return SectionWrapper(
      tone: SectionTone.tinted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PortfolioSectionHeader(
            sectionIndex: '05',
            title: 'Technical Skills',
            subtitle: 'A focused stack rather than a long checklist.',
            description:
                'Organized around the frameworks, state systems, real-time APIs, and version-control workflows used in production.',
            trailing: Text(
              '${ctrl.skills.length} CAPABILITIES',
              style: AppTextStyles.mono(
                fontSize: 11,
                color: AppTokens.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppTokens.s36),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 820 ? 2 : 1;
              const gap = AppTokens.s20;
              final panelWidth = columns == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - gap) / 2;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < entries.length; i++)
                    Builder(
                      builder: (_) {
                        final isTrailingOdd =
                            columns == 2 &&
                            entries.length.isOdd &&
                            i == entries.length - 1;
                        return SizedBox(
                          width: isTrailingOdd
                              ? constraints.maxWidth
                              : panelWidth,
                          child: _SkillCategoryPanel(
                            index: i,
                            category: entries[i].key,
                            skills: entries[i].value,
                          ),
                        );
                      },
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

class _SkillCategoryPanel extends StatelessWidget {
  final int index;
  final String category;
  final List<SkillModel> skills;

  const _SkillCategoryPanel({
    required this.index,
    required this.category,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    final indexLabel = (index + 1).toString().padLeft(2, '0');

    return Container(
      padding: const EdgeInsets.all(AppTokens.s20),
      decoration: BoxDecoration(
        color: AppTokens.surface,
        borderRadius: BorderRadius.circular(AppTokens.r12),
        border: Border.all(color: AppTokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                indexLabel,
                style: AppTextStyles.mono(
                  fontSize: 11,
                  color: AppTokens.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppTokens.s8),
              Expanded(
                child: Text(
                  category.toUpperCase(),
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    color: AppTokens.textPrimary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${skills.length}',
                style: AppTextStyles.mono(
                  fontSize: 11,
                  color: AppTokens.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.s14),
          const Divider(height: 1, color: AppTokens.border),
          const SizedBox(height: AppTokens.s14),
          Column(
            children: [
              for (var i = 0; i < skills.length; i++) ...[
                SkillCard(skill: skills[i]),
                if (i < skills.length - 1) const SizedBox(height: AppTokens.s10),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
