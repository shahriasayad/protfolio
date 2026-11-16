import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import '../../../models/skill_model.dart';
import '../skill/skill_bar.dart';

/// Clean capability item combining skill icon and precision SkillBar readout.
class SkillCard extends StatelessWidget {
  final SkillModel skill;

  const SkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.s14,
        vertical: AppTokens.s12,
      ),
      decoration: BoxDecoration(
        color: AppTokens.bg,
        borderRadius: BorderRadius.circular(AppTokens.r8),
        border: Border.all(color: AppTokens.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppTokens.surface,
              borderRadius: BorderRadius.circular(AppTokens.r6),
              border: Border.all(color: AppTokens.border),
            ),
            child: skill.iconPath != null
                ? Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      skill.iconPath!,
                      fit: BoxFit.contain,
                      cacheWidth: kIsWeb ? null : 64,
                    ),
                  )
                : Icon(
                    skill.icon ?? Icons.code_rounded,
                    color: AppTokens.accent,
                    size: 16,
                  ),
          ),
          const SizedBox(width: AppTokens.s12),
          Expanded(child: SkillBar(skill: skill)),
        ],
      ),
    );
  }
}
