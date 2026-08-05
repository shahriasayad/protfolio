import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
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
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: widget.isLast ? 0 : AppTokens.s24),
        padding: const EdgeInsets.all(AppTokens.s24),
        decoration: BoxDecoration(
          color: _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r12),
          border: Border.all(
            color: _hovered
                ? AppTokens.accent.withValues(alpha: 0.4)
                : AppTokens.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppTokens.accent.withValues(alpha: 0.1),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              widget.item.title,
              style: GoogleFonts.spaceGrotesk(
                color: AppTokens.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: AppTokens.s12),

            // Organization (clickable)
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
                    fontSize: 15,
                    fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
                    decoration: _hovered
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                  child: Text(widget.item.organization),
                ),
              ),
            ),
            const SizedBox(height: AppTokens.s16),

            // Description
            Text(
              widget.item.description,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
