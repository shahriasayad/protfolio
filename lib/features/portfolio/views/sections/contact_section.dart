import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/buttons/email_button.dart';
import '../widgets/buttons/social_button.dart';
import '../widgets/forms/contact_form.dart';

/// Contact section - call to action and social links
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final isWide = AppScreenUtil.screenWidth > 900;

    return SectionWrapper(
      tone: SectionTone.elevated,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortfolioSectionHeader(
            sectionIndex: '07',
            title: 'Contact',
            subtitle: 'A final CTA, not just a form.',
            description:
                'If you want a Flutter portfolio, product page, or mobile experience that feels more premium and considered, let’s talk about the outcome you want to create.',
          ),
          SizedBox(height: AppTokens.s48.h),
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ContactNarrative(ctrl: ctrl)),
                SizedBox(width: AppTokens.s24.w),
                Expanded(child: const ContactForm()),
              ],
            )
          else ...[
            _ContactNarrative(ctrl: ctrl),
            SizedBox(height: AppTokens.s24.h),
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
      padding: EdgeInsets.all(AppTokens.s16.w),
      decoration: BoxDecoration(
        color: AppTokens.surfaceGlass,
        borderRadius: BorderRadius.circular(AppTokens.r24.r),
        border: Border.all(
          color: AppTokens.borderStrong.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Have a project in mind?\nLet's build the right version of it.",
            style: GoogleFonts.spaceGrotesk(
              color: AppTokens.textPrimary,
              fontSize: 25.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.2,
              height: 1.1,
            ),
          ),
          SizedBox(height: AppTokens.s16.h),
          Text(
            ctrl.brandSummary,
            style: GoogleFonts.inter(
              color: AppTokens.textSecondary,
              fontSize: 13.sp,
              // height: 1.8,
            ),
          ),
          SizedBox(height: AppTokens.s24.h),
          _ContactTrustBullet(
            icon: Icons.schedule_outlined,
            title: 'Fast response',
            subtitle: 'Usually within 24–48 hours.',
          ),
          SizedBox(height: AppTokens.s12.h),
          _ContactTrustBullet(
            icon: Icons.verified_outlined,
            title: 'Clear communication',
            subtitle: 'Practical scope, thoughtful execution, no fluff.',
          ),
          SizedBox(height: AppTokens.s12.h),
          _ContactTrustBullet(
            icon: Icons.public_outlined,
            title: 'Open to remote work',
            subtitle: 'Selective freelance and product-focused collaborations.',
          ),
          SizedBox(height: AppTokens.s24.h),
          Obx(() => EmailButton(email: ctrl.email.value)),
          SizedBox(height: AppTokens.s20.h),
          Wrap(
            spacing: AppTokens.s12.w,
            runSpacing: AppTokens.s12.h,
            children: ctrl.socials.map((s) => SocialButton(social: s)).toList(),
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
          padding: EdgeInsets.all(AppTokens.s8.w),
          decoration: BoxDecoration(
            color: AppTokens.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppTokens.r8.r),
          ),
          child: Icon(icon, color: AppTokens.accent, size: 16),
        ),
        SizedBox(width: AppTokens.s12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: AppTokens.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppTokens.s4.h),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: AppTokens.textMuted,
                  fontSize: 12.sp,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
