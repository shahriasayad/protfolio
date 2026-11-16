import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../common/hover_builder.dart';

/// Minimal ghost link button for low-emphasis directional actions.
class GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const GhostButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      hoverId: 'ghost_btn_$label',
      onTap: onTap,
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s12,
            vertical: AppTokens.s12,
          ),
          decoration: BoxDecoration(
            color: hovered ? AppTokens.surfaceAlt : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTokens.r8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.button(
                  fontSize: 13,
                  color: hovered
                      ? AppTokens.textPrimary
                      : AppTokens.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: AppTokens.s6),
                Icon(
                  icon,
                  size: 15,
                  color: hovered ? AppTokens.accent : AppTokens.textSecondary,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
