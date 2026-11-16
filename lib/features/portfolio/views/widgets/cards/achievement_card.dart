import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../../models/achievement_model.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../common/hover_builder.dart';

/// Restrained editorial achievement row with hairline divider and organization link.
class AchievementCard extends StatelessWidget {
  final AchievementModel item;
  final int index;
  final bool isLast;

  const AchievementCard({
    super.key,
    required this.item,
    this.index = 0,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = AppScreenUtil.isMobileWidth(width);
    final indexLabel = (index + 1).toString().padLeft(2, '0');

    return HoverBuilder(
      hoverId: 'ach_${item.title}',
      onTap: () => ctrl.openUrl(
        item.organizationUrl,
        external: true,
        errorMessage: 'Could not launch URL.',
      ),
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(
            vertical: AppTokens.s24,
            horizontal: AppTokens.s16,
          ),
          decoration: BoxDecoration(
            color: hovered ? AppTokens.surface : Colors.transparent,
            border: Border(
              top: const BorderSide(color: AppTokens.border),
              bottom: isLast
                  ? const BorderSide(color: AppTokens.border)
                  : BorderSide.none,
            ),
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AchievementMeta(
                      indexLabel: indexLabel,
                      organization: item.organization,
                      hovered: hovered,
                    ),
                    const SizedBox(height: AppTokens.s10),
                    Text(
                      item.title,
                      style: AppTextStyles.cardTitle(fontSize: 18),
                    ),
                    const SizedBox(height: AppTokens.s8),
                    Text(
                      item.description,
                      style: AppTextStyles.body(
                        fontSize: 14,
                        color: AppTokens.textSecondary,
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 240,
                      child: _AchievementMeta(
                        indexLabel: indexLabel,
                        organization: item.organization,
                        hovered: hovered,
                      ),
                    ),
                    const SizedBox(width: AppTokens.s24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: AppTextStyles.cardTitle(fontSize: 19),
                          ),
                          const SizedBox(height: AppTokens.s6),
                          Text(
                            item.description,
                            style: AppTextStyles.body(
                              fontSize: 14,
                              color: AppTokens.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppTokens.s16),
                    Icon(
                      Icons.north_east_rounded,
                      size: 16,
                      color: hovered ? AppTokens.accent : AppTokens.textMuted,
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _AchievementMeta extends StatelessWidget {
  final String indexLabel;
  final String organization;
  final bool hovered;

  const _AchievementMeta({
    required this.indexLabel,
    required this.organization,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HIGHLIGHT $indexLabel',
          style: AppTextStyles.mono(
            fontSize: 11,
            color: AppTokens.textMuted,
          ),
        ),
        const SizedBox(height: AppTokens.s6),
        Text(
          organization,
          style: AppTextStyles.getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: hovered ? AppTokens.accent : AppTokens.textPrimary,
            decoration: hovered
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: AppTokens.accent,
          ),
        ),
      ],
    );
  }
}
