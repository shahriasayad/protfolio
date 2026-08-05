import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/features/portfolio/models/skill_model.dart';
import '../skill/skill_bar.dart';

/// Skill card - displays skill with bar
class SkillCard extends StatelessWidget {
  final SkillModel skill;
  const SkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTokens.surface,
        borderRadius: BorderRadius.circular(AppTokens.r16),
        border: Border.all(color: AppTokens.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppTokens.accent.withValues(alpha: 0.06),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.s24,
        vertical: AppTokens.s16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTokens.surfaceAlt,
              borderRadius: BorderRadius.circular(AppTokens.r8),
              border: Border.all(
                color: AppTokens.border.withValues(alpha: 0.4),
              ),
            ),
            child: skill.iconPath != null
                ? Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(skill.iconPath!, fit: BoxFit.contain),
                  )
                : Icon(
                    skill.icon ?? Icons.star,
                    color: AppTokens.accent,
                    size: 22,
                  ),
          ),
          const SizedBox(width: AppTokens.s24),
          Expanded(child: SkillBar(skill: skill)),
        ],
      ),
    );
  }
}
