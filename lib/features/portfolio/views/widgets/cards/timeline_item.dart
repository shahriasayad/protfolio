import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../../models/experience_model.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../common/hover_builder.dart';

/// Architectural work-history timeline item.
class TimelineItem extends StatelessWidget {
  final ExperienceModel item;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.item,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = AppScreenUtil.isMobileWidth(width);

    return HoverBuilder(
      hoverId: 'exp_${item.company}_${item.period}',
      cursor: MouseCursor.defer,
      builder: (context, hovered) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isMobile) ...[
                SizedBox(
                  width: 210,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, right: AppTokens.s16),
                    child: Text(
                      item.period,
                      style: AppTextStyles.mono(
                        fontSize: 12,
                        color: hovered
                            ? AppTokens.accent
                            : AppTokens.textMuted,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
              _TimelineRail(hovered: hovered, isLast: isLast),
              const SizedBox(width: AppTokens.s16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : AppTokens.s24,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.all(AppTokens.s20),
                    decoration: BoxDecoration(
                      color: hovered ? AppTokens.surfaceAlt : AppTokens.surface,
                      borderRadius: BorderRadius.circular(AppTokens.r10),
                      border: Border.all(
                        color: hovered
                            ? AppTokens.borderStrong
                            : AppTokens.border,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isMobile) ...[
                          Text(
                            item.period,
                            style: AppTextStyles.mono(
                              fontSize: 11,
                              color: AppTokens.accent,
                            ),
                          ),
                          const SizedBox(height: AppTokens.s6),
                        ],
                        Text(
                          item.role,
                          style: AppTextStyles.cardTitle(fontSize: 19),
                        ),
                        const SizedBox(height: AppTokens.s6),
                        if (item.companyUrl != null)
                          HoverBuilder(
                            hoverId: 'exp_link_${item.company}',
                            onTap: () => ctrl.openUrl(
                              item.companyUrl,
                              external: true,
                            ),
                            builder: (context, linkHovered) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    item.company,
                                    style: AppTextStyles.getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: linkHovered
                                          ? AppTokens.accent
                                          : AppTokens.textSecondary,
                                      decoration: linkHovered
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      decorationColor: AppTokens.accent,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppTokens.s4),
                                Icon(
                                  Icons.north_east_rounded,
                                  size: 14,
                                  color: linkHovered
                                      ? AppTokens.accent
                                      : AppTokens.textMuted,
                                ),
                              ],
                            ),
                          )
                        else
                          Text(
                            item.company,
                            style: AppTextStyles.body(
                              fontSize: 14,
                              color: AppTokens.accent,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                        const SizedBox(height: AppTokens.s12),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimelineRail extends StatelessWidget {
  final bool hovered;
  final bool isLast;

  const _TimelineRail({required this.hovered, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: Column(
        children: [
          const SizedBox(height: 6),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hovered ? AppTokens.accent : AppTokens.bg,
              border: Border.all(
                color: hovered ? AppTokens.accent : AppTokens.borderStrong,
                width: 2,
              ),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 1,
                margin: const EdgeInsets.symmetric(vertical: AppTokens.s6),
                color: AppTokens.border,
              ),
            ),
        ],
      ),
    );
  }
}
