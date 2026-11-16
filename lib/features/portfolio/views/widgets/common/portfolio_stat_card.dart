import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../../../models/portfolio_stat_model.dart';

/// Editorial metric ledger item with top accent hairline and tabular value.
class PortfolioStatCard extends StatelessWidget {
  final PortfolioStatModel stat;

  const PortfolioStatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppTokens.s14, right: AppTokens.s12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTokens.borderStrong)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                stat.value.padLeft(2, '0'),
                style: AppTextStyles.getTextStyle(
                  family: AppFontFamily.display,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppTokens.textPrimary,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(width: AppTokens.s8),
              Icon(stat.icon, color: stat.accent, size: 16),
            ],
          ),
          const SizedBox(height: AppTokens.s6),
          Text(
            stat.label,
            style: AppTextStyles.body(
              fontSize: 13,
              color: AppTokens.textPrimary,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: AppTokens.s4),
          Text(
            stat.detail,
            style: AppTextStyles.body(
              fontSize: 12,
              color: AppTokens.textMuted,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
