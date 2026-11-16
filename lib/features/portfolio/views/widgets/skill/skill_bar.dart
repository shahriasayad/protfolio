import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../../../models/skill_model.dart';

/// Compact skill row showing label, tier metadata, and a restrained 2px gauge.
class SkillBar extends StatelessWidget {
  final SkillModel skill;

  const SkillBar({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final pct = (skill.proficiency * 100).round();
    final isCore = skill.proficiency >= 0.88;
    final accentColor = isCore ? AppTokens.accent : AppTokens.textSecondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                skill.name,
                style: AppTextStyles.body(
                  fontSize: 14,
                  color: AppTokens.textPrimary,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppTokens.s8),
            Text(
              skill.tierLabel.toUpperCase(),
              style: AppTextStyles.mono(
                fontSize: 10,
                color: isCore ? AppTokens.accent : AppTokens.textMuted,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(width: AppTokens.s8),
            Text(
              '$pct%',
              style: AppTextStyles.mono(
                fontSize: 11,
                color: AppTokens.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTokens.s8),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTokens.r999),
          child: SizedBox(
            height: 2.5,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ColoredBox(color: AppTokens.border),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: skill.proficiency.clamp(0.0, 1.0),
                  child: ColoredBox(color: accentColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
