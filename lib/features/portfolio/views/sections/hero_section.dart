import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import '../widgets/common/section_wrapper.dart';
import '../widgets/common/hero_image.dart';
import '../widgets/common/hero_text_content.dart';

/// Hero section - main introduction with name, title, CTA
class HeroSection extends StatefulWidget {
  final VoidCallback onHire;
  final VoidCallback onProjects;

  const HeroSection({
    super.key,
    required this.onHire,
    required this.onProjects,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  final _ctrl = Get.find<PortfolioController>();

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = CurvedAnimation(
      parent: _ac,
      curve: const Interval(0, 0.7, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic));
    _ac.forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMobile = MediaQuery.of(context).size.width < 640;

    return SectionWrapper(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 24.0,
        vertical: isMobile ? 64.0 : 96.0,
      ),
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left: Text content
                    Flexible(
                      flex: 1,
                      child: HeroTextContent(
                        ctrl: _ctrl,
                        onHire: widget.onHire,
                        onProjects: widget.onProjects,
                      ),
                    ),
                    const SizedBox(width: 96.0),
                    // Right: Image
                    Flexible(flex: 1, child: HeroImage(_ctrl)),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image first on mobile
                    if (!isMobile) HeroImage(_ctrl),
                    if (!isMobile) const SizedBox(height: 64.0),
                    // Text content
                    HeroTextContent(
                      ctrl: _ctrl,
                      onHire: widget.onHire,
                      onProjects: widget.onProjects,
                    ),
                    if (isMobile) const SizedBox(height: 48.0),
                    if (isMobile) Center(child: HeroImage(_ctrl)),
                  ],
                ),
        ),
      ),
    );
  }
}
