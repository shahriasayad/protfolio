import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

/// Hero text content - Name, title, intro, and CTAs
class HeroTextContent extends StatelessWidget {
  final PortfolioController ctrl;
  final VoidCallback onHire;
  final VoidCallback onProjects;

  const HeroTextContent({super.key, 
    required this.ctrl,
    required this.onHire,
    required this.onProjects,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 640;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name with animated gradient
        Obx(
          () => AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                ctrl.name.value,
                textStyle: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 48 : 64,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -1.5,
                ),
                colors: [
                  AppTokens.accent,
                  AppTokens.accentBlue,
                  AppTokens.accentPurple,
                  AppTokens.accentPink,
                ],
                speed: const Duration(milliseconds: 400),
              ),
            ],
            isRepeatingAnimation: true,
            pause: const Duration(milliseconds: 1200),
            displayFullTextOnTap: true,
          ),
        ),
        const SizedBox(height: AppTokens.s16),

        // Title with accent
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.s16,
              vertical: AppTokens.s8,
            ),
            decoration: BoxDecoration(
              color: AppTokens.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTokens.r12),
              border: Border.all(
                color: AppTokens.accent.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              ctrl.title.value,
              style: GoogleFonts.inter(
                color: AppTokens.accent,
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppTokens.s32),

        // Intro/Bio with typing animation
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Obx(
            () => AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  ctrl.intro.value,
                  textStyle: GoogleFonts.inter(
                    color: AppTokens.textSecondary,
                    fontSize: isMobile ? 16 : 18,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                  speed: const Duration(milliseconds: 38),
                  cursor: '|',
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
              pause: const Duration(milliseconds: 800),
            ),
          ),
        ),
        const SizedBox(height: AppTokens.s48),

        // CTA Buttons
        Wrap(
          spacing: AppTokens.s16,
          runSpacing: AppTokens.s16,
          children: [
            PrimaryButton(label: 'View My Work', onTap: onProjects),
            SecondaryButton(label: 'Get In Touch', onTap: onHire),
          ],
        ),
      ],
    );
  }
}
