import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/hero_image.dart';
import '../widgets/common/hero_text_content.dart';

/// Hero section - main introduction with name, title, CTA
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
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMobile = MediaQuery.of(context).size.width < 640;

    return SectionWrapper(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 24.0,
        vertical: isMobile ? 64.0 : 96.0,
      ),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 900),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, (1 - value) * 16),
              child: child,
            ),
          );
        },
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: HeroTextContent(
                      ctrl: ctrl,
                      onHire: onHire,
                      onProjects: onProjects,
                    ),
                  ),
                  const SizedBox(width: 96.0),
                  Flexible(flex: 1, child: HeroImage(ctrl)),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile) HeroImage(ctrl),
                  if (!isMobile) const SizedBox(height: 64.0),
                  HeroTextContent(
                    ctrl: ctrl,
                    onHire: onHire,
                    onProjects: onProjects,
                  ),
                  if (isMobile) const SizedBox(height: 48.0),
                  if (isMobile) Center(child: HeroImage(ctrl)),
                ],
              ),
      ),
    );
  }
}
