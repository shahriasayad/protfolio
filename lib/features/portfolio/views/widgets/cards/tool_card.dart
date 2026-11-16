import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../../../models/tool_model.dart';
import '../common/hover_builder.dart';

/// Compact developer workbench tile for an IDE, design, or API tool.
class ToolCard extends StatelessWidget {
  final ToolModel tool;
  final int index;

  const ToolCard({
    super.key,
    required this.tool,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final indexLabel = (index + 1).toString().padLeft(2, '0');

    return HoverBuilder(
      hoverId: 'tool_${tool.name}',
      cursor: MouseCursor.defer,
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(AppTokens.s16),
          decoration: BoxDecoration(
            color: hovered ? AppTokens.surfaceAlt : AppTokens.surface,
            borderRadius: BorderRadius.circular(AppTokens.r8),
            border: Border.all(
              color: hovered ? AppTokens.accent : AppTokens.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(AppTokens.s8),
                decoration: BoxDecoration(
                  color: AppTokens.bg,
                  borderRadius: BorderRadius.circular(AppTokens.r8),
                  border: Border.all(color: AppTokens.border),
                ),
                child: Image.asset(
                  tool.iconPath,
                  fit: BoxFit.contain,
                  cacheWidth: kIsWeb ? null : 80,
                ),
              ),
              const SizedBox(width: AppTokens.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tool.name,
                      style: AppTextStyles.body(
                        fontSize: 14,
                        color: AppTokens.textPrimary,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTokens.s4),
                    Text(
                      tool.role,
                      style: AppTextStyles.mono(
                        fontSize: 11,
                        color: hovered ? AppTokens.accent : AppTokens.textMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTokens.s8),
              Text(
                indexLabel,
                style: AppTextStyles.mono(
                  fontSize: 11,
                  color: AppTokens.textMuted,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
