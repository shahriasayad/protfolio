import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../../../../core/constants/app_tokens.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/section_label.dart';

/// About section - bio/personal intro
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: 'About'),
          const SizedBox(height: AppTokens.s48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Obx(
              () => Text(
                ctrl.bio.value.trim(),
                style: GoogleFonts.inter(
                  color: AppTokens.textSecondary,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
