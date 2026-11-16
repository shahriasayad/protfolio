import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../common/hover_builder.dart';

/// Primary action button with crisp fill and subtle hover elevation.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      hoverId: 'primary_btn_$label',
      onTap: onTap,
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s20,
            vertical: AppTokens.s12,
          ),
          decoration: BoxDecoration(
            color: hovered ? AppTokens.accent : AppTokens.textPrimary,
            borderRadius: BorderRadius.circular(AppTokens.r8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.button(
                  fontSize: 13,
                  color: AppTokens.bg,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: AppTokens.s8),
                Icon(icon, size: 15, color: AppTokens.bg),
              ],
            ],
          ),
        );
      },
    );
  }
}
