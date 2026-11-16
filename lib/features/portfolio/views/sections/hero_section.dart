import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/utils/app_screen_util.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/common/hero_image.dart';
import '../widgets/common/hero_text_content.dart';
import '../widgets/common/section_reveal.dart';
import '../widgets/common/section_wrapper.dart';

/// Hero section - primary developer introduction, CTA cluster, stats, and portrait frame.
class HeroSection extends StatelessWidget {
  final VoidCallback onHire;
  final VoidCallback onProjects;

  const HeroSection({
    super.key,
    required this.onHire,
    required this.onProjects,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppScreenUtil.isDesktopWidth(width);
    final isMobile = AppScreenUtil.isMobileWidth(width);

    return SectionWrapper(
      tone: SectionTone.base,
      showTopBorder: false,
      padding: EdgeInsets.fromLTRB(
        isMobile ? AppTokens.s20 : AppTokens.s32,
        isMobile ? AppTokens.s24 : AppTokens.s48,
        isMobile ? AppTokens.s20 : AppTokens.s32,
        isMobile ? AppTokens.s48 : AppTokens.s72,
      ),
      child: SectionReveal(
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 7,
                    child: HeroTextContent(
                      ctrl: ctrl,
                      onHire: onHire,
                      onProjects: onProjects,
                    ),
                  ),
                  const SizedBox(width: AppTokens.s48),
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: HeroImage(ctrl),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroTextContent(
                    ctrl: ctrl,
                    onHire: onHire,
                    onProjects: onProjects,
                  ),
                  const SizedBox(height: AppTokens.s36),
                  Center(child: HeroImage(ctrl)),
                ],
              ),
      ),
    );
  }
}
