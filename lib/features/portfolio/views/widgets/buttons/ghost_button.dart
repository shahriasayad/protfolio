import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';

/// Ghost button with transparent background
class GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const GhostButton({super.key, required this.label, required this.onTap});

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s24,
            vertical: AppTokens.s16,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTokens.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTokens.r12),
            border: Border.all(color: AppTokens.border),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: AppTokens.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
