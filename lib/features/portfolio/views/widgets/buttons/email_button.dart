import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:url_launcher/url_launcher.dart';

/// Email button - clickable email link
class EmailButton extends StatefulWidget {
  final String email;
  const EmailButton({super.key, required this.email});

  @override
  State<EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<EmailButton> {
  bool _hovered = false;

  Future<void> _launchEmail() async {
    final messenger = ScaffoldMessenger.of(context);
    final Uri emailUri = Uri(scheme: 'mailto', path: widget.email);
    if (!await launchUrl(emailUri)) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not launch email client')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launchEmail,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: GoogleFonts.inter(
            color: _hovered ? AppTokens.accent : AppTokens.textSecondary,
            fontSize: 16.sp,
            fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mail_outline,
                color: _hovered ? AppTokens.accent : AppTokens.textSecondary,
                size: 18,
              ),
              SizedBox(width: AppTokens.s8.w),
              Text(widget.email),
            ],
          ),
        ),
      ),
    );
  }
}
