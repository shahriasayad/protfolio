import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/cards/live_app_card.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/common/section_wrapper.dart';

/// Live Apps section - shipped production applications with prominent store links.
class LiveAppsSection extends StatelessWidget {
  const LiveAppsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      tone: SectionTone.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PortfolioSectionHeader(
            sectionIndex: '03',
            title: 'Live Apps',
            subtitle: 'Products I have built that are currently in production.',
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.s12,
                vertical: AppTokens.s6,
              ),
              decoration: BoxDecoration(
                color: AppTokens.statusLiveSoft,
                borderRadius: BorderRadius.circular(AppTokens.r6),
                border: Border.all(
                  color: AppTokens.statusLive.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                '${ctrl.liveApps.length} SHIPPED PRODUCTS',
                style: AppTextStyles.mono(
                  fontSize: 11,
                  color: AppTokens.statusLive,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppTokens.s36),
          Column(
            children: [
              for (var i = 0; i < ctrl.liveApps.length; i++) ...[
                LiveAppCard(
                  app: ctrl.liveApps[i],
                  index: i,
                  reverseLayout: i.isOdd,
                ),
                if (i < ctrl.liveApps.length - 1)
                  const SizedBox(height: AppTokens.s24),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
