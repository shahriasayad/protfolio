import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../common/hover_builder.dart';

/// Direct email trigger with inline clipboard copy action.
class EmailButton extends StatelessWidget {
  final String email;

  const EmailButton({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return Row(
      children: [
        Flexible(
          child: HoverBuilder(
            hoverId: 'email_launch',
            onTap: ctrl.openEmailClient,
            builder: (context, hovered) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTokens.s14,
                  vertical: AppTokens.s10,
                ),
                decoration: BoxDecoration(
                  color: AppTokens.bg,
                  borderRadius: BorderRadius.circular(AppTokens.r8),
                  border: Border.all(
                    color: hovered ? AppTokens.accent : AppTokens.borderStrong,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.mail_outline_rounded,
                      size: 16,
                      color: hovered
                          ? AppTokens.accent
                          : AppTokens.textSecondary,
                    ),
                    const SizedBox(width: AppTokens.s10),
                    Flexible(
                      child: Text(
                        email,
                        style: AppTextStyles.mono(
                          fontSize: 13,
                          color: hovered
                              ? AppTokens.accent
                              : AppTokens.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(width: AppTokens.s8),
        HoverBuilder(
          hoverId: 'email_copy',
          onTap: ctrl.copyEmail,
          builder: (context, hovered) {
            return Tooltip(
              message: 'Copy email',
              child: Container(
                padding: const EdgeInsets.all(AppTokens.s10),
                decoration: BoxDecoration(
                  color: hovered ? AppTokens.surfaceAlt : AppTokens.bg,
                  borderRadius: BorderRadius.circular(AppTokens.r8),
                  border: Border.all(
                    color: hovered ? AppTokens.accent : AppTokens.borderStrong,
                  ),
                ),
                child: Icon(
                  Icons.copy_rounded,
                  size: 16,
                  color: hovered ? AppTokens.accent : AppTokens.textSecondary,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
