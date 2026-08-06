import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:my_portfolio/features/portfolio/models/project_model.dart';

/// Project card - displays project info
class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: EdgeInsets.all(AppTokens.s20.w),
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
                ? AppTokens.accent.withValues(alpha: 0.45)
                : AppTokens.borderStrong.withValues(alpha: 0.55),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _hovered ? 0.28 : 0.18),
              blurRadius: _hovered ? 36 : 22,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(AppTokens.s12.w),
              decoration: BoxDecoration(
                color: AppTokens.accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppTokens.r16.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppTokens.bg.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(AppTokens.r12.r),
                      border: Border.all(
                        color: AppTokens.border.withValues(alpha: 0.7),
                      ),
                    ),
                    child: Center(
                      child: Text(p.emoji, style: TextStyle(fontSize: 22.sp)),
                    ),
                  ),
                  const Spacer(),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _hovered ? 1 : 0.35,
                    child: Icon(
                      Icons.arrow_outward,
                      color: AppTokens.accent,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppTokens.s16.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    p.title,
                    style: GoogleFonts.spaceGrotesk(
                      color: AppTokens.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                const SizedBox(width: AppTokens.s8),
              ],
            ),
            SizedBox(height: AppTokens.s8.h),
            Text(
              p.description,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 14.sp,
                height: 1.7,
              ),
            ),
            SizedBox(height: AppTokens.s16.h),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppTokens.s12.w,
                vertical: AppTokens.s8.h,
              ),
              decoration: BoxDecoration(
                color: AppTokens.bg.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(AppTokens.r12.r),
                border: Border.all(
                  color: AppTokens.border.withValues(alpha: 0.65),
                ),
              ),
              child: Text(
                p.impact,
                style: GoogleFonts.inter(
                  color: AppTokens.textPrimary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: AppTokens.s16.h),

            Wrap(
              spacing: AppTokens.s6.w,
              runSpacing: AppTokens.s6.h,
              children: p.tech
                  .map(
                    (t) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTokens.s10.w,
                        vertical: AppTokens.s5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTokens.surfaceGlass,
                        borderRadius: BorderRadius.circular(AppTokens.r999.r),
                        border: Border.all(
                          color: AppTokens.borderStrong.withValues(alpha: 0.55),
                        ),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.inter(
                          color: AppTokens.textPrimary,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
