import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:my_portfolio/features/portfolio/models/project_model.dart';

class FeaturedProjectCard extends StatelessWidget {
  final ProjectModel project;

  const FeaturedProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isWide = AppScreenUtil.screenWidth > 900;

    return Container(
      decoration: BoxDecoration(
        color: AppTokens.surface,
        borderRadius: BorderRadius.circular(AppTokens.r20.r),
        border: Border.all(
          color: AppTokens.border.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTokens.s24.w),
        child: isWide
            ? Row(
                children: [
                  Expanded(child: _ProjectStory(project: project)),
                  SizedBox(width: AppTokens.s24.w),
                  Expanded(child: _ProjectPreview(project: project)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProjectPreview(project: project),
                  SizedBox(height: AppTokens.s24.h),
                  _ProjectStory(project: project),
                ],
              ),
      ),
    );
  }
}

class _ProjectStory extends StatelessWidget {
  final ProjectModel project;

  const _ProjectStory({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTokens.s12.w,
            vertical: AppTokens.s4.h,
          ),
          decoration: BoxDecoration(
            color: AppTokens.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppTokens.r999.r),
          ),
          child: Text(
            'Featured case study',
            style: GoogleFonts.inter(
              color: AppTokens.accent,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
        ),
        SizedBox(height: AppTokens.s16.h),
        Text(
          project.title,
          style: GoogleFonts.spaceGrotesk(
            color: AppTokens.textPrimary,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.8,
            height: 1.1,
          ),
        ),
        SizedBox(height: AppTokens.s12.h),
        Text(
          project.description,
          style: GoogleFonts.inter(
            color: AppTokens.textSecondary,
            fontSize: 14.sp,
            height: 1.6,
          ),
        ),
        SizedBox(height: AppTokens.s16.h),
        _ImpactRow(impact: project.impact),
        SizedBox(height: AppTokens.s24.h),
        Wrap(
          spacing: AppTokens.s8.w,
          runSpacing: AppTokens.s8.h,
          children: project.tech
              .map(
                (tech) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTokens.s12.w,
                    vertical: AppTokens.s6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTokens.bg.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(AppTokens.r999.r),
                    border: Border.all(
                      color: AppTokens.border.withValues(alpha: 0.7),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: GoogleFonts.inter(
                      color: AppTokens.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ProjectPreview extends StatelessWidget {
  final ProjectModel project;

  const _ProjectPreview({required this.project});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.18,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTokens.r16.r),
          color: AppTokens.bg,
          border: Border.all(
            color: AppTokens.border,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppTokens.s16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _WindowDot(color: AppTokens.accentPink),
                  const SizedBox(width: 6),
                  _WindowDot(color: AppTokens.accentOrange),
                  const SizedBox(width: 6),
                  _WindowDot(color: AppTokens.accent),
                  const Spacer(),
                  Text(project.emoji, style: TextStyle(fontSize: 20.sp)),
                ],
              ),
              SizedBox(height: AppTokens.s16.h),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTokens.r16.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTokens.surfaceAlt.withValues(alpha: 0.9),
                        AppTokens.surface.withValues(alpha: 0.65),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppTokens.s16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppTokens.accent.withValues(
                                    alpha: 0.65,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppTokens.r999.r,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppTokens.s8.w),
                            Container(
                              width: 44,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppTokens.border,
                                borderRadius: BorderRadius.circular(
                                  AppTokens.r999.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppTokens.s16.h),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _PreviewBlock(
                                      widthFactor: 0.72,
                                      height: 18,
                                      color: AppTokens.accentBlue,
                                    ),
                                    SizedBox(height: AppTokens.s12.h),
                                    _PreviewBlock(
                                      widthFactor: 0.94,
                                      height: 12,
                                      color: AppTokens.borderStrong,
                                    ),
                                    SizedBox(height: AppTokens.s8.h),
                                    _PreviewBlock(
                                      widthFactor: 0.76,
                                      height: 12,
                                      color: AppTokens.borderStrong,
                                    ),
                                    SizedBox(height: AppTokens.s16.h),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            AppTokens.r16.r,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppTokens.accent.withValues(
                                                alpha: 0.26,
                                              ),
                                              AppTokens.accentBlue.withValues(
                                                alpha: 0.16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: AppTokens.s12.w),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            AppTokens.r16.r,
                                          ),
                                          color: AppTokens.bg.withValues(
                                            alpha: 0.55,
                                          ),
                                          border: Border.all(
                                            color: AppTokens.border.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            AppTokens.s12.w,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Impact',
                                                style: GoogleFonts.inter(
                                                  color: AppTokens.textMuted,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 1.4,
                                                ),
                                              ),
                                              SizedBox(height: AppTokens.s8.h),
                                              Text(
                                                project.impact,
                                                style: GoogleFonts.inter(
                                                  color: AppTokens.textPrimary,
                                                  fontSize: 12.sp,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const Spacer(),
                                              _MetricPill(label: 'Live'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: AppTokens.s12.h),
                                    _MiniList(emoji: project.emoji),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  final Color color;

  const _WindowDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _PreviewBlock extends StatelessWidget {
  final double widthFactor;
  final double height;
  final Color color;

  const _PreviewBlock({
    required this.widthFactor,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppTokens.r999.r),
        ),
      ),
    );
  }
}

class _MiniList extends StatelessWidget {
  final String emoji;

  const _MiniList({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTokens.s12.w),
      decoration: BoxDecoration(
        color: AppTokens.surfaceAlt.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(AppTokens.r16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppTokens.accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(AppTokens.r8.r),
            ),
            child: Center(
              child: Text(emoji, style: TextStyle(fontSize: 14.sp)),
            ),
          ),
          SizedBox(width: AppTokens.s8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MiniBar(widthFactor: 0.84),
                SizedBox(height: AppTokens.s6.h),
                _MiniBar(widthFactor: 0.62),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBar extends StatelessWidget {
  final double widthFactor;

  const _MiniBar({required this.widthFactor});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: AppTokens.border.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(AppTokens.r999.r),
        ),
      ),
    );
  }
}

class _ImpactRow extends StatelessWidget {
  final String impact;

  const _ImpactRow({required this.impact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTokens.s12.w,
        vertical: AppTokens.s10.h,
      ),
      decoration: BoxDecoration(
        color: AppTokens.bg.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppTokens.r12.r),
        border: Border.all(color: AppTokens.border.withValues(alpha: 0.7)),
      ),
      child: Text(
        impact,
        style: GoogleFonts.inter(
          color: AppTokens.textPrimary,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  final String label;

  const _MetricPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTokens.s10.w,
        vertical: AppTokens.s4.h,
      ),
      decoration: BoxDecoration(
        color: AppTokens.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTokens.r999.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: AppTokens.accent,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
