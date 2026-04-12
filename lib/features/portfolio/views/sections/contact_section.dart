import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/section_label.dart';
import '../widgets/buttons/email_button.dart';
import '../widgets/buttons/social_button.dart';
import '../widgets/forms/contact_form.dart';

/// Contact section - call to action and social links
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: 'Contact'),
          const SizedBox(height: AppTokens.s48),

          // Big CTA text
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "Have a project in mind?\nLet's talk.",
              style: GoogleFonts.spaceGrotesk(
                color: AppTokens.textPrimary,
                fontSize: 36,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
                height: 1.15,
              ),
            ),
          ),
          const SizedBox(height: AppTokens.s32),

          // Email link (clickable)
          Obx(() => EmailButton(email: ctrl.email.value)),
          const SizedBox(height: AppTokens.s32),

          // Social links
          Wrap(
            spacing: AppTokens.s12,
            runSpacing: AppTokens.s12,
            children: ctrl.socials.map((s) => SocialButton(social: s)).toList(),
          ),
          const SizedBox(height: AppTokens.s48),

          // Contact form
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: const ContactForm(),
          ),
        ],
      ),
    );
  }
}
