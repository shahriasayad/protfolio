import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../../../models/social_link_model.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../common/hover_builder.dart';

/// Compact social profile link button.
class SocialButton extends StatelessWidget {
  final SocialLink social;

  const SocialButton({super.key, required this.social});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return HoverBuilder(
      hoverId: 'social_${social.label}',
      onTap: () => ctrl.openUrl(
        social.url,
        external: true,
        errorMessage: 'Could not open ${social.label}.',
      ),
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s14,
            vertical: AppTokens.s10,
          ),
          decoration: BoxDecoration(
            color: hovered ? AppTokens.surfaceAlt : AppTokens.bg,
            borderRadius: BorderRadius.circular(AppTokens.r8),
            border: Border.all(
              color: hovered ? AppTokens.accent : AppTokens.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                social.icon,
                color: hovered ? AppTokens.accent : AppTokens.textSecondary,
                size: 15,
              ),
              const SizedBox(width: AppTokens.s8),
              Text(
                social.label,
                style: AppTextStyles.body(
                  fontSize: 13,
                  color: hovered
                      ? AppTokens.textPrimary
                      : AppTokens.textSecondary,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
