import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:my_portfolio/features/portfolio/models/achievement_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// Achievement card - displays achievement details
class AchievementCard extends StatefulWidget {
  final AchievementModel item;
  final bool isLast;
  const AchievementCard({super.key, required this.item, required this.isLast});

  @override
  State<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<AchievementCard> {
  bool _hovered = false;

  Future<void> _launchUrl() async {
    final messenger = ScaffoldMessenger.of(context);
    final Uri url = Uri.parse(widget.item.organizationUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                ? AppTokens.accent.withValues(alpha: 0.35)
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
            Text(
              widget.item.title,
              style: GoogleFonts.spaceGrotesk(
                color: AppTokens.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: AppTokens.s12.h),

            GestureDetector(
              onTap: _launchUrl,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  style: GoogleFonts.inter(
                    color: _hovered
                        ? AppTokens.accent
                        : AppTokens.textSecondary,
                    fontSize: 14.sp,
                    fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
                    decoration: _hovered
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                  child: Text(widget.item.organization),
                ),
              ),
            ),
            SizedBox(height: AppTokens.s16.h),

            Text(
              widget.item.description,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 14.sp,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
