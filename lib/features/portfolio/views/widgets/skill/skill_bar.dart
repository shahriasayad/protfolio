import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/features/portfolio/models/skill_model.dart';

/// Skill bar - animated proficiency bar
class SkillBar extends StatefulWidget {
  final SkillModel skill;
  const SkillBar({required this.skill});

  @override
  State<SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _widthAnim;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _widthAnim = Tween<double>(
      begin: 0,
      end: widget.skill.proficiency,
    ).animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic));
    _ac.forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  Color _getCategoryColor(String category) {
    // First, check if we have a cached color from the icon
    if (widget.skill.cachedColor != null) {
      return widget.skill.cachedColor!;
    }

    // Fall back to category-based colors
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
    final barColor = _getCategoryColor(widget.skill.category);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.skill.name,
              style: GoogleFonts.inter(
                color: AppTokens.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${(widget.skill.proficiency * 100).toStringAsFixed(0)}%',
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
            child: AnimatedBuilder(
              animation: _widthAnim,
              builder: (context, _) {
                return Stack(
                  children: [
                    // Background gradient overlay
                    Container(
                      width: double.infinity,
                      height: double.infinity,
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
                    // Progress fill
                    FractionallySizedBox(
                      widthFactor: _widthAnim.value,
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
                              spreadRadius: 0,
                              offset: const Offset(0, 2),
                            ),
                            BoxShadow(
                              color: barColor.withValues(alpha: 0.2),
                              blurRadius: 24,
                              spreadRadius: 2,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Shine effect
                    if (_widthAnim.value > 0)
                      FractionallySizedBox(
                        widthFactor: _widthAnim.value,
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
