import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
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
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppTokens.s24),
        decoration: BoxDecoration(
          color: _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r16),
          border: Border.all(
            color: _hovered
                ? AppTokens.accent.withValues(alpha: 0.25)
                : AppTokens.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppTokens.accent.withValues(alpha: 0.05),
                    blurRadius: 40,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji + arrow row
            Row(
              children: [
                Text(p.emoji, style: const TextStyle(fontSize: 28)),
                const Spacer(),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _hovered ? 1 : 0.3,
                  child: Icon(
                    Icons.arrow_outward,
                    color: AppTokens.accent,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.s16),

            // Title
            Text(
              p.title,
              style: GoogleFonts.spaceGrotesk(
                color: AppTokens.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: AppTokens.s8),

            // Description
            Text(
              p.description,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: AppTokens.s16),

            // Tech chips
            Wrap(
              spacing: AppTokens.s4,
              runSpacing: AppTokens.s4,
              children: p.tech
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTokens.s8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTokens.bg,
                        borderRadius: BorderRadius.circular(AppTokens.r8),
                        border: Border.all(color: AppTokens.border),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.inter(
                          color: AppTokens.textMuted,
                          fontSize: 11,
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
