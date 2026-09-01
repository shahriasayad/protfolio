import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:my_portfolio/features/portfolio/models/education_model.dart';

/// Education card - displays education details
class EducationCard extends StatefulWidget {
  final EducationModel item;
  final bool isLast;
  const EducationCard({super.key, required this.item, required this.isLast});

  @override
  State<EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final edu = widget.item;
    const accentColors = [AppTokens.accentBlue, AppTokens.accentPurple];
    final accentColor =
        accentColors[widget.item.hashCode % accentColors.length];

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        // margin: EdgeInsets.only(bottom: widget.isLast ? 0 : AppTokens.s20.h),
        padding: EdgeInsets.all(AppTokens.s16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
              AppTokens.surfaceSoft.withValues(alpha: 0.92),
            ],
          ),
          borderRadius: BorderRadius.circular(AppTokens.r20.r),
          border: Border.all(
            color: _hovered
                ? accentColor.withValues(alpha: 0.35)
                : AppTokens.borderStrong.withValues(alpha: 0.55),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _hovered ? 0.24 : 0.16),
              blurRadius: _hovered ? 28 : 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppTokens.s8.w),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppTokens.r12.r),
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    color: accentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppTokens.s16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edu.degree,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppTokens.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.5.sp,
                        ),
                      ),
                      SizedBox(height: AppTokens.s4.h),
                      Text(
                        edu.field,
                        style: GoogleFonts.inter(
                          color: accentColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  edu.period,
                  style: GoogleFonts.inter(
                    color: AppTokens.textMuted,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTokens.s16.h),
            Text(
              edu.school,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: AppTokens.s12.h),
            Text(
              edu.description,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 14.sp,
                // height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
