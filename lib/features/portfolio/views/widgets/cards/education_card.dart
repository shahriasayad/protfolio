import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../../models/education_model.dart';
import '../common/hover_builder.dart';

/// Academic timeline entry aligned with the architectural rail grammar.
class EducationCard extends StatelessWidget {
  final EducationModel item;
  final bool isLast;

  const EducationCard({
    super.key,
    required this.item,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = AppScreenUtil.isMobileWidth(width);

    return HoverBuilder(
      hoverId: 'edu_${item.degree}_${item.period}',
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
                    padding: const EdgeInsets.only(top: 4, right: AppTokens.s16),
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
              SizedBox(
                width: 20,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: hovered ? AppTokens.accent : AppTokens.borderStrong,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1,
                          margin: const EdgeInsets.symmetric(
                            vertical: AppTokens.s6,
                          ),
                          color: AppTokens.border,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppTokens.s16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: isLast ? AppTokens.s8 : AppTokens.s24,
                  ),
                  margin: EdgeInsets.only(
                    bottom: isLast ? 0 : AppTokens.s16,
                  ),
                  decoration: isLast
                      ? null
                      : const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppTokens.border),
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
                        item.degree,
                        style: AppTextStyles.cardTitle(fontSize: 18),
                      ),
                      const SizedBox(height: AppTokens.s4),
                      Text(
                        '${item.field}  ·  ${item.school}',
                        style: AppTextStyles.body(
                          fontSize: 14,
                          color: AppTokens.accent,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
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
