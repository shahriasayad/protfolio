import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../buttons/ghost_button.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import 'portfolio_stat_card.dart';

/// Hero editorial narrative column: availability status, display title, CTAs, and stats.
class HeroTextContent extends StatelessWidget {
  final PortfolioController ctrl;
  final VoidCallback onHire;
  final VoidCallback onProjects;

  const HeroTextContent({
    super.key,
    required this.ctrl,
    required this.onHire,
    required this.onProjects,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = AppScreenUtil.isMobileWidth(width);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Monospace availability & discipline tag
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s12,
            vertical: AppTokens.s6,
          ),
          decoration: BoxDecoration(
            color: AppTokens.surface,
            borderRadius: BorderRadius.circular(AppTokens.r6),
            border: Border.all(color: AppTokens.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppTokens.statusLive,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppTokens.s8),
              Flexible(
                child: Obx(
                  () => Text(
                    '${ctrl.title.value.toUpperCase()}  ·  PRODUCT & UI SYSTEMS',
                    style: AppTextStyles.mono(
                      fontSize: 11,
                      color: AppTokens.textSecondary,
                      letterSpacing: 0.9,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTokens.s20),

        // Display name
        Obx(
          () => Text(
            ctrl.name.value,
            style: AppTextStyles.heroDisplay(isMobile: isMobile),
          ),
        ),
        const SizedBox(height: AppTokens.s12),

        // Brand headline
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            ctrl.brandHeadline,
            style: AppTextStyles.heroStatement(isMobile: isMobile),
          ),
        ),
        const SizedBox(height: AppTokens.s14),

        // Summary + Intro
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Obx(
            () => Text(
              '${ctrl.intro.value} ${ctrl.brandSummary}',
              style: AppTextStyles.body(
                fontSize: isMobile ? 14 : 15,
                color: AppTokens.textMuted,
                height: 1.65,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppTokens.s24),

        // Availability inline spec note
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(
                Icons.terminal_rounded,
                size: 14,
                color: AppTokens.accent,
              ),
            ),
            const SizedBox(width: AppTokens.s8),
            Expanded(
              child: Text(
                ctrl.availabilityNote,
                style: AppTextStyles.mono(
                  fontSize: 12,
                  color: AppTokens.textSecondary,
                  letterSpacing: 0.1,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTokens.s24),

        // CTA Cluster
        Wrap(
          spacing: AppTokens.s12,
          runSpacing: AppTokens.s12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            PrimaryButton(
              label: 'View CV',
              icon: Icons.north_east_rounded,
              onTap: ctrl.downloadCV,
            ),
            SecondaryButton(
              label: 'Get in Touch',
              onTap: onHire,
            ),
            GhostButton(
              label: 'Explore Projects',
              icon: Icons.south_rounded,
              onTap: onProjects,
            ),
          ],
        ),
        const SizedBox(height: AppTokens.s40),

        // Architectural 3-column metrics strip
        LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 480;
            if (narrow) {
              return Column(
                children: ctrl.heroStats
                    .map(
                      (stat) => Padding(
                        padding: const EdgeInsets.only(bottom: AppTokens.s16),
                        child: PortfolioStatCard(stat: stat),
                      ),
                    )
                    .toList(),
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < ctrl.heroStats.length; i++) ...[
                  Expanded(child: PortfolioStatCard(stat: ctrl.heroStats[i])),
                  if (i < ctrl.heroStats.length - 1)
                    const SizedBox(width: AppTokens.s16),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
