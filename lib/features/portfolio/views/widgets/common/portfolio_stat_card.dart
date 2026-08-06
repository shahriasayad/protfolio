import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import '../../../models/portfolio_stat_model.dart';

class PortfolioStatCard extends StatelessWidget {
  final PortfolioStatModel stat;

  const PortfolioStatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTokens.s16),
      decoration: BoxDecoration(
        color: AppTokens.surfaceGlass,
        borderRadius: BorderRadius.circular(AppTokens.r16),
        border: Border.all(color: stat.accent.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: stat.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTokens.r8),
                ),
                child: Icon(stat.icon, color: stat.accent, size: 16),
              ),
              const Spacer(),
              Text(
                stat.value,
                style: GoogleFonts.spaceGrotesk(
                  color: AppTokens.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.s12),
          Text(
            stat.label,
            style: GoogleFonts.inter(
              color: AppTokens.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppTokens.s4),
          Text(
            stat.detail,
            style: GoogleFonts.inter(
              color: AppTokens.textMuted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
