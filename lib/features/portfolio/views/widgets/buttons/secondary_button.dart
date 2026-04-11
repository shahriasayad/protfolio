import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';

/// Secondary button with border
class SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const SecondaryButton({required this.label, required this.onTap, super.key});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s32,
            vertical: AppTokens.s16,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
            borderRadius: BorderRadius.circular(AppTokens.r12),
            border: Border.all(
              color: _hovered
                  ? AppTokens.accent.withValues(alpha: 0.5)
                  : AppTokens.border.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: _hovered ? AppTokens.accent : AppTokens.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
