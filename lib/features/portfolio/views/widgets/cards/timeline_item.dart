import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
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
        SizedBox(
          width: 34,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: AppTokens.s8.h),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _hovered ? AppTokens.accent : AppTokens.surfaceGlass,
                  border: Border.all(
                    color: _hovered ? AppTokens.accent : AppTokens.borderStrong,
                    width: 2,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppTokens.accent.withValues(alpha: 0.35),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
              ),
              if (!widget.isLast)
                SizedBox(
                  width: 1,
                  height: AppTokens.s36.h,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: AppTokens.s4.h),
                    color: AppTokens.borderStrong.withValues(alpha: 0.75),
                  ),
                )
              else
                SizedBox(height: AppTokens.s32.h),
            ],
          ),
        ),
        SizedBox(width: AppTokens.s16.w),

        Expanded(
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget.isLast ? 0 : AppTokens.s28.h,
              ),
              child: Container(
                padding: EdgeInsets.all(AppTokens.s20.w),
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppTokens.surfaceAlt.withValues(alpha: 0.68)
                      : AppTokens.surfaceGlass,
                  borderRadius: BorderRadius.circular(AppTokens.r20.r),
                  border: Border.all(
                    color: _hovered
                        ? AppTokens.accent.withValues(alpha: 0.22)
                        : AppTokens.borderStrong.withValues(alpha: 0.42),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            e.role,
                            style: GoogleFonts.spaceGrotesk(
                              color: AppTokens.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppTokens.s12),
                        Text(
                          e.period,
                          style: GoogleFonts.inter(
                            color: AppTokens.textMuted,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTokens.s6.h),
                    Text(
                      e.company,
                      style: GoogleFonts.inter(
                        color: AppTokens.accent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: AppTokens.s8.h),
                    Text(
                      e.description,
                      style: GoogleFonts.inter(
                        color: AppTokens.textSecondary,
                        fontSize: 14.sp,
                        // height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
