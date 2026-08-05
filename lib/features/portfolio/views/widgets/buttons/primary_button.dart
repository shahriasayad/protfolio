import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';

/// Primary button with filled background
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.label, required this.onTap});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
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
            color: _hovered
                ? AppTokens.accent.withValues(alpha: 0.9)
                : AppTokens.accent,
            borderRadius: BorderRadius.circular(AppTokens.r12),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: AppTokens.bg,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
