import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/features/portfolio/models/social_link_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// Social button - clickable social link
class SocialButton extends StatefulWidget {
  final SocialLink social;
  const SocialButton({required this.social});

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _hovered = false;

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(widget.social.url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch ${widget.social.url}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s16,
            vertical: AppTokens.s12,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTokens.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTokens.r12),
            border: Border.all(
              color: _hovered ? AppTokens.border : AppTokens.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.social.icon,
                color: _hovered ? AppTokens.accent : AppTokens.textSecondary,
                size: 16,
              ),
              const SizedBox(width: AppTokens.s8),
              Text(
                widget.social.label,
                style: GoogleFonts.inter(
                  color: _hovered
                      ? AppTokens.textPrimary
                      : AppTokens.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
