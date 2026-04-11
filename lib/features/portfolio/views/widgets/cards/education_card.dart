import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/features/portfolio/models/education_model.dart';

/// Education card - displays education details
class EducationCard extends StatefulWidget {
  final EducationModel item;
  final bool isLast;
  const EducationCard({required this.item, required this.isLast});

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
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: widget.isLast ? 0 : AppTokens.s24),
        padding: const EdgeInsets.all(AppTokens.s24),
        decoration: BoxDecoration(
          color: _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r12),
          border: Border.all(
            color: _hovered
                ? accentColor.withValues(alpha: 0.4)
                : AppTokens.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.1),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTokens.s8),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppTokens.r8),
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
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        edu.field,
                        style: GoogleFonts.inter(
                          color: accentColor,
                          fontSize: 13,
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
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.s16),
            Text(
              edu.school,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTokens.s12),
            Text(
              edu.description,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
