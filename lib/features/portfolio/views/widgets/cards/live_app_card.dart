import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../../../models/live_app_model.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../common/hover_builder.dart';

/// Production app showcase card with always-visible features and store actions.
class LiveAppCard extends StatelessWidget {
  final LiveAppModel app;
  final int index;
  final bool reverseLayout;

  const LiveAppCard({
    super.key,
    required this.app,
    required this.index,
    this.reverseLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final hasStoreRelease =
        app.appStoreLink != null || app.playStoreLink != null;
    final badgeLabel = app.testFlightLink != null
        ? 'TESTFLIGHT BETA'
        : hasStoreRelease
        ? 'LIVE ON STORES'
        : 'PRODUCTION';
    final badgeColor = app.testFlightLink != null
        ? AppTokens.accent
        : AppTokens.statusLive;
    final indexLabel = (index + 1).toString().padLeft(2, '0');

    return HoverBuilder(
      hoverId: 'live_app_${app.title}',
      cursor: MouseCursor.defer,
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: hovered ? AppTokens.surfaceAlt : AppTokens.surface,
            borderRadius: BorderRadius.circular(AppTokens.r12),
            border: Border.all(
              color: hovered ? AppTokens.borderStrong : AppTokens.border,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;
              final media = _AppPreviewFrame(
                imagePath: app.coverImagePath,
                hovered: hovered,
              );
              final details = _AppDetailsPanel(
                app: app,
                indexLabel: indexLabel,
                badgeLabel: badgeLabel,
                badgeColor: badgeColor,
                onOpenUrl: (url) => ctrl.openUrl(url, external: true),
              );

              if (!isWide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    media,
                    Padding(
                      padding: const EdgeInsets.all(AppTokens.s20),
                      child: details,
                    ),
                  ],
                );
              }

              final children = reverseLayout
                  ? <Widget>[
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(AppTokens.s28),
                          child: details,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(AppTokens.s16),
                          child: media,
                        ),
                      ),
                    ]
                  : <Widget>[
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(AppTokens.s16),
                          child: media,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(AppTokens.s28),
                          child: details,
                        ),
                      ),
                    ];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              );
            },
          ),
        );
      },
    );
  }
}

class _AppPreviewFrame extends StatelessWidget {
  final String imagePath;
  final bool hovered;

  const _AppPreviewFrame({
    required this.imagePath,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTokens.r8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppTokens.bg,
          border: Border.all(color: AppTokens.border),
          borderRadius: BorderRadius.circular(AppTokens.r8),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: AnimatedScale(
            scale: hovered ? 1.03 : 1.0,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              cacheWidth: kIsWeb ? null : 1000,
              errorBuilder: (context, error, stackTrace) => const ColoredBox(
                color: AppTokens.surfaceAlt,
                child: Center(
                  child: Icon(
                    Icons.phone_iphone_rounded,
                    size: 40,
                    color: AppTokens.textMuted,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppDetailsPanel extends StatelessWidget {
  final LiveAppModel app;
  final String indexLabel;
  final String badgeLabel;
  final Color badgeColor;
  final ValueChanged<String?> onOpenUrl;

  const _AppDetailsPanel({
    required this.app,
    required this.indexLabel,
    required this.badgeLabel,
    required this.badgeColor,
    required this.onOpenUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppTokens.s12,
          runSpacing: AppTokens.s8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'APP $indexLabel',
              style: AppTextStyles.mono(
                fontSize: 11,
                color: AppTokens.textMuted,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.s8,
                vertical: AppTokens.s4,
              ),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppTokens.r4),
                border: Border.all(color: badgeColor.withValues(alpha: 0.35)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppTokens.s6),
                  Text(
                    badgeLabel,
                    style: AppTextStyles.mono(
                      fontSize: 10,
                      color: badgeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTokens.s14),
        Text(
          app.title,
          style: AppTextStyles.cardTitle(fontSize: 22),
        ),
        const SizedBox(height: AppTokens.s8),
        Text(
          app.description,
          style: AppTextStyles.body(
            fontSize: 14,
            color: AppTokens.textSecondary,
            height: 1.55,
          ),
        ),
        const SizedBox(height: AppTokens.s16),
        Wrap(
          spacing: AppTokens.s16,
          runSpacing: AppTokens.s8,
          children: app.features
              .map(
                (feature) => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '→',
                      style: AppTextStyles.mono(
                        fontSize: 11,
                        color: AppTokens.accent,
                      ),
                    ),
                    const SizedBox(width: AppTokens.s6),
                    Flexible(
                      child: Text(
                        feature,
                        style: AppTextStyles.body(
                          fontSize: 12,
                          color: AppTokens.textPrimary,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
        const SizedBox(height: AppTokens.s20),
        Wrap(
          spacing: AppTokens.s10,
          runSpacing: AppTokens.s10,
          children: [
            if (app.testFlightLink != null)
              _StoreButton(
                hoverId: 'store_tf_${app.title}',
                icon: Icons.flight_takeoff_rounded,
                label: 'Open TestFlight',
                onTap: () => onOpenUrl(app.testFlightLink),
              ),
            if (app.appStoreLink != null)
              _StoreButton(
                hoverId: 'store_ios_${app.title}',
                icon: Icons.apple_rounded,
                label: 'App Store',
                onTap: () => onOpenUrl(app.appStoreLink),
              ),
            if (app.playStoreLink != null)
              _StoreButton(
                hoverId: 'store_play_${app.title}',
                icon: Icons.play_arrow_rounded,
                label: 'Google Play',
                onTap: () => onOpenUrl(app.playStoreLink),
              ),
          ],
        ),
      ],
    );
  }
}

class _StoreButton extends StatelessWidget {
  final String hoverId;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StoreButton({
    required this.hoverId,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      hoverId: hoverId,
      onTap: onTap,
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s14,
            vertical: AppTokens.s8,
          ),
          decoration: BoxDecoration(
            color: hovered ? AppTokens.accent : AppTokens.bg,
            borderRadius: BorderRadius.circular(AppTokens.r6),
            border: Border.all(
              color: hovered ? AppTokens.accent : AppTokens.borderStrong,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: hovered ? AppTokens.bg : AppTokens.textPrimary,
              ),
              const SizedBox(width: AppTokens.s8),
              Text(
                label,
                style: AppTextStyles.button(
                  fontSize: 12,
                  color: hovered ? AppTokens.bg : AppTokens.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppTokens.s6),
              Icon(
                Icons.north_east_rounded,
                size: 13,
                color: hovered ? AppTokens.bg : AppTokens.textMuted,
              ),
            ],
          ),
        );
      },
    );
  }
}
