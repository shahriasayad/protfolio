import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart' show AppTokens;
import 'package:my_portfolio/core/utils/icon_color_extractor.dart';
import 'package:my_portfolio/features/portfolio/models/skill_model.dart';
import '../skill/skill_bar.dart';


/// Skill card - displays skill with bar
class SkillCard extends StatefulWidget {
  final SkillModel skill;
  const SkillCard({required this.skill});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic);
    _ac.forward();

    // Extract color from icon image if iconPath is provided
    if (widget.skill.iconPath != null) {
      _extractIconColor();
    }
  }

  Future<void> _extractIconColor() async {
    if (widget.skill.iconPath != null) {
      final color = await IconColorExtractor.extractDominantColor(
        widget.skill.iconPath!,
      );
      if (mounted) {
        widget.skill.setCachedColor(color);
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
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
              child: widget.skill.iconPath != null
                  ? Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        widget.skill.iconPath!,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Icon(
                      widget.skill.icon ?? Icons.star,
                      color: AppTokens.accent,
                      size: 22,
                    ),
            ),
            const SizedBox(width: AppTokens.s24),
            Expanded(child: SkillBar(skill: widget.skill)),
          ],
        ),
      ),
    );
  }
}
