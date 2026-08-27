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
        transform: Matrix4.identity()..scale(_hovered ? 1.01 : 1.0),
        alignment: Alignment.center,
        padding: EdgeInsets.all(AppTokens.s20.w),
        decoration: BoxDecoration(
          color: _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r16.r),
          border: Border.all(
            color: _hovered
                ? AppTokens.borderStrong
                : AppTokens.border.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(AppTokens.s12.w),
              decoration: BoxDecoration(
                color: AppTokens.surfaceAlt.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppTokens.r12.r),
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
                      Icons.arrow_forward_rounded,
                      color: AppTokens.textSecondary,
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
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      letterSpacing: -0.5,
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
                fontSize: 13.sp,
                // height: 1.5,
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
                  color: AppTokens.border.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                p.impact,
                style: GoogleFonts.inter(
                  color: AppTokens.textPrimary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
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
