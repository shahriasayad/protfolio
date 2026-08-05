import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/features/portfolio/models/experience_model.dart';


/// Timeline item - displays experience in a timeline
class TimelineItem extends StatefulWidget {
  final ExperienceModel item;
  final bool isLast;
  const TimelineItem({super.key, required this.item, required this.isLast});

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final e = widget.item;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline column
        SizedBox(
          width: 32,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _hovered ? AppTokens.accent : AppTokens.border,
                  border: Border.all(
                    color: _hovered ? AppTokens.accent : AppTokens.textMuted,
                    width: 2,
                  ),
                ),
              ),
              if (!widget.isLast)
                SizedBox(
                  width: 1,
                  height: AppTokens.s32,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: AppTokens.border,
                  ),
                )
              else
                const SizedBox(height: AppTokens.s32),
            ],
          ),
        ),
        const SizedBox(width: AppTokens.s16),

        // Content
        Expanded(
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget.isLast ? 0 : AppTokens.s32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        e.role,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppTokens.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        e.period,
                        style: GoogleFonts.inter(
                          color: AppTokens.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTokens.s4),
                  Text(
                    e.company,
                    style: GoogleFonts.inter(
                      color: AppTokens.accent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppTokens.s8),
                  Text(
                    e.description,
                    style: GoogleFonts.inter(
                      color: AppTokens.textSecondary,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
