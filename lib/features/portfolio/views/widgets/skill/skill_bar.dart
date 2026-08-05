import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/features/portfolio/models/skill_model.dart';

/// Skill bar - animated proficiency bar
class SkillBar extends StatelessWidget {
  final SkillModel skill;
  const SkillBar({super.key, required this.skill});

  Color _getCategoryColor(String category) {
    if (skill.cachedColor != null) {
      return skill.cachedColor!;
    }

    switch (category) {
      case 'Frontend':
        return AppTokens.accentBlue;
      case 'State Management':
        return AppTokens.accent;
      case 'Backend':
        return AppTokens.accentPurple;
      case 'Local Storage':
        return AppTokens.accentPink;
      case 'DevOps':
        return AppTokens.accentOrange;
      case 'Design':
        return AppTokens.accentPink;
      default:
        return AppTokens.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final barColor = _getCategoryColor(skill.category);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<double>(begin: 0, end: skill.proficiency),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  skill.name,
                  style: GoogleFonts.inter(
                    color: AppTokens.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(skill.proficiency * 100).toStringAsFixed(0)}%',
                  style: GoogleFonts.inter(
                    color: barColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.s12),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTokens.r999),
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: AppTokens.border.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppTokens.r999),
                  border: Border.all(
                    color: AppTokens.border.withValues(alpha: 0.2),
                    width: 0.5,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTokens.border.withValues(alpha: 0.05),
                            AppTokens.border.withValues(alpha: 0.0),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(AppTokens.r999),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              barColor.withValues(alpha: 0.9),
                              barColor.withValues(alpha: 0.6),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: const [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(AppTokens.r999),
                          boxShadow: [
                            BoxShadow(
                              color: barColor.withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                            BoxShadow(
                              color: barColor.withValues(alpha: 0.2),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (value > 0)
                      FractionallySizedBox(
                        widthFactor: value,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.0),
                                Colors.white.withValues(alpha: 0.15),
                                Colors.white.withValues(alpha: 0.0),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: const [0.0, 0.5, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(AppTokens.r999),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
