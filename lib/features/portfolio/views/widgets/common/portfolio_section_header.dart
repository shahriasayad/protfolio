import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';

/// Editorial section header with monospace index, display title, subtitle, and lead copy.
class PortfolioSectionHeader extends StatelessWidget {
  final String sectionIndex;
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? trailing;

  const PortfolioSectionHeader({
    super.key,
    required this.sectionIndex,
    required this.title,
    this.subtitle,
    this.description,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = AppScreenUtil.isMobileWidth(width);

    final headerContent = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppTokens.sectionLeadWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                sectionIndex,
                style: AppTextStyles.mono(
                  fontSize: 12,
                  color: AppTokens.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppTokens.s8),
              Container(
                width: 24,
                height: 1,
                color: AppTokens.borderStrong,
              ),
              const SizedBox(width: AppTokens.s8),
              Flexible(
                child: Text(
                  title.toUpperCase(),
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    color: AppTokens.textMuted,
                    letterSpacing: 1.4,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.s14),
          Text(
            subtitle ?? title,
            style: AppTextStyles.sectionTitle(isMobile: isMobile),
          ),
          if (description != null && description!.trim().isNotEmpty) ...[
            const SizedBox(height: AppTokens.s12),
            Text(
              description!,
              style: AppTextStyles.body(
                fontSize: isMobile ? 14 : 15,
                color: AppTokens.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );

    if (trailing == null) {
      return headerContent;
    }

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerContent,
          const SizedBox(height: AppTokens.s16),
          trailing!,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: headerContent),
        const SizedBox(width: AppTokens.s24),
        trailing!,
      ],
    );
  }
}
