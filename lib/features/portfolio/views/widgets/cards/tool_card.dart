import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';

/// Tool card - displays development tool with icon
class ToolCard extends StatefulWidget {
  final String name;
  final String icon;
  final Color color;
  const ToolCard({required this.name, required this.icon, required this.color});

  @override
  State<ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<ToolCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.s24,
          vertical: AppTokens.s32,
        ),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.color.withValues(alpha: 0.08)
              : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r16),
          border: Border.all(
            color: _hovered
                ? widget.color.withValues(alpha: 0.4)
                : AppTokens.border,
            width: 2,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.13),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(AppTokens.r999),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(widget.icon, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: AppTokens.s16),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppTokens.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
