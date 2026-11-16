import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_screen_util.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/buttons/email_button.dart';
import '../widgets/buttons/social_button.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/forms/contact_form.dart';

/// Contact section - closing invitation, trust signals, direct links, and form.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppScreenUtil.isDesktopWidth(width);

    return SectionWrapper(
      tone: SectionTone.tinted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '09',
            title: 'Contact',
            subtitle: 'Let\'s talk about what you\'re building.',
            description:
                'If you want a Flutter app, product build, or mobile experience that feels sharp and considered, let’s talk about the outcome you want to create.',
          ),
          const SizedBox(height: AppTokens.s36),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _ContactNarrative(ctrl: ctrl)),
                const SizedBox(width: AppTokens.s36),
                const Expanded(flex: 6, child: ContactForm()),
              ],
            )
          else ...[
            _ContactNarrative(ctrl: ctrl),
            const SizedBox(height: AppTokens.s28),
            const ContactForm(),
          ],
        ],
      ),
    );
  }
}

class _ContactNarrative extends StatelessWidget {
  final PortfolioController ctrl;

  const _ContactNarrative({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTokens.s24),
      decoration: BoxDecoration(
        color: AppTokens.surface,
        borderRadius: BorderRadius.circular(AppTokens.r12),
        border: Border.all(color: AppTokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Have a project in mind?\nLet's build the right version of it.",
            style: AppTextStyles.cardTitle(fontSize: 24),
          ),
          const SizedBox(height: AppTokens.s12),
          Text(
            ctrl.brandSummary,
            style: AppTextStyles.body(
              fontSize: 14,
              color: AppTokens.textSecondary,
            ),
          ),
          const SizedBox(height: AppTokens.s24),
          const _ContactTrustBullet(
            icon: Icons.schedule_outlined,
            title: 'Fast response',
            subtitle: 'Usually within 24–48 hours.',
          ),
          const SizedBox(height: AppTokens.s14),
          const _ContactTrustBullet(
            icon: Icons.verified_outlined,
            title: 'Clear communication',
            subtitle: 'Straightforward scope, no unnecessary back-and-forth.',
          ),
          const SizedBox(height: AppTokens.s14),
          const _ContactTrustBullet(
            icon: Icons.public_outlined,
            title: 'Remote-friendly',
            subtitle: 'Open to freelance and product-focused collaborations.',
          ),
          const SizedBox(height: AppTokens.s24),
          const Divider(height: 1, color: AppTokens.border),
          const SizedBox(height: AppTokens.s20),
          Obx(() => EmailButton(email: ctrl.email.value)),
          const SizedBox(height: AppTokens.s14),
          Wrap(
            spacing: AppTokens.s10,
            runSpacing: AppTokens.s10,
            children: ctrl.socials
                .map((s) => SocialButton(social: s))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ContactTrustBullet extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ContactTrustBullet({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppTokens.s8),
          decoration: BoxDecoration(
            color: AppTokens.accentSoft,
            borderRadius: BorderRadius.circular(AppTokens.r6),
          ),
          child: Icon(icon, color: AppTokens.accent, size: 15),
        ),
        const SizedBox(width: AppTokens.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.body(
                  fontSize: 14,
                  color: AppTokens.textPrimary,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: AppTokens.s2),
              Text(
                subtitle,
                style: AppTextStyles.body(
                  fontSize: 13,
                  color: AppTokens.textMuted,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
