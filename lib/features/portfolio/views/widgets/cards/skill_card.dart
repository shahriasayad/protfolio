import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
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
        borderRadius: BorderRadius.circular(AppTokens.r16.r),
        border: Border.all(
          color: AppTokens.border.withValues(alpha: 0.5),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppTokens.s16.w,
        vertical: AppTokens.s12.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTokens.surfaceGlass,
              borderRadius: BorderRadius.circular(AppTokens.r12.r),
              border: Border.all(
                color: AppTokens.borderStrong.withValues(alpha: 0.45),
              ),
            ),
            child: skill.iconPath != null
                ? Padding(
                    padding: const EdgeInsets.all(7),
                    child: Image.asset(skill.iconPath!, fit: BoxFit.contain),
                  )
                : Icon(
                    skill.icon ?? Icons.star,
                    color: AppTokens.accent,
                    size: 22,
                  ),
          ),
          SizedBox(width: AppTokens.s12.w),
          Expanded(child: SkillBar(skill: skill)),
        ],
      ),
    );
  }
}
